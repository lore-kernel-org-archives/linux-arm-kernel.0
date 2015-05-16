From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 May 2015 22:19:00 +0100
Subject: [PATCH v2 1/9] ARM: correct secondary_startup_arm mode
In-Reply-To: <CABuKBeJwWR1+0mJkStJFNMeOsESKJCH4T1w5HTyUv5q=KAN7EA@mail.gmail.com>
References: <1431763110-443-1-git-send-email-yingjoe.chen@mediatek.com>
 <1431763110-443-2-git-send-email-yingjoe.chen@mediatek.com>
 <CABuKBeJwWR1+0mJkStJFNMeOsESKJCH4T1w5HTyUv5q=KAN7EA@mail.gmail.com>
Message-ID: <20150516211900.GP2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 16, 2015 at 11:08:36AM +0200, Matthias Brugger wrote:
> 2015-05-16 9:58 GMT+02:00 Yingjoe Chen <yingjoe.chen@mediatek.com>:
> > secondary_startup_arm is used as ARM mode secondary start up function
> > when ther kernel is compiled in THUMB mode, however the label itself
> > is still in .thumb mode. readelf shows:
> >
> > 160979: c020a581   120 FUNC    GLOBAL DEFAULT    2 secondary_startup_arm
> >
> > Make sure the label is in ARM mode as well.
> >
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  arch/arm/kernel/head.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index 3637973..58ee8a2 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -346,8 +346,8 @@ __turn_mmu_on_loc:
> >
> >  #if defined(CONFIG_SMP)
> >         .text
> > -ENTRY(secondary_startup_arm)
> >         .arm
> > +ENTRY(secondary_startup_arm)
> >   THUMB(        adr     r9, BSYM(1f)    )       @ Kernel is entered in ARM.
> >   THUMB(        bx      r9              )       @ If this is a Thumb-2 kernel,
> >   THUMB(        .thumb                  )       @ switch to Thumb now.
> 
> This fixes and issue we had with SMP on mt6589.
> 
> Tested-by: Matthias Brugger <matthias.bgg@gmail.com>

Please ensure that this patch ends up in the patch system so it doesn't
get forgotten about, thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
