From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Jan 2015 09:33:05 +0100
Subject: [RFC] ARM: Make CPU_DCACHE_DISABLE depend on !SMP
In-Reply-To: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
References: <1420683088-1856-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <2868984.6iP3luxIAM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 January 2015 18:11:28 Florian Fainelli wrote:
> Enabling CPU_DCACHE_DISABLE on a SMP capable system will prevent the
> kernel from booting because of the following ldrex instruction in
> arch_spin_lock:
> 
> (gdb) x/10i $pc
> => 0xc053cfa8 <_raw_spin_lock+4>:       ldrex   r3, [r0]
>    0xc053cfac <_raw_spin_lock+8>:       add     r2, r3, #65536  ; 0x10000
> 
> which is taken by the very first printk call:
> 
>     at /home/fainelli/work/linux/arch/arm/include/asm/spinlock.h:65
>     fmt=0xc0637650 "\001\066Booting Linux on physical CPU 0x%x\n", args=<incomplete type>)
>     at kernel/printk/printk.c:1525
>     fmt=0xc05370f4 <printk+52> "\024\320\215\342\004\340\235\344\020\320\215\342\036\377/\341\017") at kernel/printk/printk.c:1688
> 
> ldrex requires exclusive monitor(s) (local or global) which are no longer
> working when the Data cache is disabled in CP15 and will just hang the CPU
> there.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

We stumbled on this a while back when Kaixu was trying to fix allmodconfig
builds to run on real hardware, but never submitted it in the end when
Russell didn't like some of the other parts required for that to work.

This one clearly makes sense independently.

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 03823e784f63..09245fd1e900 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -738,7 +738,7 @@ config CPU_ICACHE_DISABLE
>  
>  config CPU_DCACHE_DISABLE
>  	bool "Disable D-Cache (C-bit)"
> -	depends on CPU_CP15
> +	depends on CPU_CP15 && !SMP
>  	help
>  	  Say Y here to disable the processor data cache. Unless
>  	  you have a reason not to or are unsure, say N.
> 
