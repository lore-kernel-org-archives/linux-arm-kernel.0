From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Mon, 10 Jan 2011 16:05:36 +0100
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <20101007194415.GA24709@alarsen.net>
References: <20101007194415.GA24709@alarsen.net>
Message-ID: <AANLkTimGTVybe4LmspxWj6vkM_zNnPcaUbk6sqvpJ032@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 7, 2010 at 9:44 PM, Anders Larsen <al@alarsen.net> wrote:
> According to Atmel, their 926T processors (AT91 post RM9200) requires
> 'Wait for Interrupt' mode be entered right after disabling the processor clock
> in order to minimise current consumption when idle, so do both provided we're
> not running on a 920T (an RM9200).
>
> Furthermore, get rid of the #ifndef CONFIG_DEBUG_KERNEL, since arch_idle()
> can be turned off completely with the kernel parameter 'nohlt'.
>
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>


Is there a known interaction with this and the JTAG controller? I
haven't had time to look closer into it yet, but with this applied I
can no longer access an Altera FPGA on a chain shared with a 9G45
through Quartus.


> +++ b/arch/arm/mach-at91/include/mach/system.h
> @@ -28,17 +28,16 @@
>
> ?static inline void arch_idle(void)
> ?{
> -#ifndef CONFIG_DEBUG_KERNEL
> ? ? ? ?/*
> ? ? ? ? * Disable the processor clock. ?The processor will be automatically
> ? ? ? ? * re-enabled by an interrupt or by a reset.
> ? ? ? ? */
> ? ? ? ?at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
> -#else
> +#ifndef CONFIG_CPU_ARM920T
> ? ? ? ?/*
> ? ? ? ? * Set the processor (CP15) into 'Wait for Interrupt' mode.
> - ? ? ? ?* Unlike disabling the processor clock via the PMC (above)
> - ? ? ? ?* ?this allows the processor to be woken via JTAG.
> + ? ? ? ?* Post-RM9200 processors need this in conjunction with the above
> + ? ? ? ?* to save power when idle.
> ? ? ? ? */
> ? ? ? ?cpu_do_idle();
> ?#endif

-- 
Bye, Peter Korsgaard
