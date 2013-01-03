From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 3 Jan 2013 01:48:34 +0100
Subject: [PATCH v2 00/11] ARM: S3C24XX: rework irq handling for a later dt
 usage
In-Reply-To: <042901cde941$bb8d2d30$32a78790$@samsung.com>
References: <201301012251.15899.heiko@sntech.de>
 <042901cde941$bb8d2d30$32a78790$@samsung.com>
Message-ID: <201301030148.35569.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 3. Januar 2013, 00:34:36 schrieb Kukjin Kim:
> Heiko St?bner wrote:
> > Second version of redoing the s3c24xx irqs in a generic way by using a
> > declarative approach.
> > 
> > Changes include further generalizations resulting only in common
> > irq-type declarations being needed and thus again easier code.
> > 
> > As in the first version, the 1st patch might be hard to read due to the
> > rewrite character, but I didn't see a way to do these changes in
> > individual steps. So it might be helpful to look at the result after
> > applying this patch.
> > 
> > Runtime-tested on a s3c2416 based board and compile tested for the
> > others.
> > 
> > As also written before, inclusion of the other S3C24XX SoCs to follow
> > once the general approach is acceptable.
> > 
> > Heiko Stuebner (11):
> >   ARM: S3C24XX: transform irq handling into a declarative form
> >   ARM: S3C24XX: move irq-pm code into main irq file
> >   ARM: S3C24XX: cleanup irq-pm integration
> >   ARM: S3C24XX: move s3c2416 irq init to common irq code
> >   ARM: S3C24XX: modify s3c2416 irq init to initialize all irqs
> >   ARM: S3C24XX: assimilate s3c2416 subirqs into new structure
> >   ARM: S3C24XX: assimilate second s3c2416 interrupt into new structure
> >   ARM: S3C24XX: move s3c2443 irq code to irq.c
> >   ARM: S3C24XX: modify s3c2443 irq init to initialize all irqs
> >   ARM: S3C24XX: assimilate s3c2443 subirqs into new structure
> >   ARM: S3C24XX: remove maskack irq ack funtions
> >  
> >  arch/arm/mach-s3c24xx/Makefile               |    6 +-
> >  arch/arm/mach-s3c24xx/common.h               |    2 +
> >  arch/arm/mach-s3c24xx/irq-pm.c               |   95 ---
> >  arch/arm/mach-s3c24xx/irq-s3c2416.c          |  348 --------
> >  arch/arm/mach-s3c24xx/irq-s3c2443.c          |  281 -------
> >  arch/arm/mach-s3c24xx/mach-smdk2416.c        |    2 +-
> >  arch/arm/mach-s3c24xx/mach-smdk2443.c        |    2 +-
> >  arch/arm/mach-s3c24xx/s3c2410.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2412.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2416.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2440.c              |    4 +-
> >  arch/arm/mach-s3c24xx/s3c2442.c              |    4 +-
> >  arch/arm/plat-s3c24xx/Kconfig                |    1 +
> >  arch/arm/plat-s3c24xx/irq.c                  | 1092
> >  +++++++++++++++----------- arch/arm/plat-samsung/include/plat/pm.h     
> >  |    6 -
> >  arch/arm/plat-samsung/include/plat/s3c2416.h |    1 +
> >  arch/arm/plat-samsung/include/plat/s3c2443.h |    2 +
> >  17 files changed, 649 insertions(+), 1209 deletions(-)
> >  delete mode 100644 arch/arm/mach-s3c24xx/irq-pm.c
> >  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2416.c
> >  delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2443.c
> 
> Hi Heiko,
> 
> Happy New Year!

a happy new year to you too

> Basically, looks OK but will look at in this weekend :-)

cool :-)

> BTW, I have no idea why you want to keep the irq.c in plat-s3c24xx. As I
> said, I'm cleaning up the plat-s3c24xx directory and it will be going
> away.

As you might have seen I tried to move it to drivers/irqchip in the past and 
it seems only drivers using the new irqchip init stuff should go there now.

So I left it where it is for now, to see how far I get with the modifications 
first. So, as drivers/irqchip is out of the question for now, should we move 
it to mach-s3c24xx in the meantime?

As I still need to also send the redone devicetree patches on top of this 
series, I could do the move there to a location you prefer :-)


Heiko
