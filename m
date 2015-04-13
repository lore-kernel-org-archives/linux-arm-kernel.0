From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Apr 2015 17:34:57 +0200
Subject: [PATCH v2 4/6] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <552BCB5A.8010705@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <2254597.TWaxeZsKvK@wuerfel> <552BCB5A.8010705@huawei.com>
Message-ID: <3183355.UnoLoN8dF8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 21:57:46 Bintian wrote:
> Hello Arnd,
> 
> Thanks for your code review.
> 
> On 2015/4/13 21:30, Arnd Bergmann wrote:
> > On Monday 13 April 2015 17:17:38 Bintian Wang wrote:
> >> +#define HI6220_CFG_CSI2PHY     8
> >> +#define HI6220_ISP_SCLK_GATE   9
> >> +#define HI6220_ISP_SCLK_GATE1  10
> >> +#define HI6220_ADE_CORE_GATE   11
> >> +#define HI6220_CODEC_VPU_GATE  12
> >> +#define HI6220_MED_SYSPLL      13
> >> +
> >> +/* mux clocks */
> >> +#define HI6220_1440_1200       20
> >> +#define HI6220_1000_1200       21
> >> +#define HI6220_1000_1440       22
> >> +
> >> +/* divider clocks */
> >> +#define HI6220_CODEC_JPEG      30
> >> +#define HI6220_ISP_SCLK_SRC    31
> >> +#define HI6220_ISP_SCLK1       32
> >>
> >
> > The numbers seem rather arbitrary, and you have both holes as well as duplicate
> > numbers here. I would suggest you do one of two things instead:

> I just worry about some special clocks may be added later so keep some
> holes for them;
>
> The duplicate numbers means clocks belong to different system control
> domains.

I don't understand. How would there be additional clocks added later?
Wouldn't that be a new chip?

If you have separate system control domains, doesn't that mean that you
also have separate DT bindings?

> > a) have a separate header file per clock driver and make all the
> >     numbers unique and consecutive within that header
> >
> > b) use the same numbers as the hardware registers so you can put the
> >     numbers directly into the dts and don't need a header to create
> >     an artificial ABI between the clock driver and the boot loader.
> This header file will be used by device tree (I like using the clock
> name instead "magic number" in dts :) )

That's not how it works though: The dts file is the place to define
the hardware numbers, we do that for all sorts of numbers: interrupts,
gpios, register ranges etc are all defined in dts to avoid putting
magic numbers in external header files.

There are some cases where it gets too ugly for clock controllers
that are highly irregular, but yours doesn't seem to be that kind.

E.g. all the fixed rate clocks should just be separate device nodes,
which lets you remove the binding for that node.

> so how about keep them in one header file and let dts just include
> one header file (not four files), but remove the holes?

The header files constantly cause problems with merge dependencies,
and we have some other companies that keep releasing new chips
that each time require a new header file. If hisilicon plans to make
more chips like this one, please consider coming up with more
generic bindings to avoid this.

	Arnd
