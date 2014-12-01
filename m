From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Dec 2014 15:47:03 +0100
Subject: [PATCH v3 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <CACRpkdb1nZN-vOXLC-QFUAT9wDGM2Nm5YeH0qY_u2JV9toOaVg@mail.gmail.com>
References: <1417156188-500-1-git-send-email-wangzhou.bry@gmail.com>
 <547971BF.1050706@gmail.com>
 <CACRpkdb1nZN-vOXLC-QFUAT9wDGM2Nm5YeH0qY_u2JV9toOaVg@mail.gmail.com>
Message-ID: <2571535.P78Okb1jGf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 15:04:49 Linus Walleij wrote:
> On Sat, Nov 29, 2014 at 8:11 AM, Zhou Wang <wangzhou.bry@gmail.com> wrote:
> > On 2014?11?28? 17:33, Arnd Bergmann wrote:
> >> On Friday 28 November 2014 14:29:47 Zhou Wang wrote:
> 
> >>>          default 264 if MACH_H4700
> >>> +       default 128 if ARCH_HIP04
> >>>          default 0
> >>>          help
> >>>            Maximum number of GPIOs in the system.
> >>>
> >>
> >> If I remember correctly, you don't actually need to set this if all gpio
> >> clients are using the new gpio descriptor interfaces instead of gpio
> >> numbers. Would that work for you? You'd have to know which devices
> >
> > If I don't set this, it will use the default ARCH_NR_GPIO(512), then
> > the range of GPIO number will be 384~511 which is very strange to users,
> > because Hip04 based machines can only support 128 GPIOs.
> 
> That is a totally different problem.
> 
> Not that these numbers have ever been stable...

Right, in particular, it would be different between hisi_defconfig
and multi_v7_defconfig.

> Think of a patch to gpiochip_find_base() in
> drivers/gpio/gpiolib.c to fix this so that numbers are
> assigned a better way rather than doing
> random hacks with numbers like this.

Maybe we can find the highest number that is ever allocated
statically by any driver (since it's all from source code), and do
the dynamic allocations forward from that number instead of allocating
backward?

Or could we try to find the drivers that use DT /and/ allocate a static
number and then see if we can avoid the need for static numbers for
those?

	Arnd
