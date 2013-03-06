From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Mar 2013 16:45:20 +0000
Subject: [V8 PATCH 01/16] usb: phy: mv_usb2: add PHY driver for marvell
 usb2 controller
In-Reply-To: <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
References: <1361419646-9052-1-git-send-email-chao.xie@marvell.com>
 <1361419646-9052-2-git-send-email-chao.xie@marvell.com>
 <20130304142143.GG3397@arwen.pp.htv.fi>
 <CADApbeigW=1fQtUZmLMX8H2+0RiiBFjcSBNojQRSZbCa_ORZVw@mail.gmail.com>
Message-ID: <20130306164520.GO17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 10:03:01AM +0800, Chao Xie wrote:
> On Mon, Mar 4, 2013 at 10:21 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Wed, Feb 20, 2013 at 11:07:11PM -0500, Chao Xie wrote:
> >> +     for (i = 0; i < mv_phy->clks_num; i++) {
> >> +             mv_phy->clks[i] = devm_clk_get(&pdev->dev,
> >> +                                             pdata->clkname[i]);
> >
> > *NEVER* pass clock names via platform_data, this is utterly wrong.
> >
> without device tree support, the only way we can get the clock is the pdata.
> the use phy have mutiple clocks.
> So what do you suggest to handle it?

Then you don't understand the clk API at all.

Read the documentation in include/linux/clk.h for clk_get().

The first parameter is the device which you're interested in getting the
clock for.

The second parameter defines the INPUT as a string to THAT DEVICE.  It
is specific to the device.  It is NOT the system name of the clock.

So, if you have a function clock and an interface clock to a device,
then use a name like "fck" for the function clock and "ick" for the
interface clock.

Do _NOT_ make the mistake of using "global" clock names.  People have done
that many times in the past and got into horrid sticky problems - and
ended up with _far_ more code than is really necessary if you do things
the right way.
