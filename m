From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 28 Mar 2014 17:17:32 -0700
Subject: [PATCH 0/8] Generic serial earlycon
In-Reply-To: <CAL_JsqKjGjyYypwneCmNc1qeKe0ZOG9gz3QSJ37-HwHXKu3iRA@mail.gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com> <
 201403221054.39799.arnd@arndb.de> <
 CAL_JsqKjGjyYypwneCmNc1qeKe0ZOG9gz3QSJ37-HwHXKu3iRA@mail.gmail.com>
Message-ID: <20140329001732.BECE2C41FF4@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 22 Mar 2014 09:14:31 -0500, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Mar 22, 2014 at 4:54 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 21 March 2014, Rob Herring wrote:
> >> From: Rob Herring <robh@kernel.org>
> >>
> >> This started out as an attempt to add arm64's earlyprintk support to ARM
> >> in order to get an earlier, runtime setup console on multi-platform
> >> kernels. The first issue was needing the fixmap support which
> >> conveniently Mark Salter was working on and is mostly in place now. Like
> >> many things on ARM and arm64 now, it then became where do I put the now
> >> common, shared code. After digging more into various early console/printk
> >> support, it turns out the 8250_early.c setup code was the best starting
> >> point.
> >>
> >> This is based on Mark Salter's fixmap support currently in linux-next.
> >> This is tested on arm64 and ARM with pl011 and 8250. The ARM support
> >> also requires fixmap and fixed mapping support which are not yet in place.
> >> I have some patches in my tree to support fixmap, but they need some more
> >> work. Fortunately, once fixmap is in place, it is just a Kconfig option
> >> to enable earlycon support on ARM. A git tree is available here[1].
> >>
> >> Based on this series, I would like to add support for doing earlycon
> >> setup using DT.
> >
> > Hi Rob,
> >
> > I like this series a lot, great work!
> >
> > I would consider the DT parsing support essential here, we should not
> > merge the patches until that is done as well, because I don't want
> > to see users pass earlycon command line options in DT when they can
> > use the established "linux,stdout-path" property instead. I would
> > expect that in almost every case in which we are booting using DT
> > today, we can just use linux,stdout-path to locate the device that
> > the boot loader has already set up and start usign it.
> 
> I think this series stands on its own. It is largely refactoring
> existing code and supporting existing command line options (arm64 just
> changes from earlyprintk= to earlycon=). There will be cases where
> changing the kernel command line is the only way to setup the
> earlycon. Also, I think we would still want the kernel command line to
> control whether or not we enable the earlycon (i.e. earlycon=dt).
> There's not a standard way for how bootloaders would decide to set
> "linux,stdout-path" or not.

I agree. I really like this series and I don't think it needs to wait
for DT parsing.

Another issue is that the earlycon assumes the port is already set up,
but the /chosen/stdout-path binding doesn't guarantee that. We'll have
to make sure the kernel knows when it is valid to use
/chosen/stdout-path before enabling an early console.

g.
