From: james.morse@arm.com (James Morse)
Date: Wed, 28 Jun 2017 17:42:42 +0100
Subject: [PATCH v5] trace: ras: add ARM processor error information trace
 event
In-Reply-To: <20170626140647.anigiqhk3l6ltet7@pd.tnic>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626140647.anigiqhk3l6ltet7@pd.tnic>
Message-ID: <5953DC82.2000602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

(CC: Punit)

On 26/06/17 15:06, Borislav Petkov wrote:
> On Sat, Jun 24, 2017 at 11:38:23AM +0800, Xie XiuQi wrote:
>> Add a new trace event for ARM processor error information, so that
>> the user will know what error occurred. With this information the
>> user may take appropriate action.
>>
>> These trace events are consistent with the ARM processor error
>> information table which defined in UEFI 2.6 spec section N.2.4.4.1.

Sorry I've been quiet on this - I'm not familiar with how the trace event stuff
works, or what picks it up in user space.


>> diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
>> index 39701a5..f76ab0f 100644
>> --- a/drivers/ras/ras.c
>> +++ b/drivers/ras/ras.c
>> @@ -22,7 +22,17 @@ void log_non_standard_event(const uuid_le *sec_type, const uuid_le *fru_id,
>>  
>>  void log_arm_hw_error(struct cper_sec_proc_arm *err)
>>  {
>> +	int i;
>> +	struct cper_arm_err_info *err_info;
>> +
>>  	trace_arm_event(err);
>> +
>> +	if (!trace_arm_err_info_event_enabled())
>> +		return;
> 
> If we're going to check whether the tracepoint is enabled, you need
> to do that for arm_event TP too. Because from looking at the spec,
> arm_event dumps
> 
> Table 260. ARM Processor Error Section
> 
> and you're dumping
> 
> Table 261. ARM Processor Error Information Structure
> 
> which is embedded in the previous table.
> 
> So this is basically a single error event and the error info structures
> can describe different incarnations to that error event.
> 
> And you need to mirror exactly that behavior.
> 
> Then, when you do that, you need to document somewhere so that userspace
> knows to open *both* TPs in order to get the full error information.

I don't see how the data in Table 261 is usable without the corresponding
information in Table 260.

For example 261's 'Type: cache error' has to be interpreted with 260's 'Error
affinity level: 0', 'MPIDR_EL1: 0x100' to know that this cache error only
affected that specific CPU.

While I like the idea of just spitting out the CPER records (as we don't need to
invent a new format to pass the information to user space), I don't think we can
easily do this through tracepoints.

One tracepoint per cper header/table would be tricky to parse, wouldn't we have
to rely on the cpu-id and timestamps to pair the records back up?


> Alternatively, you can extend arm_event to get issued with *each*
> cper_arm_err_info but that would mean a lot of redundant information
> being shuffled out to userspace.

I think this is what we should do, but only keep the number of fields we export
to a minimum. If we always use the names in the spec, and user-space always
parses the 'format' file, we should be able to add more fields when they turn
out to be necessary. (looks like the trace infrastructure makes inventing a new
format easy!)

On that note, how does user space get the 'error severity' from Table 247,
'section severity', 'flags' and the other stringy bits of table 249?
Does it need them?


Thanks,

James
