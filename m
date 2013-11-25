From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Nov 2013 11:28:36 -0500
Subject: [PATCH 2/2] ARM: OMAP5: Add HYP mode entry support for secondary
 CPUs
In-Reply-To: <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com>
References: <1385251666-27532-1-git-send-email-santosh.shilimkar@ti.com>
 <1385251666-27532-3-git-send-email-santosh.shilimkar@ti.com>
 <CAMJs5B8XX-93YcRyTiQ1JRcKUB5oer8cV7FLtMPP6SeqeB3RwQ@mail.gmail.com>
Message-ID: <52937AB4.1060901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 November 2013 10:09 AM, Christoffer Dall wrote:
> On 23 November 2013 16:07, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
>> Boot-CPU entry into the HYP mode is managed in boot-loader but
>> the secondary CPUs directly jumps to kernel during boot. Same
>> path is also used for CPU hotplug as well during suspend for
>> secondary CPU.
>>
>> Hence patch the secondary CPU boot path for hyp mode etry.
>>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: Christoffer Dall <christoffer.dall@linaro.org>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
>>  arch/arm/mach-omap2/omap-headsmp.S |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
>> index 75e9295..4844dd8 100644
>> --- a/arch/arm/mach-omap2/omap-headsmp.S
>> +++ b/arch/arm/mach-omap2/omap-headsmp.S
>> @@ -22,6 +22,7 @@
>>
>>  /* Physical address needed since MMU not enabled yet on secondary core */
>>  #define AUX_CORE_BOOT0_PA                      0x48281800
>> +#define API_HYP_ENTRY                          0x102
>>
>>  /*
>>   * OMAP5 specific entry point for secondary CPU to jump from ROM
>> @@ -38,6 +39,12 @@ wait:        ldr     r2, =AUX_CORE_BOOT0_PA  @ read from AuxCoreBoot0
>>         and     r4, r4, #0x0f
>>         cmp     r0, r4
>>         bne     wait
>> +#ifdef CONFIG_KVM_ARM_HOST
>> +       ldr     r12, =API_HYP_ENTRY
>> +       adr     r0, hyp_boot
>> +       smc     #0
>> +hyp_boot:
>> +#endif
>>         b       secondary_startup
>>  END(omap5_secondary_startup)
>>  /*
> 
> hmm, this means that currently running this in a guest will fail to
> bring-up SMP, right?
> 
Nope. Because the code under 'KVM_ARM_HOST' macro. Guest build 
will not enable CONFIG_KVM_ARM_HOST and things should be fine then.
Right ? 

> Couldn't you create a little wrapper-pen in U-Boot instead, which
> replicates the omap boot protocol and takes care of the hyp-mode
> startup there instead, keeping this completely out of the kernel?
> 
Its not just booting but CPU hotplug also follows the same path
so we need the mechanism in kernel to switch mode.

In general, I think its important to consider the aspect with
CPU PM. CPUs are not going to go through the boot-loaders in
those paths and hence need of HYP entry in the kernel will
be must.

Regards,
Santosh

Regards,
Santosh
