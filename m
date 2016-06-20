From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Jun 2016 01:07:55 +0200
Subject: [PATCH v3 0/5] i.MX L2-cache code cleanups and performance tweaks
In-Reply-To: <CAHQ1cqGQm1jXAx0C97qODGEOM_r91aRZ50c_p5vJfHifOL3hiQ@mail.gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
 <114981982.VXDIiN0rdz@wuerfel>
 <CAHQ1cqGQm1jXAx0C97qODGEOM_r91aRZ50c_p5vJfHifOL3hiQ@mail.gmail.com>
Message-ID: <4896650.lS63LY4PpR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 19, 2016 10:53:13 AM CEST Andrey Smirnov wrote:
>  One more question, less about your patches than the existing code:
> >
> > After going through the current users of l2x0_init for board files,
> > I noticed that imx35 enables l2x0 for both dts and all the board files
> > and has an arm,l210-cache node in its dts, but imx31 only enables
> > it for the board file and in the dt case doesn't init the cache nor
> > does it have the dts node.
> >
> > I'm guessing this is a bug on i.mx31 dt support, right?
> 
> I would agree that it is. OTOH, I can't find any i.MX31 boards that
> use device tree. The only file that references imx31.dtsi is
> imx31-bug.dts, but at the same time that board has a dedicated board
> file (mach-bug.c) so I wonder if it was ever used.

My understanding is that many of the i.mx dts files were introduced
a few years ago as conversions of the board files, and we are now
in the (slow) process of removing the board files, assuming that
everyone has had time for migration if they still run that hardware
on new kernels, or that it doesn't hurt if nobody uses it.

This one was added with the comment

    arm/dts: Add support for i.MX31 bug 1.x board from buglabs.
    
    Only the main UART and the memory node information are added.

and it's unclear if that has ever been tested. A few device nodes
were added to the imx31.dtsi file later, indicating that it probably
had /some/ testing, but no other board file was ever added as you
say. The only difference I see between mach-bug.c and imx31-bug.dts
is the configuration of the uart pins. I don't know if that is
required in the dts, because I'd assume that the boot loader would
leave the pinmux in a state in which the console uart works.

> It looks like Sacha was the author of i.MX31, Sascha do you have any
> comment on this?
> 
> There's also another small cleanup opportunity in collapsing
> imx31_dt_timer_init() and mx31_clocks_init_dt() into a single function
> given how the latter always returns 0 and can be converted to void.

Or we could go one step further and use CLK_OF_DECLARE() to remove
that init function entirely. Same thing for mx31_init_irq and
IRQCHIP_DECLARE().

> I am more than happy to make both changes and include them in the set,
> but I only have i.MX6 HW, and would only be able to do a compile-test,
> so I am not sure if I should.

Let's wait for Sascha to reply.

	Arnd
