From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 5 Apr 2012 20:19:57 -0400 (EDT)
Subject: CONFIG_EARLY_PRINTK on versatile broken in mainline
In-Reply-To: <CACxGe6vF7AP99yJaTiqGMRUmgMOwgoM_B=AQFaPxrAfsQyHS9A@mail.gmail.com>
References: <CACxGe6twdkkQaN+ieZoFpjvQAect7-6mUz+N8yULDzwtwHoW1Q@mail.gmail.com>
 <CAOMZO5DFmqz0Rp9oFR7tyofQ9iAfNWXTEYOFVcYvxWPcf6DDMQ@mail.gmail.com>
 <CACxGe6sQ9YR-i4BJOsB0uE7U7gP7Y4Q12rjiEhqQnJGX+FEgfw@mail.gmail.com>
 <CACxGe6tCbnA+tvo3S=m+XjaXXiGF+bLy98CByz7RymH=bfimhg@mail.gmail.com>
 <CACxGe6vF7AP99yJaTiqGMRUmgMOwgoM_B=AQFaPxrAfsQyHS9A@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1204052015360.16314@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Apr 2012, Grant Likely wrote:

> On Thu, Apr 5, 2012 at 4:27 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Thu, Apr 5, 2012 at 4:19 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >> On Thu, Apr 5, 2012 at 4:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> >>> On Thu, Apr 5, 2012 at 7:52 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >>>> Has anyone else had problems with CONFIG_EARLY_PRINTK on current
> >>>> mainline? ?ARM versatile fails to boot on qemu when it is selected.
> >>>> I've just started bisecting. ?v3.3 is okay, but current mainline is
> >>>> broken. ?Output stops after dumping out the memblock regions, and
> >>>> __log_buf stops at the same place.
> >>>
> >>> Please try this patch:
> >>> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/158694
> >>
> >> I've already had that fix applied. ?This is a different issue. ?The
> >> kernel boots fine if CONFIG_EARLY_PRINTK isn't defined.
> >
> > Update: I'm still investigating, but it bisects out to this commit:
> >
> > commit 94e5a85b3be0ce109d26aa6812b2a02c518a0e4b
> > Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > Date: ? Wed Jan 18 15:32:49 2012 +0000
> >
> > ? ?ARM: earlier initialization of vectors page
> 
> The following patch makes it boot.  Calling printch() to output a
> character right after early_trap_init() seems to unblock whatever was
> wedging the system.  A delay or a printk with "" format string doesn't
> have any effect, it seems it must be a character output.  This may be
> a problem in the simulator.  I've not been able to run this on real
> hardware.

FWIW, I have no problem booting v3.4-rc1 for vexpress on the ARM A15 
Fast Model, given the patch referenced above is applied.


Nicolas
