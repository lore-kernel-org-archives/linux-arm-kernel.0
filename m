From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Nov 2018 09:53:41 -0700
Subject: [PATCH v2 2/2] perf cs-etm: Add support sample flags
In-Reply-To: <20181119232202.GA7001@xps15>
References: <1541912876-20967-1-git-send-email-leo.yan@linaro.org>
 <1541912876-20967-3-git-send-email-leo.yan@linaro.org>
 <20181119232202.GA7001@xps15>
Message-ID: <CANLsYkxQVpSP1D2M_bCni=nkZyo4qC=d33bWC1Xy0_vDfX9Agg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Nov 2018 at 16:22, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Sun, Nov 11, 2018 at 01:07:56PM +0800, Leo Yan wrote:
> > We have prepared the flags in the packet structure, so need to copy
> > the related value into sample structure thus perf tool can facilitate
> > sample flags.
> >
> > The PREV_PACKET contains the branch instruction flags and PACKET
> > actually contains the flags for next branch instruction.  So this patch
> > is to set sample flags with 'etmq->prev_packet->flags'.
> >
> > This patch includes three fixing up for sample flags based on the
> > packets context:
> >
> > - If the packet is exception packet or exception return packet, update
> >   the previous packet for exception specific flags;
> > - If there has TRACE_ON or TRACE_OFF packet in the middle of instruction
> >   packets, this indicates the trace is discontinuous, so append the flag
> >   PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
> >   has been ended;
> > - If one instruction packet is behind TRACE_OFF packet, this instruction
> >   is restarting trace packet.  So set flag PERF_IP_FLAG_TRACE_START to
> >   TRACE_OFF packet if one, this flag isn't used by TRACE_OFF packet but
> >   used to indicate trace restarting when generate sample.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/cs-etm.c | 43 +++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 455f132..afca6f3 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -676,7 +676,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
> >       sample.stream_id = etmq->etm->instructions_id;
> >       sample.period = period;
> >       sample.cpu = etmq->packet->cpu;
> > -     sample.flags = 0;
> > +     sample.flags = etmq->prev_packet->flags;
> >       sample.insn_len = 1;
> >       sample.cpumode = event->sample.header.misc;
> >
> > @@ -735,7 +735,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
> >       sample.stream_id = etmq->etm->branches_id;
> >       sample.period = 1;
> >       sample.cpu = etmq->packet->cpu;
> > -     sample.flags = 0;
> > +     sample.flags = etmq->prev_packet->flags;
> >       sample.cpumode = event->sample.header.misc;
> >
> >       /*
> > @@ -878,6 +878,43 @@ static int cs_etm__synth_events(struct cs_etm_auxtrace *etm,
> >       return 0;
> >  }
> >
> > +static void cs_etm__fixup_flags(struct cs_etm_queue *etmq)
> > +{
> > +     /*
> > +      * Decoding stream might insert one TRACE_OFF packet in the
> > +      * middle of instruction packets, this means it doesn't
> > +      * contain the pair packets with TRACE_OFF and TRACE_ON.
> > +      * For this case, the instruction packet follows with
> > +      * TRACE_OFF packet so we need to fixup prev_packet with flag
> > +      * PERF_IP_FLAG_TRACE_BEGIN, this flag finally is used by the
> > +      * instruction packet to generate samples.
> > +      */
> > +     if (etmq->prev_packet->sample_type == CS_ETM_TRACE_OFF &&
> > +         etmq->packet->sample_type == CS_ETM_RANGE)
> > +             etmq->prev_packet->flags = PERF_IP_FLAG_BRANCH |
> > +                                        PERF_IP_FLAG_TRACE_BEGIN;
> > +
> > +     if (etmq->prev_packet->sample_type == CS_ETM_RANGE) {
> > +             /*
> > +              * When the exception packet is inserted, update flags
> > +              * so tell perf it is exception related branches.
> > +              */
> > +             if (etmq->packet->sample_type == CS_ETM_EXCEPTION ||
> > +                 etmq->packet->sample_type == CS_ETM_EXCEPTION_RET)
> > +                     etmq->prev_packet->flags = etmq->packet->flags;
> > +
> > +             /*
> > +              * The trace is discontinuous, weather this is caused by
> > +              * TRACE_ON packet or TRACE_OFF packet is coming, if the
> > +              * previous packet is instruction packet, simply set flag
> > +              * PERF_IP_FLAG_TRACE_END for previous packet.
> > +              */
> > +             if (etmq->packet->sample_type == CS_ETM_TRACE_ON ||
> > +                 etmq->packet->sample_type == CS_ETM_TRACE_OFF)
> > +                     etmq->prev_packet->flags |= PERF_IP_FLAG_TRACE_END;
> > +     }
> > +}
> > +
>
> I think it would be better to keep all the flag related processing in
> cs-etm-decoder.c so that things in cs-etm.c are only concered with dealing with
> perf.
>
> Look at function cs_etm__alloc_queue(), there you'll find "d_params.data = etmq".
>
> In function cs_etm_decoder__new(), decoder->data = d_params->data;
>
> This means that anywhere you have a decoder, decoder->data is an etmq.  I've
> used this profusely in my work on CPU-wide trace scenarios.  Because you're
> getting there ahead of me you'll need to fix the declaration of struct
> cs_etm_queue but that's easy.

I've been thinking further about this and manipulating the etmq packet
and prev_packet from the cs-etm-decoder.c won't work because all we
have at that time is the decoder's packet queue.  My goal is to
manipulate the flags in only one place - either in cs-etm.c or
cs-etm-decoder.c but not in both.  It might be worth trying to do the
implementation in cs-etm.c since there is already a lot of packet flow
intelligence happening there.

>
> Regards,
> Mathieu
>
> >  static int cs_etm__sample(struct cs_etm_queue *etmq)
> >  {
> >       struct cs_etm_auxtrace *etm = etmq->etm;
> > @@ -1100,6 +1137,8 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
> >                                        */
> >                                       break;
> >
> > +                             cs_etm__fixup_flags(etmq);
> > +
> >                               switch (etmq->packet->sample_type) {
> >                               case CS_ETM_RANGE:
> >                                       /*
> > --
> > 2.7.4
> >
