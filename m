From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 23 Nov 2009 11:42:13 +0100
Subject: [PATCH] ARM: MX3: fix CPU revision number detection
In-Reply-To: <20091121191718.GD14091@buzzloop.caiaq.de>
References: <1258820364-32693-1-git-send-email-daniel@caiaq.de>
	<20091121190037.GE13956@n2100.arm.linux.org.uk>
	<20091121191718.GD14091@buzzloop.caiaq.de>
Message-ID: <20091123104213.GC30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 08:17:18PM +0100, Daniel Mack wrote:
 
> 
> From 5e080a57b92a7e5e9f08286fc140aebb6ea356c4 Mon Sep 17 00:00:00 2001
> From: Daniel Mack <daniel@caiaq.de>
> Date: Sat, 21 Nov 2009 15:15:02 +0100
> Subject: [PATCH] ARM: MX3: fix CPU revision number detection
> 
> The macro mx31_revision() used to take the global variable system_rev to
> determine the CPU revision number. However, this number is expected to
> be set by the bootloader and is usually zero (at least on my MX31 based
> boards here). More than that, it is usually taken to identify the
> board's revision, not the CPU's.
> 
> Fix that by reading the the CPU's SREV register instead.
> 
> Right now, mx31_read_cpu_rev() is called from mx31_clocks_init() which
> is admittedly not a good place for it. However, we need to enable the
> IIM clock first, and the clock code also has conditional code that
> depends on mx31_revision() returning the right thing.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> ---
>  arch/arm/mach-mx3/Makefile            |    2 +-
>  arch/arm/mach-mx3/clock.c             |    2 +
>  arch/arm/mach-mx3/cpu.c               |   57 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mx3x.h |    5 ++-
>  4 files changed, 63 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/mach-mx3/cpu.c
> 
> diff --git a/arch/arm/mach-mx3/Makefile b/arch/arm/mach-mx3/Makefile
> index d47a674..47e9358 100644
> --- a/arch/arm/mach-mx3/Makefile
> +++ b/arch/arm/mach-mx3/Makefile
> @@ -4,7 +4,7 @@
>  
>  # Object file lists.
>  
> -obj-y				:= mm.o devices.o
> +obj-y				:= mm.o devices.o cpu.o
>  obj-$(CONFIG_MX3_SDMA)		+= sdma/

So you are working on the SDMA code? Nice. We all hope to see patches
soon ;)

Anyway, please make sure that your patches are based on mainline or
mxc-master.

Applied to mxc-master.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
