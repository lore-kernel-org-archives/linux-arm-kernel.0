From: ccross@android.com (Colin Cross)
Date: Tue, 13 Sep 2011 18:46:48 -0700
Subject: [PATCH] ARM: tegra: Remove redundant change to the CPSR in
	headsmp.S
In-Reply-To: <20110912165222.GE2020@arm.com>
References: <1315411253-17559-1-git-send-email-dave.martin@linaro.org>
	<20110912165222.GE2020@arm.com>
Message-ID: <CAMbhsRSoSYhuqPC+SmCNk4dseok0vs02su0kihKNqXGpCvUvSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2011 at 9:52 AM, Dave Martin <dave.martin@linaro.org> wrote:
> Colin, can you comment on this?
>
> On Wed, Sep 07, 2011 at 05:00:53PM +0100, Dave Martin wrote:
>> At secondary_startup, the MSR CPSR_cxsf, #0xd3 is not compatible
>> with Thumb-2 and also unmasks asynchronous aborts (CPSR.A bit
>> forced to zero -- this is probably unintentional).
>>
>> Any remotely sane bootloader should be putting each secondary CPU
>> in the appropriate state _before_ entering the kernel anyway.
>> Otherwise, disabling interrupts on entry to the kernel isn't going
>> to fix it.
>>
>> Therefore this patch just removes the MSR instruction.
>>
>> Signed-off-by: Dave Martin <dave.martin@linaro.org>
>> ---
>>
>> I make assumptions about the bootloader in this patch. ?If someone with
>> Tegra knowledge can please comment and/or test, that would be much
>> appreciated, thanks.
>>
>> ?arch/arm/mach-tegra/headsmp.S | ? ?1 -
>> ?1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
>> index b5349b2..6ec4790 100644
>> --- a/arch/arm/mach-tegra/headsmp.S
>> +++ b/arch/arm/mach-tegra/headsmp.S
>> @@ -48,7 +48,6 @@ ENTRY(v7_invalidate_l1)
>> ?ENDPROC(v7_invalidate_l1)
>>
>> ?ENTRY(tegra_secondary_startup)
>> - ? ? msr ? ? cpsr_fsxc, #0xd3
>> ? ? ? ? ?bl ? ? ?v7_invalidate_l1
>> ? ? ? mrc ? ? p15, 0, r0, c0, c0, 5
>> ? ? ? ? ?and ?r0, r0, #15
>
> My rationale here is that the CPU boots straight into the
> correct mode -- if there is any boot code before we get here,
> then it should already have established the correct mode, otherwise
> we're likely to get problems which "MSR" by itself isn't going to
> fix -- such as stray interrupts for example.
>
> If that feels unsafe however, we should still to be able to write
>
> ? ? ? ?cpsid ? aif, #SVC_MODE
>
> (which is the compact v6/v7-compatible way to set all the interrupt
> mask bits and get into a specific mode)

Tegra boots with one cpu enabled, and the other in reset.  The cpu
needs to be initialized from scratch by the kernel.  Does cpsid aif,
#SVC_MODE compile to the same instruction as the msr instruction?
