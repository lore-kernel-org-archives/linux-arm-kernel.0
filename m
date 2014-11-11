From: wcohen@redhat.com (William Cohen)
Date: Tue, 11 Nov 2014 09:48:29 -0500
Subject: [PATCH] Correct the race condition in
 aarch64_insn_patch_text_sync()
In-Reply-To: <20141111112844.GC16265@arm.com>
References: <1415637362-30754-1-git-send-email-wcohen@redhat.com>
 <20141110170846.GH23942@arm.com> <546113F4.1050304@redhat.com>
 <20141111112844.GC16265@arm.com>
Message-ID: <546221BD.8000207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2014 06:28 AM, Will Deacon wrote:
> On Mon, Nov 10, 2014 at 07:37:24PM +0000, William Cohen wrote:
>> On 11/10/2014 12:08 PM, Will Deacon wrote:
>>> On Mon, Nov 10, 2014 at 04:36:02PM +0000, William Cohen wrote:
>>>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>>>> index e007714..e6266db 100644
>>>> --- a/arch/arm64/kernel/insn.c
>>>> +++ b/arch/arm64/kernel/insn.c
>>>> @@ -153,8 +153,10 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>>>>  	int i, ret = 0;
>>>>  	struct aarch64_insn_patch *pp = arg;
>>>>  
>>>> -	/* The first CPU becomes master */
>>>> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
>>>> +	/* Make sure all the processors are in this functionaarch64_insn_patch_text_cb(
>>>> +	   before patching the code. The last CPU to this function
>>>> +	   does the update. */
>>>> +	if (atomic_dec_return(&pp->cpu_count) == 0) {
>>>>  		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>>>>  			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>>>>  							     pp->new_insns[i]);
>>>> @@ -163,7 +165,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>>>>  		 * which ends with "dsb; isb" pair guaranteeing global
>>>>  		 * visibility.
>>>>  		 */
>>>> -		atomic_set(&pp->cpu_count, -1);
>>>> +		/* Notifiy other processors with an additional decrement. */
>>>> +		atomic_dec(&pp->cpu_count);
>>>>  	} else {
>>>>  		while (atomic_read(&pp->cpu_count) != -1)
>>>>  			cpu_relax();
>>>> @@ -185,6 +188,7 @@ int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
>>>>  	if (cnt <= 0)
>>>>  		return -EINVAL;
>>>>  
>>>> +	atomic_set(&patch.cpu_count, num_online_cpus());
>>>
>>> I think this is still racy with hotplug before stop_machine has done
>>> get_online_cpus. How about we leave the increment in the callback and change
>>> the exit condition to compare with num_online_cpus() instead?
>>
>> Thanks for the feedback. I am no expert in the corner cases involved with
>> hotplug.  Dave Long suggested something similar with num_online_cpus in
>> the arch64_insn_patch_text_cb() and using increments and checking the
>> num_cpus_online() inside aarch64_insn_patch_text_cb().  Moving the
>> num_cpu_online() inside the aarch64_insn_patch_text_cb() is sufficient to
>> avoid race conditions with hotplug?  If so, would the attached patch be
>> appropriate?
> 
> Yes, because stop_machine() does {get,put}_online_cpus() around the
> invocation.
> 
>> From d02e3244c436234d0d07500be6d4df64feb2052a Mon Sep 17 00:00:00 2001
>> From: William Cohen <wcohen@redhat.com>
>> Date: Mon, 10 Nov 2014 14:26:44 -0500
>> Subject: [PATCH] Correct the race condition in aarch64_insn_patch_text_sync()
>>
>> When experimenting with patches to provide kprobes support for aarch64
>> smp machines would hang when inserting breakpoints into kernel code.
>> The hangs were caused by a race condition in the code called by
>> aarch64_insn_patch_text_sync().  The first processor in the
>> aarch64_insn_patch_text_cb() function would patch the code while other
>> processors were still entering the function and incrementing the
>> cpu_count field.  This resulted in some processors never observing the
>> exit condition and exiting the function.  Thus, processors in the
>> system hung.
>>
>> The patching function now waits for all processors to enter the
>> patching function before changing code to ensure that none of the
>> processors are in code that is going to be patched.  Once all the
>> processors have entered the function, the last processor to enter the
>> patching function performs the patching and signals that the patching
>> is complete with one last increment of the cpu_count field to make it
>> num_cpus_online()+1.
>>
>> Signed-off-by: William Cohen <wcohen@redhat.com>
>> ---
>>  arch/arm64/kernel/insn.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
>> index e007714..4fdddf1 100644
>> --- a/arch/arm64/kernel/insn.c
>> +++ b/arch/arm64/kernel/insn.c
>> @@ -151,10 +151,13 @@ struct aarch64_insn_patch {
>>  static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>>  {
>>  	int i, ret = 0;
>> +	int count = num_online_cpus();
>>  	struct aarch64_insn_patch *pp = arg;
>>  
>> -	/* The first CPU becomes master */
>> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
>> +	/* Make sure all the processors are in this function
>> +	   before patching the code. The last CPU to this function
>> +	   does the update. */
>> +	if (atomic_inc_return(&pp->cpu_count) == count) {
> 
> Actually, you can leave this hunk alone and leave the first CPU to do the
> patching.

Hi Will,

If it doesn't matter which processor is doing the update, do the processors all need to wait for the last one to get to this function before continuing on?  Or would it be acceptable to allow processors to continue once the first processor completes the patch operation?  That could reduce the amount of time that processors spin waiting for other processors to enter arch64_insn_patch_text_cb.

> 
>>  		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>>  			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>>  							     pp->new_insns[i]);
>> @@ -163,9 +166,10 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>>  		 * which ends with "dsb; isb" pair guaranteeing global
>>  		 * visibility.
>>  		 */
>> -		atomic_set(&pp->cpu_count, -1);
>> +		/* Notifiy other processors with an additional increment. */
> 
> Notify
> 
>> +		atomic_inc(&pp->cpu_count);
>>  	} else {
>> -		while (atomic_read(&pp->cpu_count) != -1)
>> +		while (atomic_read(&pp->cpu_count) <= count)
>>  			cpu_relax();
> 
> Then make this 'cpu_count <= num_online_cpus()'
> 
> Will
> 

Attached is a patch that addresses the current comment.

-Will Cohen
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Correct-the-race-condition-in-aarch64_insn_patch_tex.patch
Type: text/x-patch
Size: 1831 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141111/11f7050b/attachment.bin>
