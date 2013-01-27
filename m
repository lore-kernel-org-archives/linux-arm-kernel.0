From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 17:25:23 +0100
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <CAKohpomWM41MhRjdhFixy-ELXc6QjE0BhCAHfTzovOD0CBPoOQ@mail.gmail.com>
 <20130127154212.GJ29973@lunn.ch>
 <CAKohpomQJfsWBY5o3ep4r86fYYQ39JnMPswjoe8YFT37ekM20w@mail.gmail.com>
Message-ID: <20130127162523.GK29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 09:33:04PM +0530, Viresh Kumar wrote:
> On 27 January 2013 21:12, Andrew Lunn <andrew@lunn.ch> wrote:
> > And how would the module get loaded? There is no hardware anchor to
> > make the module load. No enumeration of some bus causing it to be
> > loaded. In the ARM world, platform drivers are the norm.
> 
> The way you do it now is by creating a platform device for it in your
> arch/arm/mach-* directory. And you are passing an IOMEM resource too.
> 
> I believe, normally we don't require any DT node or platform device from
> arch/arm/mach-* for cpufreq drivers. This is something which should
> always be initialized once it is selected in .config.

What current happens is that most of the drivers use a late_initcall():

linux/drivers/cpufreq$ grep late_initcall *
acpi-cpufreq.c:late_initcall(acpi_cpufreq_init);
cpufreq-cpu0.c:late_initcall(cpu0_cpufreq_driver_init);
exynos-cpufreq.c:late_initcall(exynos_cpufreq_init);
longhaul.c:late_initcall(longhaul_init);
p4-clockmod.c:late_initcall(cpufreq_p4_init);
pcc-cpufreq.c:late_initcall(pcc_cpufreq_init);
powernow-k7.c:late_initcall(powernow_init);
powernow-k8.c:late_initcall(powernowk8_init);
s5pv210-cpufreq.c:late_initcall(s5pv210_cpufreq_init);
spear-cpufreq.c:late_initcall(spear_cpufreq_driver_init);
speedstep-centrino.c:late_initcall(centrino_init);

So when we have a multiplatform kernel with many of these drivers
built in, all but one are going to notice they are not on the hardware
they support, and return -ENODEV.

By making it a platform driver, the kirkwood cpufreq driver will only
get loaded on kirkwood systems, and won't slow down the boot for
everybody else.

	  Andrew
