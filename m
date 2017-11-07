From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 7 Nov 2017 08:46:54 -0700
Subject: [PATCH 17/17] coresight perf: Add ETR backend support for etm-perf
In-Reply-To: <CAJ9a7Vjma2kgtFts-Nq+3=r9kdZ-X0pFpst5eY9f0s9+V1oASQ@mail.gmail.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
 <20171019171553.24056-18-suzuki.poulose@arm.com>
 <20171107002404.GC12148@xps15>
 <1188dd39-3f03-777b-7930-9e16edd04b99@arm.com>
 <CAJ9a7Vjma2kgtFts-Nq+3=r9kdZ-X0pFpst5eY9f0s9+V1oASQ@mail.gmail.com>
Message-ID: <CANLsYkxyf6LUjGtWmqGZT-ScXmCYQ2R3v1vK3-QHBiM7t4ZnyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 November 2017 at 08:17, Mike Leach <mike.leach@linaro.org> wrote:
> Hi Suzuki, Mathieu,
>
> A follow up on Dragonboard issues...
>
> =====
>  Using Suzukis debug code and some of my own home spun updates I've
> got the following logging out of a typical ETR-SG session from the
> DB410.
> Session initiated using command line
> './perf record -e cs_etm/@826000.etr/ --per-thread sort'
>
> root at linaro-developer:~# [  122.075896] tmc_etr_sg_table_dump:455:
> Table base; Vaddr:ffffff800978d000; DAddr:0xb10b1000; Table Pages 1;
> Table Entries 1024
> [  122.075932] tmc_etr_sg_table_dump:462: 00000: ffffff800978d000:[N] 0xb14b0000
> [  122.086281] tmc_etr_sg_table_dump:462: 00001: ffffff800978d004:[N] 0xb14b1000
> [  122.093410] tmc_etr_sg_table_dump:462: 00002: ffffff800978d008:[N] 0xb14b2000
> ----- snip -----
> [  129.438535] tmc_etr_sg_table_dump:462: 01021: ffffff800978dff4:[N] 0xb10ad000
> [  129.445741] tmc_etr_sg_table_dump:475: 01022: ###
> ffffff800978dff8:[L] 0xb10ae000 ###
> [  129.452945] tmc_etr_sg_table_dump:479: 01023: empty line
> [  129.460840] tmc_etr_sg_table_dump:485: ******* End of Table *****
> [  129.466333] tmc_etr_alloc_sg_buf:822: coresight-tmc 826000.etr: ETR
> - alloc SG buffer
>
> == SG table looks fine - I've removed the last circular link used for
> rotating the table as that is not happening anyway and wanted to
> eliminate it as an issue
>
> == first pass trace capture - long running program
>
> [  129.481359] tmc_etr_enable_hw:1239:  Set DBA 0xb10b1000; AXICTL 0x000007bd
> [  129.484297] tmc_etr_enable_hw:1260: exit()
> [  129.491251] tmc_enable_etf_link:306: coresight-tmc 825000.etf:
> TMC-ETF enabled
> [  129.794350] tmc_sync_etr_buf:1124: enter()
> [  129.794377] tmc_sync_etr_buf:1131: ETR regs: RRP=0xb14b0000,
> RWP=0xB14B0000, STS=0x0000003C:full=false
>
> == this shows the data page values for the first SG page from the
> table have been loaded into the RRP / RWP registers. Indication that
> the
> == SG table has been read. However status indicates that the buffer is
> empty, and that the AXI bus has returned an error (bit 5). (messing
> with permissions made no difference)
> == Error ignored by the driver (but I think the system is
> irretrievably broken now anyway).
>
> [  129.794383] tmc_etr_sync_sg_buf:849: enter()
> [  129.806616] tmc_etr_sync_sg_buf:876: WARNING: Buffer Data Len == 0;
> force sync some pages
> [  129.811051] tmc_etr_sync_sg_buf:881: exit()
> [  129.819116] tmc_etr_sg_dump_pages:505: PG(0) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.823112] tmc_etr_sg_dump_pages:505: PG(1) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.829709] tmc_etr_sg_dump_pages:505: PG(2) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.836133] tmc_etr_sg_dump_pages:505: PG(3) : 0xcdcdcdcd::0xcdcdcdcd
>
> == 1st 4 pages were pre-filled - seem untouched
>
> [  129.842556] tmc_sync_etr_buf:1143: exit()
> [  129.848977] tmc_etr_sync_perf_buffer:1635: sync_perf 16384 bytes
> [  129.853016] tmc_etf_print_regs_debug:37: TMC-ETF regs; RRP:0xF20
> RWP:0xF20; Status:0x10
>
> == ETF - operating as a FIFO link has recieved data and has been
> emptied - so the trace system has been running.
>
> [  129.859058] tmc_disable_etf_link:327: coresight-tmc 825000.etf:
> TMC-ETF disabled
> [  129.866778] tmc_etr_disable_hw:1322: enter()
> [  129.874410] tmc_etr_disable_hw:1336: exit()
> [  129.878666] tmc_disable_etr_sink:1815: coresight-tmc 826000.etr:
> TMC-ETR disabled
>
> == At this point we have the AXI bus errored out, and apparently no
> trace sent to the ETR memory.
>
> == Second pass - perf tries to restart the trace.
>
> [  129.882636] tmc_etr_enable_hw:1197: enter()
> [  129.890230] tmc_etr_enable_hw:1239:  Set DBA 0xb10b1000; AXICTL 0x000007bd
> [  129.894205] tmc_etr_enable_hw:1260: exit()
> [  129.901157] tmc_enable_etf_link:306: coresight-tmc 825000.etf:
> TMC-ETF enabled
> [  129.922498] coresight-tmc 826000.etr: timeout while waiting for
> completion of Manual Flush
> [  129.922672] coresight-tmc 826000.etr: timeout while waiting for TMC
> to be Ready
> [  129.929645] tmc_sync_etr_buf:1124: enter()
> [  129.936850] tmc_sync_etr_buf:1131: ETR regs: RRP=0xb10b1000,
> RWP=0xB10B1000, STS=0x00000010:full=false
>
> == this is bad - somehow the ETR regs have been set to the table base
> address, not the data page base address. No apparent AXI bus fault at
> this point,
> == but it is likely that the restart cleared the bit and the AXI is no
> longer responding.
>
> [  129.936856] tmc_etr_sync_sg_buf:849: enter()
> [  129.950311] coresight-tmc 826000.etr: Unable to map RRP b10b1000 to offset
>
> == driver error in response to invalid RRP value
>
> [  129.954733] tmc_etr_sg_dump_pages:505: PG(0) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.961417] tmc_etr_sg_dump_pages:505: PG(1) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.967928] tmc_etr_sg_dump_pages:505: PG(2) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.974350] tmc_etr_sg_dump_pages:505: PG(3) : 0xcdcdcdcd::0xcdcdcdcd
> [  129.980772] tmc_sync_etr_buf:1143: exit()
> [  129.987194] tmc_etr_sync_perf_buffer:1635: sync_perf 0 bytes
> [  129.991201] tmc_etf_print_regs_debug:37: TMC-ETF regs; RRP:0x1C0
> RWP:0x1C0; Status:0x1
>
> == ETF is full - still trying to collect trace data.
>
> [  129.997066] coresight-tmc 825000.etf: timeout while waiting for
> completion of Manual Flush
> [  130.004789] coresight-tmc 825000.etf: timeout while waiting for TMC
> to be Ready
> [  130.012896] tmc_disable_etf_link:327: coresight-tmc 825000.etf:
> TMC-ETF disabled
> [  130.020099] tmc_etr_disable_hw:1322: enter()
> [  130.027879] coresight-tmc 826000.etr: timeout while waiting for
> completion of Manual Flush
> [  130.032135] coresight-tmc 826000.etr: timeout while waiting for TMC
> to be Ready
>
> == flushing not working at any point in the system here - probably due
> to incorrect ETR operation - can't flush if downstream not accepting
> data.
>
> [  130.040062] tmc_etr_disable_hw:1336: exit()
> [  130.047266] tmc_disable_etr_sink:1815: coresight-tmc 826000.etr:
> TMC-ETR disabled
>
> == Beyond this point, things pretty much repeat, but other systems
> start failing too - missing interrupts etc.
> == Symptoms would seem to indicate a locked out AXI bus - but that is
> pure speculation.
> == Eventually, the system automatically reboots itself - some watchdog
> element I guess.
>
> =====
>
> Conclusion:-
>
> At this point ETR-SG is non-operational for unknown reasons - likely a
> memory system issue. Whether this is software config or hardware fault
> is not known at this point.
> However - this does raise the question about upstreaming this
> patchset. As it stands it will break existing ETR functionality on
> DB410c (and possibly HiKey 960).
> Currently the patchset decides on flat mapped / SG on buffer size. I
> would like to see a parameter added, something like SG threshold size,
> above which the implementation will choose SG, and below it will
> choose flat mapped. There also needs to be a special value - 0/-1
> where SG is always disabled for the device. If the parameter is
> available in device tree and sysfs then it will give the control
> needed should the ETR-SG issue with the current non-operational
> platforms turn out to be insurmountable. At the very least it will
> allow the current patchset to be implemented in a way that can
> preserve what is currently working till a solution is found.

Right, the patchset won't go upstream if it break things.  Before
thinking about mitigation factors I'd like to see what the root cause
of the problem is - when we have that we can discuss the best way to
go around it.

>
> Regards
>
> Mike
>
>
> On 7 November 2017 at 10:52, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 07/11/17 00:24, Mathieu Poirier wrote:
>>>
>>> On Thu, Oct 19, 2017 at 06:15:53PM +0100, Suzuki K Poulose wrote:
>>>>
>>>> Add necessary support for using ETR as a sink in ETM perf tracing.
>>>> We try make the best use of the available modes of buffers to
>>>> try and avoid software double buffering.
>>>>
>>>> We can use the perf ring buffer for ETR directly if all of the
>>>> conditions below are met :
>>>>   1) ETR is DMA coherent
>>>>   2) perf is used in snapshot mode. In full tracing mode, we cannot
>>>>      guarantee that the ETR will stop before it overwrites the data
>>>>      which may not have been consumed by the user.
>>>>   3) ETR supports save-restore with a scatter-gather mechanism
>>>>      which can use a given set of pages we use the perf ring buffer
>>>>      directly. If we have an in-built TMC ETR Scatter Gather unit,
>>>>      we make use of a circular SG list to restart from a given head.
>>>>      However, we need to align the starting offset to 4K in this case.
>>>>
>>>> If the ETR doesn't support either of this, we fallback to software
>>>> double buffering.
>>>>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>>
>>
>>>>
>>>> +/*
>>>> + * etr_perf_buffer - Perf buffer used for ETR
>>>> + * @etr_buf            - Actual buffer used by the ETR
>>>> + * @snaphost           - Perf session mode
>>>> + * @head               - handle->head at the beginning of the session.
>>>> + * @nr_pages           - Number of pages in the ring buffer.
>>>> + * @pages              - Pages in the ring buffer.
>>>> + * @flags              - Capabilities of the hardware buffer used in the
>>>> + *                       session. If flags == 0, we use software double
>>>> + *                       buffering.
>>>> + */
>>>> +struct etr_perf_buffer {
>>>> +       struct etr_buf          *etr_buf;
>>>> +       bool                    snapshot;
>>>> +       unsigned long           head;
>>>> +       int                     nr_pages;
>>>> +       void                    **pages;
>>>> +       u32                     flags;
>>>> +};
>>>
>>>
>>> Please move this to the top, just below the declaration for etr_sg_table.
>>
>>
>> Sure.
>>
>>
>>
>>>> +
>>>> +/*
>>>> + * XXX: What is the expected behavior here in the following cases ?
>>>> + *  1) Full trace mode, without double buffering : What should be the
>>>> size
>>>> + *     reported back when the buffer is full and has wrapped around.
>>>> Ideally,
>>>> + *     we should report for the lost trace to make sure the "head" in
>>>> the ring
>>>> + *     buffer comes back to the position as in the trace buffer, rather
>>>> than
>>>> + *     returning "total size" of the buffer.
>>>> + * 2) In snapshot mode, should we always return "full buffer size" ?
>>>> + */
>>>> +static unsigned long
>>>> +tmc_etr_update_perf_buffer(struct coresight_device *csdev,
>>>> +                          struct perf_output_handle *handle,
>>>> +                          void *config)
>>>> +{
>>>> +       bool double_buffer, lost = false;
>>>> +       unsigned long flags, offset, size = 0;
>>>> +       struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>>> +       struct etr_perf_buffer *etr_perf = config;
>>>> +       struct etr_buf *etr_buf = etr_perf->etr_buf;
>>>> +
>>>> +       double_buffer = (etr_perf->flags == 0);
>>>> +
>>>> +       spin_lock_irqsave(&drvdata->spinlock, flags);
>>>> +       if (WARN_ON(drvdata->perf_data != etr_perf)) {
>>>> +               lost = true;
>>>
>>>
>>> If we are here something went seriously wrong - I don't think much more
>>> can be
>>> done other than a WARN_ON()...
>>>
>>
>> right. I will do it for the case below as well.
>>
>>>>   static int tmc_enable_etr_sink_perf(struct coresight_device *csdev)
>>>>   {
>>
>> ...
>>>>
>>>> +
>>>> +       etr_perf = drvdata->perf_data;
>>>> +       if (!etr_perf || !etr_perf->etr_buf) {
>>>> +               rc = -EINVAL;
>>>
>>>
>>> This is a serious malfunction - I would WARN_ON() before unlocking.
>>>
>>
>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h
>>>> b/drivers/hwtracing/coresight/coresight-tmc.h
>>>> index 2c5b905b6494..06386ceb7866 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tmc.h
>>>> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
>>>> @@ -198,6 +198,7 @@ struct etr_buf {
>>>>    * @trigger_cntr: amount of words to store after a trigger.
>>>>    * @etr_caps: Bitmask of capabilities of the TMC ETR, inferred from the
>>>>    *            device configuration register (DEVID)
>>>> + * @perf_data: PERF buffer for ETR.
>>>>    * @sysfs_data:       SYSFS buffer for ETR.
>>>>    */
>>>>   struct tmc_drvdata {
>>>> @@ -219,6 +220,7 @@ struct tmc_drvdata {
>>>>         u32                     trigger_cntr;
>>>>         u32                     etr_caps;
>>>>         struct etr_buf          *sysfs_buf;
>>>> +       void                    *perf_data;
>>>
>>>
>>> This is a temporary place holder while an event is active, i.e
>>> theoretically it
>>> doesn't stay the same for the entire trace session.  In situations where
>>> there
>>> could be one ETR per CPU, the same ETR could be used to serve more than
>>> one
>>> trace session (since only one session can be active at a time on a CPU).
>>> As
>>> such I would call it curr_perf_data or something similar.  I'd also make
>>> that
>>> clear in the above documentation.
>>
>>
>> You're right. However, from the ETR's perspective, it doesn't care how the
>> perf
>> uses it. So from the ETR driver side, it still is something used by the perf
>> mode.
>> All it stands for is the buffer to be used when enabled in perf mode. I
>> could
>> definitely add some comment to describe this. But I am not sure if we have
>> to
>> rename the variable.
>>
>>>
>>> Have you tried your implementation on a dragonboard or a Hikey?
>>
>>
>> No, I haven't. But Mike and Rob are trying on the Draonboard & Hikey
>> respectively.
>> We are hitting some issues in the Scatter Gather mode, which is under
>> debugging.
>> The SG table looks correct, just that the ETR hangs up. It works fine in the
>> flat memory mode. So, it is something to do with the READ  (sg table
>> pointers) vs
>> WRITE (write trace data) pressure on the ETR.
>>
>> One change I am working on with the perf buffer is to limit the "size" of
>> the
>> trace buffer used by the ETR (in case of the perf-ring buffer) to the
>> handle->size.
>> Otherwise we could be corrupting the collected trace waiting for consumption
>> by
>> the user. This is easily possible with our SG table. But with the flat
>> buffer, we have to
>> limit the size the minimum of (handle->size, space-in-circular-buffer-before
>> wrapping).
>>
>> In either case, we could loose data if we overflow the buffer, something we
>> can't help
>> at the moment.
>>
>>
>> Suzuki
>>
>>
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>>   };
>>>>     struct etr_buf_operations {
>>>> --
>>>> 2.13.6
>>>>
>>
>
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Blackburn Design Centre. UK
