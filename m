From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 22 Jan 2018 13:14:54 -0700
Subject: [PATCH v3 07/10] pert tools: Add queue management functionality
In-Reply-To: <59a63753-2343-db87-c4af-5011b404a3db@arm.com>
References: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
 <1516211539-5166-8-git-send-email-mathieu.poirier@linaro.org>
 <59a63753-2343-db87-c4af-5011b404a3db@arm.com>
Message-ID: <CANLsYkwbtriS9a+-nm5028xjbSxKpdwoem7Ero4wLz6pvism+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 January 2018 at 10:25, Robert Walker <robert.walker@arm.com> wrote:
>
>
> On 01/17/2018 05:52 PM, Mathieu Poirier wrote:
>>
>> Add functionatlity to setup trace queues so that traces associated with
>> CoreSight auxtrace events found in the perf.data file can be classified
>> properly.  The decoder and memory callback associated with each queue are
>> then used to decode the traces that have been assigned to that queue.
>>
>> Co-authored-by: Tor Jeremiassen <tor@ti.com>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>>   tools/perf/util/cs-etm.c | 208
>> ++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 204 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index cad429ce3c00..83eb676274b5 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -196,15 +196,215 @@ static void cs_etm__free(struct perf_session
>> *session)
>>         zfree(&aux);
>>   }
>>   +static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
>> +                             size_t size, u8 *buffer)
>> +{
>> +       u8  cpumode;
>> +       u64 offset;
>> +       int len;
>> +       struct   thread *thread;
>> +       struct   machine *machine;
>> +       struct   addr_location al;
>> +
>> +       if (!etmq)
>> +               return -1;
>> +
>> +       machine = etmq->etm->machine;
>> +       if (address >= etmq->etm->kernel_start)
>> +               cpumode = PERF_RECORD_MISC_KERNEL;
>> +       else
>> +               cpumode = PERF_RECORD_MISC_USER;
>> +
>> +       thread = etmq->thread;
>> +       if (!thread) {
>> +               if (cpumode != PERF_RECORD_MISC_KERNEL)
>> +                       return -EINVAL;
>> +               thread = etmq->etm->unknown_thread;
>> +       }
>> +
>> +       thread__find_addr_map(thread, cpumode, MAP__FUNCTION, address,
>> &al);
>> +
>> +       if (!al.map || !al.map->dso)
>> +               return 0;
>> +
>> +       if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR &&
>> +           dso__data_status_seen(al.map->dso,
>> DSO_DATA_STATUS_SEEN_ITRACE))
>> +               return 0;
>> +
>> +       offset = al.map->map_ip(al.map, address);
>> +
>> +       map__load(al.map);
>> +
>> +       len = dso__data_read_offset(al.map->dso, machine, offset, buffer,
>> size);
>> +
>> +       if (len <= 0)
>> +               return 0;
>> +
>> +       return len;
>> +}
>> +
>> +static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace
>> *etm,
>> +                                               unsigned int queue_nr)
>> +{
>> +       int i;
>> +       struct cs_etm_decoder_params d_params;
>> +       struct cs_etm_trace_params  *t_params;
>> +       struct cs_etm_queue *etmq;
>> +
>> +       etmq = zalloc(sizeof(*etmq));
>> +       if (!etmq)
>> +               return NULL;
>> +
>> +       etmq->event_buf = malloc(PERF_SAMPLE_MAX_SIZE);
>
>
> Should this and the other members of etmq alloc'd in this function be free'd
> in cs_etm__free_queue() as they were in the original version at
> https://github.com/Linaro/perf-opencsd/ ?  I can't see them getting freed
> anywhere else.

Quite right - it got lost in the refactoring.  Thanks for pointing this out.

Mathieu

>
>> +       if (!etmq->event_buf)
>> +               goto out_free;
>> +
>> +       etmq->etm = etm;
>> +       etmq->queue_nr = queue_nr;
>> +       etmq->pid = -1;
>> +       etmq->tid = -1;
>> +       etmq->cpu = -1;
>> +
>> +       /* Use metadata to fill in trace parameters for trace decoder */
>> +       t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
>> +
>> +       if (!t_params)
>> +               goto out_free;
>> +
>> +       for (i = 0; i < etm->num_cpu; i++) {
>> +               t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
>> +               t_params[i].etmv4.reg_idr0 =
>> etm->metadata[i][CS_ETMV4_TRCIDR0];
>> +               t_params[i].etmv4.reg_idr1 =
>> etm->metadata[i][CS_ETMV4_TRCIDR1];
>> +               t_params[i].etmv4.reg_idr2 =
>> etm->metadata[i][CS_ETMV4_TRCIDR2];
>> +               t_params[i].etmv4.reg_idr8 =
>> etm->metadata[i][CS_ETMV4_TRCIDR8];
>> +               t_params[i].etmv4.reg_configr =
>> +
>> etm->metadata[i][CS_ETMV4_TRCCONFIGR];
>> +               t_params[i].etmv4.reg_traceidr =
>> +
>> etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
>> +       }
>> +
>> +       /* Set decoder parameters to simply print the trace packets */
>> +       d_params.packet_printer = cs_etm__packet_dump;
>> +       d_params.operation = CS_ETM_OPERATION_DECODE;
>> +       d_params.formatted = true;
>> +       d_params.fsyncs = false;
>> +       d_params.hsyncs = false;
>> +       d_params.frame_aligned = true;
>> +       d_params.data = etmq;
>> +
>> +       etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params,
>> t_params);
>> +
>> +       zfree(&t_params);
>> +
>> +       if (!etmq->decoder)
>> +               goto out_free;
>> +
>> +       /*
>> +        * Register a function to handle all memory accesses required by
>> +        * the trace decoder library.
>> +        */
>> +       if (cs_etm_decoder__add_mem_access_cb(etmq->decoder,
>> +                                             0x0L, ((u64) -1L),
>> +                                             cs_etm__mem_access))
>> +               goto out_free_decoder;
>> +
>> +       etmq->offset = 0;
>> +
>> +       return etmq;
>> +
>> +out_free_decoder:
>> +       cs_etm_decoder__free(etmq->decoder);
>> +out_free:
>> +       zfree(&etmq->event_buf);
>> +       free(etmq);
>> +
>> +       return NULL;
>> +}
>> +
>> +static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>> +                              struct auxtrace_queue *queue,
>> +                              unsigned int queue_nr)
>> +{
>> +       struct cs_etm_queue *etmq = queue->priv;
>> +
>> +       if (list_empty(&queue->head) || etmq)
>> +               return 0;
>> +
>> +       etmq = cs_etm__alloc_queue(etm, queue_nr);
>> +
>> +       if (!etmq)
>> +               return -ENOMEM;
>> +
>> +       queue->priv = etmq;
>> +
>> +       if (queue->cpu != -1)
>> +               etmq->cpu = queue->cpu;
>> +
>> +       etmq->tid = queue->tid;
>> +
>> +       return 0;
>> +}
>> +
>> +static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>> +{
>> +       unsigned int i;
>> +       int ret;
>> +
>> +       for (i = 0; i < etm->queues.nr_queues; i++) {
>> +               ret = cs_etm__setup_queue(etm,
>> &etm->queues.queue_array[i], i);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
>> +{
>> +       if (etm->queues.new_data) {
>> +               etm->queues.new_data = false;
>> +               return cs_etm__setup_queues(etm);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int cs_etm__process_event(struct perf_session *session,
>>                                  union perf_event *event,
>>                                  struct perf_sample *sample,
>>                                  struct perf_tool *tool)
>>   {
>> -       (void) session;
>> -       (void) event;
>> -       (void) sample;
>> -       (void) tool;
>> +       int err = 0;
>> +       u64 timestamp;
>> +       struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>> +                                                  struct cs_etm_auxtrace,
>> +                                                  auxtrace);
>> +
>> +       /* Keep compiler happy */
>> +       (void)event;
>> +
>> +       if (dump_trace)
>> +               return 0;
>> +
>> +       if (!tool->ordered_events) {
>> +               pr_err("CoreSight ETM Trace requires ordered events\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (!etm->timeless_decoding)
>> +               return -EINVAL;
>> +
>> +       if (sample->time && (sample->time != (u64) -1))
>> +               timestamp = sample->time;
>> +       else
>> +               timestamp = 0;
>> +
>> +       if (timestamp || etm->timeless_decoding) {
>> +               err = cs_etm__update_queues(etm);
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>>         return 0;
>>   }
>>
