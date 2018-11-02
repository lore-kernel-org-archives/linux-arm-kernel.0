From: olof@lixom.net (Olof Johansson)
Date: Fri, 2 Nov 2018 11:28:36 -0700
Subject: [PATCH] ARM: orion: avoid VLA in orion_mpp_conf
In-Reply-To: <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
References: <20181005161601.875388-1-arnd@arndb.de>
 <CAGXu5j+GWO6qB-Raq7XKKoFvwWpg_ZtzYBAEbXiU+N=dTs5YHA@mail.gmail.com>
Message-ID: <20181102182836.z7rabntfzyfcll7k@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 05, 2018 at 09:33:28AM -0700, Kees Cook wrote:
> On Fri, Oct 5, 2018 at 9:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Testing randconfig builds found an instance of a VLA that was
> > missed when determining that we have removed them all:
> >
> > arch/arm/plat-orion/mpp.c: In function 'orion_mpp_conf':
> > arch/arm/plat-orion/mpp.c:31:2: error: ISO C90 forbids variable length array 'mpp_ctrl' [-Werror=vla]
> 
> Ah! Thanks for catching this. It seems "allmodconfig" isn't quite "all". ;)
> 
> > This one is fairly straightforward: we know what all three
> > callers are, and the maximum length is not very long.
> >
> > Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/plat-orion/mpp.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/plat-orion/mpp.c b/arch/arm/plat-orion/mpp.c
> > index 5b4ff9373c89..8a6880d528b6 100644
> > --- a/arch/arm/plat-orion/mpp.c
> > +++ b/arch/arm/plat-orion/mpp.c
> > @@ -28,10 +28,15 @@ void __init orion_mpp_conf(unsigned int *mpp_list, unsigned int variant_mask,
> >                            unsigned int mpp_max, void __iomem *dev_bus)
> 
> arch/arm/mach-dove/mpp.c:       orion_mpp_conf(mpp_list, 0, MPP_MAX,
> DOVE_MPP_VIRT_BASE);
> arch/arm/mach-dove/mpp.c-
> --
> arch/arm/mach-mv78xx0/mpp.c:    orion_mpp_conf(mpp_list, mv78xx0_variant(),
> arch/arm/mach-mv78xx0/mpp.c-                   MPP_MAX, DEV_BUS_VIRT_BASE);
> --
> arch/arm/mach-orion5x/mpp.c:    orion_mpp_conf(mpp_list, orion5x_variant(),
> arch/arm/mach-orion5x/mpp.c-                   MPP_MAX,
> ORION5X_DEV_BUS_VIRT_BASE);
> 
> arch/arm/mach-dove/mpp.h:#define MPP_MAX                        23
> arch/arm/mach-mv78xx0/mpp.h:#define MPP_MAX            49
> arch/arm/mach-orion5x/mpp.h:#define MPP_MAX                     19
> 
> >  {
> >         unsigned int mpp_nr_regs = (1 + mpp_max/8);
> > -       u32 mpp_ctrl[mpp_nr_regs];
> > +       u32 mpp_ctrl[8];
> 
> Largest possible is 1 + 49 / 8 == 7. But 8 makes it nice an round. :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied, thanks!


-Olof
