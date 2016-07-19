From: dave.long@linaro.org (David Long)
Date: Mon, 18 Jul 2016 20:53:40 -0400
Subject: [PATCH v15 06/10] arm64: Treat all entry code as non-kprobe-able
In-Reply-To: <20160715164720.GC14792@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-7-git-send-email-dave.long@linaro.org>
 <20160715164720.GC14792@e104818-lin.cambridge.arm.com>
Message-ID: <578D7A14.6070008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2016 12:47 PM, Catalin Marinas wrote:
> On Fri, Jul 08, 2016 at 12:35:50PM -0400, David Long wrote:
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -243,6 +243,7 @@ tsk	.req	x28		// current thread_info
>>    * Exception vectors.
>>    */
>>
>> +	.pushsection ".entry.text", "ax"
>>   	.align	11
>>   ENTRY(vectors)
>>   	ventry	el1_sync_invalid		// Synchronous EL1t
>> @@ -781,3 +782,5 @@ ENTRY(sys_rt_sigreturn_wrapper)
>>   	mov	x0, sp
>>   	b	sys_rt_sigreturn
>>   ENDPROC(sys_rt_sigreturn_wrapper)
>> +
>> +	.popsection
>
> Does the above sigreturn wrapper need to be included in the .entry.text
> section?
>

Apparently not. It wouldn't make sense for that to be in entry.text when 
sys_rt_sigreturn() isn't. I'll put that in the list of changes.

Thanks,
-dl
