From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 17 Jan 2013 12:52:16 +0200
Subject: [PATCH] ARM: imx: select HAVE_IMX_SRC when SMP is enabled
In-Reply-To: <1350977942-15964-1-git-send-email-shawn.guo@linaro.org>
References: <1350977942-15964-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1358419936.2731.221.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-10-23 at 15:39 +0800, Shawn Guo wrote:
> With being part of multi-platform support, SMP can be enabled by other
> platform even when SOC_IMX6Q is deselected.  It leads to a situation
> that arch/arm/mach-imx/platsmp.c is built without HAVE_IMX_SRC selection
> which will cause build error.  For example, the following link errors
> will be seen when building imx5 with other v7 platforms.
> 
>  arch/arm/mach-imx/built-in.o: In function `imx_cpu_die':
>  platform-ahci-imx.c:(.text+0x219c): undefined reference to `imx_enable_cpu'
>  arch/arm/mach-imx/built-in.o: In function `imx_boot_secondary':
>  platform-ahci-imx.c:(.cpuinit.text+0x14): undefined reference to `imx_set_cpu_jump'
>  platform-ahci-imx.c:(.cpuinit.text+0x20): undefined reference to `imx_enable_cpu'
> 
> Select HAVE_IMX_SRC as long as SMP is enabled to fix the problem.

Err, sorry, the issue I get is a bit different, but similar:

arch/arm/mach-imx/built-in.o: In function `imx6q_restart':
platform-spi_imx.c:(.text+0x2220): undefined reference to `imx_src_prepare_restart'
arch/arm/mach-imx/built-in.o: In function `imx6q_pm_enter':
platform-spi_imx.c:(.text+0x22e4): undefined reference to `imx_set_cpu_jump'
arch/arm/mach-imx/built-in.o: In function `imx6q_init_irq':
platform-spi_imx.c:(.init.text+0x7280): undefined reference to `imx_src_init'
make[1]: *** [vmlinux] Error 1

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130117/faaeebf8/attachment-0001.sig>
