From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 5 Nov 2018 15:06:02 +0100
Subject: [PATCH] ARM: proc-v7: fix Thumb annotation of cpu_v7_hvc_switch_mm
In-Reply-To: <c3de69e0-1408-4ac7-d2e2-8d8bcc936df3@arm.com>
References: <20180619162919.25190-1-ard.biesheuvel@linaro.org>
 <c3de69e0-1408-4ac7-d2e2-8d8bcc936df3@arm.com>
Message-ID: <CAKv+Gu9y54OGb8cPxDdkcud8i=9mO4MewwMY2f57fiXUNSP=VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 November 2018 at 14:35, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi all,
>
> On 19/06/18 17:29, Ard Biesheuvel wrote:
>> Due to what appears to be a copy/paste error, the opening ENTRY()
>> of cpu_v7_hvc_switch_mm() lacks a matching ENDPROC(), and instead,
>> the one for cpu_v7_smc_switch_mm() is duplicated.
>>
>> Given that it is ENDPROC() that emits the Thumb annotation, the
>> cpu_v7_hvc_switch_mm() routine will be called in ARM mode on a
>> Thumb2 kernel, resulting in the following splat:
>>
>>   Internal error: Oops - undefined instruction: 0 [#1] SMP THUMB2
>>   Modules linked in:
>>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-rc1-00030-g4d28ad89189d-dirty #488
>>   Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>   PC is at cpu_v7_hvc_switch_mm+0x12/0x18
>>   LR is at flush_old_exec+0x31b/0x570
>>   pc : [<c0316efe>]    lr : [<c04117c7>]    psr: 00000013
>>   sp : ee899e50  ip : 00000000  fp : 00000001
>>   r10: eda28f34  r9 : eda31800  r8 : c12470e0
>>   r7 : eda1fc00  r6 : eda53000  r5 : 00000000  r4 : ee88c000
>>   r3 : c0316eec  r2 : 00000001  r1 : eda53000  r0 : 6da6c000
>>   Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
>>
>> Note the 'ISA ARM' in the last line.
>>
>> Fix this by using the correct name in ENDPROC().
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/arm/mm/proc-v7.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
>> index 6fe52819e014..339eb17c9808 100644
>> --- a/arch/arm/mm/proc-v7.S
>> +++ b/arch/arm/mm/proc-v7.S
>> @@ -112,7 +112,7 @@ ENTRY(cpu_v7_hvc_switch_mm)
>>       hvc     #0
>>       ldmfd   sp!, {r0 - r3}
>>       b       cpu_v7_switch_mm
>> -ENDPROC(cpu_v7_smc_switch_mm)
>> +ENDPROC(cpu_v7_hvc_switch_mm)
>>  #endif
>>  ENTRY(cpu_v7_iciallu_switch_mm)
>>       mov     r3, #0
>>
>
> I've just spent a couple of hours chasing this exact bug, only to notice
> that the problem was already known. Ard, can you please send this to
> RMK's patch system so that it doesn't get dropped?
>
> Please add my: Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> and Cc stable, as this is quite an annoying regression.
>

Thanks

Queued as #8809
