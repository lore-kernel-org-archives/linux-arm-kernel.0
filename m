From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 17 Mar 2012 21:29:31 +0100
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
References: <1331878280-2758-1-git-send-email-mturquette@linaro.org>
 <alpine.DEB.2.00.1203161509470.4395@utopia.booyaka.com>
 <CAJOA=zPmy7Dwzw8EOCW_+cvy2Dv=w0TPUq7Zg_s=Y0rs+v+u2w@mail.gmail.com>
 <201203170905.33191.arnd@arndb.de>
 <CAJOA=zNVSWR6xZEfx4hioB-Q7M6PsrP9gdvJc1t+YN=QVE=83w@mail.gmail.com>
Message-ID: <20120317202931.GN3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 17, 2012 at 11:02:11AM -0700, Turquette, Mike wrote:
> On Sat, Mar 17, 2012 at 2:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 16 March 2012, Turquette, Mike wrote:
> >> On Fri, Mar 16, 2012 at 3:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > From: Paul Walmsley <paul@pwsan.com>
> >> > Date: Fri, 16 Mar 2012 16:06:30 -0600
> >> > Subject: [PATCH] clk: mark the common clk code as EXPERIMENTAL for now
> >> >
> >> > Mark the common clk code as depending on CONFIG_EXPERIMENTAL. ?The API
> >> > is not well-defined and both it and the underlying mechanics are likely
> >> > to need significant changes to support non-trivial uses of the rate
> >> > changing code, such as DVFS with external I/O devices. ?So any platforms
> >> > that switch their implementation over to this may need to revise much
> >> > of their driver code and revalidate their implementations until the
> >> > behavior of the code is better-defined.
> >> >
> >> > A good time for removing this EXPERIMENTAL designation would be after at
> >> > least two platforms that do DVFS on groups of external I/O devices have
> >> > ported their clock implementations over to the common clk code.
> >> >
> >> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> >> > Cc: Mike Turquette <mturquette@ti.com>
> >>
> >> ACK. ?This will set some reasonable expectations while things are in flux.
> >>
> >> Arnd are you willing to take this in?
> >
> > I think it's rather pointless, because the option is not going to
> > be user selectable but will get selected by the platform unless I'm
> > mistaken. The platform maintainers that care already know the state
> > of the framework. Also, there are no user space interfaces that we
> > have to warn users about not being stable, because the framework
> > is internal to the kernel.
> 
> The consensus seems to be to not set experimental.
> 
> > However, I wonder whether we need the patch below to prevent
> > users from accidentally enabling COMMON_CLK on platforms that
> > already provide their own implementation.
> >
> > ? ? ? ?Arnd
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 2eaf17e..a0a83de 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -12,7 +12,7 @@ config HAVE_MACH_CLKDEV
> >
> > ?menuconfig COMMON_CLK
> > - ? ? ? bool "Common Clock Framework"
> > + ? ? ? bool
> > ? ? ? ?select HAVE_CLK_PREPARE
> > ? ? ? ?---help---
> > ? ? ? ? ?The common clock framework is a single definition of struct
> > ? ? ? ? ?clk, useful across many platforms, as well as an
> 
> Much like experimental I'm not sure how needed this change is.  The
> help section does say to leave it disabled by default, if unsure.  If
> you merge it I won't object but this might be fixing an imaginary
> problem.

Architectures without common clock support won't build with this option
enabled (multiple definition of clk_enable etc), so I think this should
not be user visible.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
