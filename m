From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 14 Jan 2016 11:29:24 +0100
Subject: [PATCH V4 16/16] ARM64: tegra: select PM_GENERIC_DOMAINS
In-Reply-To: <11122786.kKumQ3Dhls@wuerfel>
References: <1449241037-22193-1-git-send-email-jonathanh@nvidia.com>
 <8579242.omBpg1aLr2@wuerfel>
 <CAPDyKFrewx5CbS9QKZAxqq0Gu+TywQ3nkDGZFURR=PJLtkDuyQ@mail.gmail.com>
 <11122786.kKumQ3Dhls@wuerfel>
Message-ID: <20160114102924.GA22340@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 10:21:06AM +0100, Arnd Bergmann wrote:
> On Thursday 14 January 2016 09:57:14 Ulf Hansson wrote:
> > On 13 January 2016 at 21:43, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Wednesday 13 January 2016 18:03:24 Thierry Reding wrote:
> > >> On Fri, Dec 04, 2015 at 02:57:17PM +0000, Jon Hunter wrote:
> > >> > Enable PM_GENERIC_DOMAINS for tegra 64-bit devices. To ensure that devices
> > >> > dependent upon a particular power-domain are only probed when that power
> > >> > domain has been powered up, requires that PM is made mandatory for tegra
> > >> > 64-bit devices and so select this option for tegra as well.
> > >> >
> > >> > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > >> > ---
> > >> >  arch/arm64/Kconfig.platforms | 2 ++
> > >> >  1 file changed, 2 insertions(+)
> > >> >
> > >> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > >> > index 9806324fa215..e0b5bd0aff0f 100644
> > >> > --- a/arch/arm64/Kconfig.platforms
> > >> > +++ b/arch/arm64/Kconfig.platforms
> > >> > @@ -93,6 +93,8 @@ config ARCH_TEGRA
> > >> >       select GENERIC_CLOCKEVENTS
> > >> >       select HAVE_CLK
> > >> >       select PINCTRL
> > >> > +     select PM
> > >> > +     select PM_GENERIC_DOMAINS
> > >> >       select RESET_CONTROLLER
> > >> >       help
> > >> >         This enables support for the NVIDIA Tegra SoC family.
> > >>
> > >> This has potential consequences for multi-platform builds, doesn't it?
> > >> All of a sudden any combination of builds that includes Tegra won't be
> > >> possible to build without PM support.
> > >>
> > >> Adding linux-arm-kernel at lists.infradead.org for visibility.
> > >>
> > >>
> > >
> > > Agreed, it would be better to add 'depends on PM_GENERIC_DOMAINS'
> > > dependencies in the drivers that require it.
> > >
> > 
> > The problem with that approach is that if those drivers are cross SoC
> > drivers. In some cases PM isn't needed and it is.
> > 
> > Of course I don't have the in depth knowledge about the drivers being
> > used in Tegra which may need PM, perhaps it's not that many?
> > 
> > Anyway, to me it seems like ARCH_TEGRA should depend on PM instead.
> > Would that work?
> 
> That seems a little over-restrictive, as it prevents you from
> building a tegra kernel even if none of the drivers that rely
> on the pm domains are used, but it would work.
> 
> I've looked again at how other platforms (on arm32) do it, and
> a lot of them use "select PM_GENERIC_DOMAINS if PM", so they don't
> automatically enable PM, but they enable the pmdomain code if
> PM is already set. No driver really "depends on PM_GENERIC_DOMAINS",
> so we shouldn't really start that now or we end up with circular
> dependencies in the long run.

It just occurred to me that none of these options really make much of a
difference. As Jon mentioned once we merge this series a lot of features
on Tegra will start to rely on PM_GENERIC_DOMAINS and hence PM. So if we
do want to build a kernel with a maximum of Tegra features enabled (and
I think a multi_v7_defconfig should include that) we'll end up with a PM
dependency anyway, whether forced via select or implied via depends on.

I'm beginning to wonder if PM really should be an option these days. The
disadvantages of making it optional do outweigh the advantages in my
opinion. I'm not saying that, in general, it's totally useless to build
a kernel that has no PM support, but for the more specific case where
you would want to enable multi-platform support I don't think there's
much practical advantage in allowing !PM. One of the most common build
warnings are triggered because of this option. Also multi-platform
kernels are really big already, so much so that I doubt it would make a
significant difference if we unconditionally built PM support. Also the
chances are that we'll be seeing more and more SoCs support PM and rely
on it, much like Tegra would with the addition of this series.

I imagine that we could save ourselves a lot of headaches by simply
enabling PM by default, whether that be via the PM Kconfig option or by
selecting it from ARCH_TEGRA and any other architectures that may come
to rely on it. Doing so would also reduce the amount of test coverage
that we need to do, both at compile- and runtime.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160114/e891b13c/attachment.sig>
