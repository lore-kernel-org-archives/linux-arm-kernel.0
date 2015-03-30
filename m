From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 30 Mar 2015 12:21:31 +0900
Subject: [PATCH 3/5] arm64: kdump: do not go into EL2 before starting
 a crash dump kernel
In-Reply-To: <1427408957.6526.1.camel@infradead.org>
References: <1427358533-3754-1-git-send-email-takahiro.akashi@linaro.org>	
 <1427358533-3754-4-git-send-email-takahiro.akashi@linaro.org>
 <1427408957.6526.1.camel@infradead.org>
Message-ID: <5518C13B.6070201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2015 07:29 AM, Geoff Levand wrote:
> On Thu, 2015-03-26 at 17:28 +0900, AKASHI Takahiro wrote:
>> @@ -64,7 +65,11 @@ void soft_restart(unsigned long addr)
>>   	setup_mm_for_reboot();
>>
>>   	cpu_soft_restart(virt_to_phys(cpu_reset),
>> -		is_hyp_mode_available(), addr);
>> +#ifdef CONFIG_KEXEC
>> +		!in_crash_kexec &&
>> +#endif
>
> Why not define in_crash_kexec without condition on CONFIG_KEXEC, say
> here in process.c and then avoid these preprocessor conditionals.

Well, I thought of that, but as its name suggested, the variable should
be basically part of kdump code.
Moreover, I suspect that some one might reject a whole idea of patch #3.

-Takahiro AKASHI

>> +		is_hyp_mode_available(),
>> +		addr);
>>
>>   	/* Should never get here */
>>   	BUG();
>
>
>
