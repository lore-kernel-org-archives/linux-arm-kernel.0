From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Aug 2015 15:17:27 -0300
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.3
In-Reply-To: <CAOesGMg_TocMprCDQK69CTLtnyiyf4hn_hEzWoEhdKsXH3OuBw@mail.gmail.com>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
 <20150818201416.GA4732@localhost>
 <CAOesGMg_TocMprCDQK69CTLtnyiyf4hn_hEzWoEhdKsXH3OuBw@mail.gmail.com>
Message-ID: <CAOMZO5AL2iFJSpSukcV44Y=JZecRrm0sCRZQgyTM6w8_R6OHqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Wed, Aug 19, 2015 at 2:55 PM, Olof Johansson <olof@lixom.net> wrote:

> It looks like these changes broke ARM allmodconfig:
>
> arch/arm/mach-imx/built-in.o: In function `ksz8081_phy_fixup':
> :(.text+0x8bcc): undefined reference to `mdiobus_write'
> :(.text+0x8bf0): undefined reference to `mdiobus_write'
> :(.text+0x8c28): undefined reference to `mdiobus_write'
> :(.text+0x8c4c): undefined reference to `mdiobus_write'
> arch/arm/mach-imx/built-in.o: In function `imx6ul_init_machine':
> :(.init.text+0xa714): undefined reference to `phy_register_fixup_for_uid'
>
> Whole output is at:
>
> http://arm-soc.lixom.net/buildlogs/arm-soc/v4.2-rc2-861-gdb5c5fd/buildall.arm.allmodconfig.log.failed
>
> Please send an incremental fix (or I can drop this branch if you need
> more time).

Does this fix it?

--- a/arch/arm/mach-imx/mach-imx6ul.c
+++ b/arch/arm/mach-imx/mach-imx6ul.c
@@ -45,7 +45,9 @@ static int ksz8081_phy_fixup(struct phy_device *dev)

 static void __init imx6ul_enet_phy_init(void)
 {
-       phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
ksz8081_phy_fixup);
+       if (IS_BUILTIN(CONFIG_PHYLIB))
+               phy_register_fixup_for_uid(PHY_ID_KSZ8081, 0xffffffff,
+                                          ksz8081_phy_fixup);
 }
