From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 15:24:04 +0200
Subject: [PATCH 17/26] ARM: pxa: pxa95x is incompatible with earlier pxa
In-Reply-To: <CAN1soZy3_9Trycti8SCbnO75N6NE31tFqrKMpZtiJPgwNc2cbg@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<CAMPhdO_L-g4vSj3fC-1ckqnHGAPhWOy6Hm4VL5iUbZbbdjRkNQ@mail.gmail.com>
	<CAN1soZy3_9Trycti8SCbnO75N6NE31tFqrKMpZtiJPgwNc2cbg@mail.gmail.com>
Message-ID: <1499585.ED4ktnBDpX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 October 2011 11:32:14 Haojian Zhuang wrote:
> 
> Eric,
> 
> At first, a new macro (ARCH_PXA_V7) is defined in
> arch/arm/mach-pxa/Kconfig in this patch.
> I prefer to move this macro to arch/arm/Kconfig.

If we move it to arch/arm/Kconfig, I would prefer making it a global option,
not a pxa specific one. If we introduce a top-level CONFIG_CPU_V6PLUS
option, we can make a number of decisions inside of Kconfig depend on that,
especially as we move to allow building multiple v6/v7 platforms together,
or multiple v5 platforms for that matter. I believe we don't need to
worry about v5+v7 at this point and can instead assume that won't ever
happen.

> Secondly, pxa95x is both used in saarb and tavorevb3.

The patch makes that very explicit, doesn't it?

> Thirdly, PXA_V7_MACH_AUTO is unnecessary. We just need to select those
> machines in defconfig or define a new DT machine type to select all
> machines.

Enabling them in defconfig will not help here, it still allows creating
an invalid configuration by disabling both saarb and tavorevb3.
I agree that it would be best to have a single DT machine type that can
handle both saarb and tavorevb3 as well as any future pxa95x based machines,
but nobody has implemented that yet. In the meantime, I think we should
have the PXA_V7_MACH_AUTO or an equivalent mechanism to enforce that at
least one of the two board files gets built into any kernel. This is mostly
important to help the 'make randconfig' builds succeed, not for actual
users getting it wrong accidentally.

	Arnd
