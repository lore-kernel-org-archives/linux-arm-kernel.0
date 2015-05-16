From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Sat, 16 May 2015 16:09:29 +0800
Subject: [PATCH 0/7] Add SMP bringup support for mt65xx socs
In-Reply-To: <CABuKBeKLtgs56PDO3tEftWNv58-RwtDR2cyxzs4FLX1AFZSKbg@mail.gmail.com>
References: <1430466210-22963-1-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeJ406DUFoVs2p3-u6sW58Dm7XDd6uxCc==Mkq3dMhhd5Q@mail.gmail.com>
 <1430896766.15346.13.camel@mtksdaap41> <1430899182.4930.2.camel@mtksdaap41>
 <CABuKBeLT8-sjPY6ZQXacMZZ_3iKX-g82AB0gPhsi7VW=WdjTTw@mail.gmail.com>
 <CABuKBeKLtgs56PDO3tEftWNv58-RwtDR2cyxzs4FLX1AFZSKbg@mail.gmail.com>
Message-ID: <1431763769.23098.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-06 at 13:04 +0200, Matthias Brugger wrote:
> Hi Joe,
> 
> 2015-05-06 10:29 GMT+02:00 Matthias Brugger <matthias.bgg@gmail.com>:
> > 2015-05-06 9:59 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> >> On Wed, 2015-05-06 at 15:19 +0800, Yingjoe Chen wrote:
> >>> Hi Matthias,
> >> <...>
> >>> > I tried on the mt8135 eval board but it fails to bring up the CPU.
> >>> >
> >>> > When booting:
> >>> > [    1.048588] CPU1: failed to come online
> >>> > [    2.049914] CPU2: failed to come online
> >>> > [    3.051245] CPU3: failed to come online
> >>>
> >>>
> >>> Thanks for testing, and the config file you provided.
> >>> It seems you are running THUMB2 kernel, unfortunately mt8135 trustzone
> >>> firmware doesn't support jump to THUMB2 code directly.
> >>>
> >>> I can workaround this with the following patch. I'll include it in my
> >>> next round.
> >>>
> >>> Joe.C
> >>>
> >>> -----8<----------------
> >>> diff --git a/arch/arm/mach-mediatek/platsmp.c
> >>> b/arch/arm/mach-mediatek/platsmp.c
> >>> index e266b3d..5dea55a 100644
> >>> --- a/arch/arm/mach-mediatek/platsmp.c
> >>> +++ b/arch/arm/mach-mediatek/platsmp.c
> >>> @@ -57,6 +57,18 @@ static const struct of_device_id mtk_smp_boot_infos[]
> >>> __initconst = {
> >>>  static void __iomem *mtk_smp_base;
> >>>  static const struct mtk_smp_boot_info *mtk_smp_info;
> >>>
> >>> +#ifdef CONFIG_THUMB2_KERNEL
> >>> +__asm__(
> >>> +     ".arm\n"
> >>> +     "mtk_secondary_startup_fixup:\n"
> >>> +     "       b secondary_startup\n"
> >>> +     ".thumb\n"
> >>> +);
> >>> +
> >>> +void mtk_secondary_startup_fixup(void);
> >>> +#define secondary_startup mtk_secondary_startup_fixup
> >>> +#endif
> >>
> >>
> >> Replying myself.
> >>
> >> It seems kernel already have secondary_startup_arm which support this
> >> usage. I'll use that in my next version instead.
> >
> > With this I was able to get the board up and running. I will try mt6589 ASAP.
> 
> I just realized, that your aforementioned patch for the THUMB2 kernel
> breaks SMP on mt6589. Strangely without this patch it works fine.
> 

Hi Matthias,

Unfortunately I can't reproduce or figure out why this could happen.
I change to use common kernel code secondary_startup_arm in new series,
could you that a try?
Thanks.

Joe.C
