From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 00:54:13 +0000
Subject: [BUG] build error: undefined reference to `v7_cpu_resume'
Message-ID: <20131031005413.GU16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last night, my autobuilder failed on one randconfig with this:

arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
platform-spi_imx.c:(.text+0x2648): undefined reference to `v7_cpu_resume'
make[1]: *** [vmlinux] Error 1
make[1]: Target `uImage' not remade because of errors.
make: *** [sub-make] Error 2
make: Target `uImage' not remade because of errors.

This is caused by CONFIG_SMP=n, CONFIG_PM=y, CONFIG_SOC_IMX6SL=y and
CONFIG_SOC_IMX6Q=n.  This results in pm-imx6q.c being built, which
references v7_cpu_resume, but that is only defined in headsmp.o.

Full config is available for the next 6 days via:
 http://www.arm.linux.org.uk/developer/build/file.php?type=config&idx=6442

Please fix. :)
