From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 20 Dec 2010 12:50:59 +0100
Subject: [PATCH v7 05/15] ARM: mxs: Add low-level debug UART support
In-Reply-To: <1292679575-2635-4-git-send-email-shawn.guo@freescale.com>
References: <1292679575-2635-1-git-send-email-shawn.guo@freescale.com>
	<1292679575-2635-4-git-send-email-shawn.guo@freescale.com>
Message-ID: <20101220115059.GA8885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I discovered this weekend that the DUART is just an amba-pl011 which
is already supported in mainline. So we should use the existing
infrastructure here.

On Sat, Dec 18, 2010 at 09:39:29PM +0800, Shawn Guo wrote:

>  - DEBUG_LL support, which is incompatible with multi-soc MXS image
>    because of different DUART base address on MX23 and MX28

We should be able to use the AMBA identification signature to distinguish at
runtime, no?

>  - uncompress message support
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

>  arch/arm/mach-mxs/include/mach/debug-macro.S |   52 ++++++++++++++++++

We should use asm/hardware/debug-pl01x.S, like the other users:

wsa at katana:~/Kernel/linux-2.6/arch/arm$ g debug-pl01x
include/asm/hardware/debug-pl01x.S:1:/* arch/arm/include/asm/hardware/debug-pl01x.S
mach-cns3xxx/include/mach/debug-macro.S:19:#include <asm/hardware/debug-pl01x.S>
mach-ep93xx/include/mach/debug-macro.S:21:#include <asm/hardware/debug-pl01x.S>
mach-integrator/include/mach/debug-macro.S:20:#include <asm/hardware/debug-pl01x.S>
mach-nomadik/include/mach/debug-macro.S:20:#include <asm/hardware/debug-pl01x.S>
mach-realview/include/mach/debug-macro.S:42:#include <asm/hardware/debug-pl01x.S>
mach-u300/include/mach/debug-macro.S:21:#include <asm/hardware/debug-pl01x.S>
mach-ux500/include/mach/debug-macro.S:26:#include <asm/hardware/debug-pl01x.S>
mach-versatile/include/mach/debug-macro.S:21:#include <asm/hardware/debug-pl01x.S>
mach-vexpress/include/mach/debug-macro.S:21:#include <asm/hardware/debug-pl01x.S>


>  arch/arm/mach-mxs/include/mach/uncompress.h  |   76 ++++++++++++++++++++++++++

Auto-detection could be used here, too?

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101220/da1846e6/attachment.sig>
