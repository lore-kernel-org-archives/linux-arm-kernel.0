From: ccross@google.com (Colin Cross)
Date: Tue, 14 Jun 2011 07:48:40 -0700
Subject: About secondary CPU resume PC address?
In-Reply-To: <BANLkTim-QXzsNTgrKsGac+Yum44KavvJ2w@mail.gmail.com>
References: <BANLkTim-QXzsNTgrKsGac+Yum44KavvJ2w@mail.gmail.com>
Message-ID: <BANLkTin8ghuM36kAobA9wXrYDcdBDTMrJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 4:02 AM, udmd-eric wann <udmderic@gmail.com> wrote:
> ?Hi:
>
> ? ? ? ?We am tracing Cortex-A9 SMP suspend/resume code now.
> ? ? ? ?We use linux-2.6.39 mach-tegra and mach-exynos4210 for reference code.
> ? ? ? ?(We don't have the hardware.)
>
> ? ? ? ?In mach-tegra, hardware can power down both CPU cores and the GICs.
> ? ? ?(http://lists.arm.linux.org.uk/lurker/message/20110124.020118.a08c51fc.en.html)
>
> ? ? ? ?Because CPU power off, so some CPU information should be
> remembered in SRAM/Register/RAM ...
> ? ? ?The most important information we think is resume PC address for
> "both" CPUs.
>
> ? ? ?For boot CPU, the resume address is handled by ROM code.
> ? ? ?But for secondary CPU, where is the resume entry address??
>
> ? ? ?It seems that tegra2 set the secondary CPU wakeup address in
> function
> ? ? ? boot_secondary
>
> ? ? ? int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> ? ? ? {
> ? ? ? ? ? ? ? ?...
> ? ? ? ? ? ? ? ?/* set the reset vector to point to the secondary_startup routine */
>
> ? ? ? ? ? ? ? ?boot_vector = virt_to_phys(tegra_secondary_startup);
> ? ? ? ? ? ? ? ?old_boot_vector = readl(EVP_CPU_RESET_VECTOR);
> ? ? ? ? ? ? ? ?writel(boot_vector, EVP_CPU_RESET_VECTOR);
> ? ? ? ? ? ? ? ?...
> ? ? ? }
>
> ? ? ? mach-tegra also set the function tegra_secondary_startup in
> __CPUINIT section.
> ? ? ? So the secondary CPU resume will run the same path like the
> first cold boot...
> ? ? ? Is it correct?

Linux does not suspend and resume the second CPU - it uses hotplug to
shut the CPU down in suspend, and then turn it back on in resume,
which should boot it from scratch, so no state has to be saved on the
second CPU.

Different hardware treats the second CPU differently.  On Tegra, the
second CPU is held in reset when booting or resuming.  The first CPU
comes out of reset and starts booting from the address in
EVP_CPU_RESET_VECTOR (which is set to tegra_resume).  When the hotplug
code is called later to boot the second CPU, it modifies
EVP_CPU_RESET_VECTOR to point to tegra_secondary_startup, and then
takes the second CPU out of reset.

Other platforms may have a different reset vector for each CPU, and
both CPUs may come out of reset at the same time, but the second CPU
enters an infinite loop somewhere waiting for the first CPU to signal
it.

> ? ? ? ? ?However, in mach-exynos4, we don't see this behavior.
> ? ? ? mach-exynos4 set secondary cpu wakeup address only in
> ? ? ? void __init platform_smp_prepare_cpus(unsigned int max_cpus)
> ? ? ? and exynos4_secondary_startup is in __INIT section.
> ? ? ? So we don't know when the secondary cpu resume, which entry
> address it should run...
> ? ? ? Do we miss some important key point?

I'm not familiar with exynos4, but maybe it doesn't support hotplug?

> ? ? ? Thanks for your help.
>
> ? ? ? Best Regards
>
> Eric Wann
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
