From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 10 Jan 2018 13:16:28 -0700
Subject: [PATCH 05/10] perf tools: Add support for decoding CoreSight
 trace data
In-Reply-To: <20180110055926.GE16554@leoy-linaro>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
 <1513356299-26274-6-git-send-email-mathieu.poirier@linaro.org>
 <20171230003359.GD600@leoy-linaro>
 <CAJ9a7VjEdu9gsTw9eLhLJnfjxewZHAr4k-DELMPk3zoG=ZPj6g@mail.gmail.com>
 <20180110055926.GE16554@leoy-linaro>
Message-ID: <CANLsYkybK2omB2T8LJwOE5paHCKyChTTbD=ygew9vvsvcw6t8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2018 at 22:59, Leo Yan <leo.yan@linaro.org> wrote:
> Hi Mike,
>
> On Tue, Jan 09, 2018 at 12:09:58PM +0000, Mike Leach wrote:
>> Hi Leo,
>>
>> The OCSD_GEN_TRC_ELEM_ADDR_NACC element indicates that the decoder
>> does not have an code image mapping for the address contained in the
>> trace, at the location described by this element. the payload for the
>> NACC element is the memory location it could not address.
>> This means that it cannot correctly follow the instruction execution
>> sequence described by the individual trace packets.
>>
>> The dump option works because we do not need to follow the execution
>> sequence to dump raw trace packets.
>>
>> It is not clear to me if the perf script option as you specified is
>> mapping the vmlinux image into the decoder.
>
> I only can say that the 'perf script' has loaded symbol list by the
> option '--kallsyms ./System.map'.  Here have one corner case is for
> option '-k vmlinux', at my side I build 'perf' tool without linking
> libelf, so perf cannot directly parse kernel symbol.  If the perf
> tool is built with linking libelf, then we can directly load kernel
> symbol mapping from vmlinux and don't need specifiy option
> '--kallsyms ./System.map' anymore.
>
> Could you point which perf code will pass vmlinux mapping to the
> decoder? I don't know this before.  After some debugging I only found
> perf relies on OpenCSD to return back OCSD_GEN_TRC_ELEM_INSTR_RANGE
> and then perf will do symbol/sym_off analysis, otherwise it will skip
> symbol analysis.

I have hit this problem before when trying to decode kernel traces.
When using the --kallsyms option the kernel's base address isn't
correctly set and from there no symbols can be decoded (the same
happens on PT).  Looking into the root cause of the problem is on my
(long) list of things to do.  In the mean time try with only the -k
vmlinux option and see how far that gets you.

Mathieu

>
> BTW, I use the same 'perf script' command with OpenCSD v0.7.5, it
> can return back OCSD_GEN_TRC_ELEM_INSTR_RANGE but not
> OCSD_GEN_TRC_ELEM_ADDR_NACC so it can print out kernel symbol, this
> is for using the same perf.data and vmlinux files.
>
> Thanks,
> Leo Yan
>
>> On 30 December 2017 at 00:33, Leo Yan <leo.yan@linaro.org> wrote:
>> > Hi Mathieu, Mike,
>> >
>> > On Fri, Dec 15, 2017 at 09:44:54AM -0700, Mathieu Poirier wrote:
>> >> Adding functionality to create a CoreSight trace decoder capable
>> >> of decoding trace data pushed by a client application.
>> >>
>> >> Co-authored-by: Tor Jeremiassen <tor@ti.com>
>> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> >> ---
>> >>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 119 ++++++++++++++++++++++++
>> >>  1 file changed, 119 insertions(+)
>> >>
>> >> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> >> index 6a4c86b1431f..57b020b0b36f 100644
>> >> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> >> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>> >> @@ -200,6 +200,121 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>> >>       }
>> >>  }
>> >>
>> >> +static ocsd_datapath_resp_t
>> >> +cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>> >> +                           const ocsd_generic_trace_elem *elem,
>> >> +                           const u8 trace_chan_id,
>> >> +                           enum cs_etm_sample_type sample_type)
>> >> +{
>> >> +     u32 et = 0;
>> >> +     struct int_node *inode = NULL;
>> >> +
>> >> +     if (decoder->packet_count >= MAX_BUFFER - 1)
>> >> +             return OCSD_RESP_FATAL_SYS_ERR;
>> >> +
>> >> +     /* Search the RB tree for the cpu associated with this traceID */
>> >> +     inode = intlist__find(traceid_list, trace_chan_id);
>> >> +     if (!inode)
>> >> +             return OCSD_RESP_FATAL_SYS_ERR;
>> >> +
>> >> +     et = decoder->tail;
>> >> +     decoder->packet_buffer[et].sample_type = sample_type;
>> >> +     decoder->packet_buffer[et].start_addr = elem->st_addr;
>> >> +     decoder->packet_buffer[et].end_addr = elem->en_addr;
>> >> +     decoder->packet_buffer[et].exc = false;
>> >> +     decoder->packet_buffer[et].exc_ret = false;
>> >> +     decoder->packet_buffer[et].cpu = *((int *)inode->priv);
>> >> +
>> >> +     /* Wrap around if need be */
>> >> +     et = (et + 1) & (MAX_BUFFER - 1);
>> >> +
>> >> +     decoder->tail = et;
>> >> +     decoder->packet_count++;
>> >> +
>> >> +     if (decoder->packet_count == MAX_BUFFER - 1)
>> >> +             return OCSD_RESP_WAIT;
>> >> +
>> >> +     return OCSD_RESP_CONT;
>> >> +}
>> >> +
>> >> +static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
>> >> +                             const void *context,
>> >> +                             const ocsd_trc_index_t indx __maybe_unused,
>> >> +                             const u8 trace_chan_id __maybe_unused,
>> >> +                             const ocsd_generic_trace_elem *elem)
>> >> +{
>> >> +     ocsd_datapath_resp_t resp = OCSD_RESP_CONT;
>> >> +     struct cs_etm_decoder *decoder = (struct cs_etm_decoder *) context;
>> >
>> > After apply this patch set and build 'perf' tool with linking
>> > OpenCSDv0.8.0 libs, I can everytime OpenCSD parses 'elem->elem_type'
>> > is OCSD_GEN_TRC_ELEM_ADDR_NACC but not OCSD_GEN_TRC_ELEM_INSTR_RANGE.
>> >
>> > As result, the 'perf' tool can dump the raw data with '-D' option but
>> > it cannot analyze the symbol and symbol offset with below command:
>> >
>> > ./perf script -v -a -F cpu,event,ip,sym,symoff -i ./perf.data -k vmlinux
>> > --kallsyms ./System.map
>> >
>> > Have uploaded perf.data/vmlinux/System.map in the folder:
>> > http://people.linaro.org/~leo.yan/binaries/perf_4.15_r4/
>> >
>> > Thanks,
>> > Leo Yan
>> >
>> >> +     switch (elem->elem_type) {
>> >> +     case OCSD_GEN_TRC_ELEM_UNKNOWN:
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_NO_SYNC:
>> >> +             decoder->trace_on = false;
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_TRACE_ON:
>> >> +             decoder->trace_on = true;
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_INSTR_RANGE:
>> >> +             resp = cs_etm_decoder__buffer_packet(decoder, elem,
>> >> +                                                  trace_chan_id,
>> >> +                                                  CS_ETM_RANGE);
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_EXCEPTION:
>> >> +             decoder->packet_buffer[decoder->tail].exc = true;
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
>> >> +             decoder->packet_buffer[decoder->tail].exc_ret = true;
>> >> +             break;
>> >> +     case OCSD_GEN_TRC_ELEM_PE_CONTEXT:
>> >> +     case OCSD_GEN_TRC_ELEM_EO_TRACE:
>> >> +     case OCSD_GEN_TRC_ELEM_ADDR_NACC:
>> >> +     case OCSD_GEN_TRC_ELEM_TIMESTAMP:
>> >> +     case OCSD_GEN_TRC_ELEM_CYCLE_COUNT:
>> >> +     case OCSD_GEN_TRC_ELEM_ADDR_UNKNOWN:
>> >> +     case OCSD_GEN_TRC_ELEM_EVENT:
>> >> +     case OCSD_GEN_TRC_ELEM_SWTRACE:
>> >> +     case OCSD_GEN_TRC_ELEM_CUSTOM:
>> >> +     default:
>> >> +             break;
>> >> +     }
>> >> +
>> >> +     return resp;
>> >> +}
>> >> +
>> >> +static int cs_etm_decoder__create_etm_packet_decoder(
>> >> +                                     struct cs_etm_trace_params *t_params,
>> >> +                                     struct cs_etm_decoder *decoder)
>> >> +{
>> >> +     const char *decoder_name;
>> >> +     ocsd_etmv4_cfg trace_config_etmv4;
>> >> +     void *trace_config;
>> >> +     u8 csid;
>> >> +
>> >> +     switch (t_params->protocol) {
>> >> +     case CS_ETM_PROTO_ETMV4i:
>> >> +             cs_etm_decoder__gen_etmv4_config(t_params, &trace_config_etmv4);
>> >> +             decoder_name = OCSD_BUILTIN_DCD_ETMV4I;
>> >> +             trace_config = &trace_config_etmv4;
>> >> +             break;
>> >> +     default:
>> >> +             return -1;
>> >> +     }
>> >> +
>> >> +     if (ocsd_dt_create_decoder(decoder->dcd_tree,
>> >> +                                  decoder_name,
>> >> +                                  OCSD_CREATE_FLG_FULL_DECODER,
>> >> +                                  trace_config, &csid))
>> >> +             return -1;
>> >> +
>> >> +     if (ocsd_dt_set_gen_elem_outfn(decoder->dcd_tree,
>> >> +                                    cs_etm_decoder__gen_trace_elem_printer,
>> >> +                                    decoder))
>> >> +             return -1;
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >>  static int
>> >>  cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>> >>                                  struct cs_etm_trace_params *t_params,
>> >> @@ -208,6 +323,10 @@ cs_etm_decoder__create_etm_decoder(struct cs_etm_decoder_params *d_params,
>> >>       if (d_params->operation == CS_ETM_OPERATION_PRINT)
>> >>               return cs_etm_decoder__create_etm_packet_printer(t_params,
>> >>                                                                decoder);
>> >> +     else if (d_params->operation == CS_ETM_OPERATION_DECODE)
>> >> +             return cs_etm_decoder__create_etm_packet_decoder(t_params,
>> >> +                                                              decoder);
>> >> +
>> >>       return -1;
>> >>  }
>> >>
>> >> --
>> >> 2.7.4
>> >>
>> >
>> > _______________________________________________
>> > linux-arm-kernel mailing list
>> > linux-arm-kernel at lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>
>>
>> --
>> Mike Leach
>> Principal Engineer, ARM Ltd.
>> Blackburn Design Centre. UK
