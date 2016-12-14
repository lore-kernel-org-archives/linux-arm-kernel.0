From: slash.tmp@free.fr (Mason)
Date: Wed, 14 Dec 2016 18:47:43 +0100
Subject: Linux crashes when trying to online secondary core
In-Reply-To: <alpine.DEB.2.20.1612141807410.3556@nanos>
References: <ef972981-3fb6-74a4-cd83-a6629d2dab2a@free.fr>
 <alpine.DEB.2.20.1612141807410.3556@nanos>
Message-ID: <8a021a90-e69e-f38b-c8df-ea8963f3973f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/12/2016 18:08, Thomas Gleixner wrote:

> On Wed, 14 Dec 2016, Mason wrote:
> 
>> I'm seeing Linux v4.9 crash (dereferencing NULL) when I try to online
>> the secondary core, after putting it offline.
> 
> Does the patch below fix the issue?
> 
> Thanks,
> 
> 	tglx
> 	
> 8<---------------
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 22acee76cf4c..2594c287b078 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -101,7 +101,6 @@ enum cpuhp_state {
>  	CPUHP_AP_ARM_L2X0_STARTING,
>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
> -	CPUHP_AP_DUMMY_TIMER_STARTING,
>  	CPUHP_AP_JCORE_TIMER_STARTING,
>  	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_TWD_STARTING,
> @@ -111,6 +110,7 @@ enum cpuhp_state {
>  	CPUHP_AP_MARCO_TIMER_STARTING,
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>  	CPUHP_AP_ARC_TIMER_STARTING,
> +	CPUHP_AP_DUMMY_TIMER_STARTING,
>  	CPUHP_AP_KVM_STARTING,
>  	CPUHP_AP_KVM_ARM_VGIC_INIT_STARTING,
>  	CPUHP_AP_KVM_ARM_VGIC_STARTING,

$ patch -p1 < tglx.patch 
patching file include/linux/cpuhotplug.h
Hunk #1 succeeded at 80 (offset -21 lines).
Hunk #2 succeeded@89 (offset -21 lines).

It does seem to fix the problem:

# echo 0 > /sys/devices/system/cpu/cpu1/online
SMC called with a0=0x00[000001 a1=0x00000121 a2=0x00000005  a3 =0xc01189b4  0x00000121
[1][flow/suspend3.c:39] CPU 1 die: jumping6 to. post-boot WFE
402826] CPU1: shutdown
SMC called with a0=0x00000001 a1=0x00000122 a2=0x00000000 a3=0x00000000 0x00000122
[0][flow/suspend.c:82] Killing core1
armor+++ armor: core 1 booted, entering wfe...
# echo 1 > /sys/devices/system/cpu/cpu1/online
[  215.692700] tango_boot_secondary from __cpu_up
SMC called with a0=0x80101500 a1=0x00000105 a2=0x00000000 a3=0x00000000 0x00000105
[  215.704494] tango_set_aux_boot_addr=0
SMC called with a0=0x00000001 a1=0x00000104 a2=0x00000000 a3=0x00000000 0x00000104
[0][flow/smc_handler.c:127] waking up CPU1
[  215.719308] tango_start_aux_core=0


I reverted your patch, and the kernel blows up again.

So what's the problem, and how does your patch solve it?

Regards.
