From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 17 Mar 2015 17:36:41 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150317163641.GM10068@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 17, 2015 at 03:48:38AM +0000, Chris Brandt wrote:
> I've been running XIP_KERNEL with linux-3.14 on a Renesas RZ/A1
> (ARCH_R7S72100) for a while now (with some bug fixes of course) so I
> thought I'd see if my fixes should be pushed back upstream.
> 
> However, I see that all the Renesas parts are being moved to
> ARCH_MULTIPLATFORM, which by means of arch/arm/Kconfig disallows
> XIP_KERNEL.
I think the problem is that there is no agreement on what
"ARCH_MULTIPLATFORM" means.

On one hand it can mean "This platform is available to be selected for a
kernel that supports several different architectures". That's why
MACH_IMX31_DT depends on ARCH_MULTI_V6 and so ARCH_MULTIPLATFORM.

On the other hand we have things like: ARCH_MULTIPLATFORM selects
ARM_PATCH_PHYS_VIRT. These are actually only necessary if you enable
different machines that use different RAM offsets. XIP_KERNEL is in
this category, too.

Now add that you want to do compile testing with random configs. That
means you must somehow describe the condition that allows enabling
XIP_KERNEL. You either have maintain an ugly list which machines might
be enabled together and which are mutually exclusive. Or you accept not
to allow all configs that are technically possible and sensible and go
for XIP_KERNEL depending on !ARCH_MULTIPLATFORM.

So *technically* there is no reason to disallow selecting XIP_KERNEL for
a multiplatform enabled SoC. But to implement the Kconfig logic to allow
that without allowing broken configurations is hardly possible.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
