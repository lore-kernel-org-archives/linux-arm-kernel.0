From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Jan 2011 16:17:47 +0100
Subject: Why call calibrate_delay() in smp.c: secondary_start_kernel()
In-Reply-To: <ebe9b3d6a0cc160cd46a97ae05b72119@mail.gmail.com>
References: <4D3552C2.3020101@stericsson.com>
	<ebe9b3d6a0cc160cd46a97ae05b72119@mail.gmail.com>
Message-ID: <AANLkTinzBxM41K8r2mN==_9JTEBP+NUZ-oR1wnJmvbh=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/18 Santosh Shilimkar <santosh.shilimkar@ti.com>:

> +config ARCH_SKIP_SECONDARY_CALIBRATE
> + ? ? ? bool "Skip secondary CPU calibration"
> + ? ? ? depends on SMP
> + ? ? ? help
> + ? ? ? ? On some architectures, secondary cores shares clock with
> primiary
> + ? ? ? ? core and hence scale together. Hence secondary core lpj
> calibration
> + ? ? ? ? is not necessary and can be skipped to save considerable time.
> +
> + ? ? ? ? If unsure, say n.

Why do you want to select that manually? Surely the kernel
writer should know whether the cores are clocked together
or not. Just:

config ARCH_HAS_COMMON_CORES_CLOCK
      bool
      depends on SMP

This will be default "n" so archs that want to flag to the
build system that the core clock is common can e.g.:

config ARCH_U8500
        bool "ST-Ericsson U8500 Series"
        select CPU_V7
+       select ARCH_HAS_COMMON_CORES_CLOCK

Looks reasonable? (And feel free to add that to U8500
as part of the patch.)

> ?/*
> + * Skip the secondary calibration on architectures sharing clock
> + * with primary cpu. Archs can use ARCH_SKIP_SECONDARY_CALIBRATE
> + * for this.
> + */
> +static inline int skip_secondary_calibrate(void)

bool? Returning an error code seem overdesigned for a function
named like that.

Also the name is misleading, if you look at how you
use it, it should be named "do_not_skip_secondary_calibrate()".

> +{
> +#ifdef CONFIG_ARCH_SKIP_SECONDARY_CALIBRATE
> + ? ? ? return 0;

return false;

> +#else
> + ? ? ? return -ENXIO;

return true;

> +#endif
> +}


> +
> +/*
> ?* This is the secondary CPU boot entry. ?We're using this CPUs
> ?* idle thread stack, but a set of temporary page tables.
> ?*/
> @@ -312,7 +326,8 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
> ? ? ? ? */
> ? ? ? ?percpu_timer_setup();
>
> - ? ? ? calibrate_delay();
> + ? ? ? if (skip_secondary_calibrate())
> + ? ? ? ? ? ? ? calibrate_delay();

Change sematics of that function and
if (!skip_secondary_calibrate())
  ...

> ? ? ? ?smp_store_cpu_info(cpu);

...and thanks for driving this!
Linus Walleij
