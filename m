From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:54:33 +0000
Subject: [PATCH 6/7] rtc: sa1100: enable clk support
In-Reply-To: <CAN1soZw=UW+GOJB3SDF4vSZrbHVrk=ShoVLCgH+9CeUSFcfgAw@mail.gmail.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <1329815096-6200-7-git-send-email-haojian.zhuang@marvell.com>
 <20120223103459.GO22562@n2100.arm.linux.org.uk>
 <CAN1soZw=UW+GOJB3SDF4vSZrbHVrk=ShoVLCgH+9CeUSFcfgAw@mail.gmail.com>
Message-ID: <20120223105433.GQ22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 06:40:40PM +0800, Haojian Zhuang wrote:
> On Thu, Feb 23, 2012 at 6:34 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Tue, Feb 21, 2012 at 05:04:55PM +0800, Haojian Zhuang wrote:
> >> @@ -306,6 +308,13 @@ static int sa1100_rtc_probe(struct platform_device *pdev)
> >> ? ? ? if (!info)
> >> ? ? ? ? ? ? ? return -ENOMEM;
> >>
> >> + ? ? info->clk = clk_get(&pdev->dev, NULL);
> >> + ? ? if (IS_ERR(info->clk)) {
> >> + ? ? ? ? ? ? dev_err(&pdev->dev, "failed to find rtc clock source\n");
> >> + ? ? ? ? ? ? ret = PTR_ERR(info->clk);
> >> + ? ? ? ? ? ? goto err_clk;
> >> + ? ? }
> >> + ? ? clk_prepare_enable(info->clk);
> >
> > What about checking for errors from clk_prepare_enable() ?
> >
> > I assume that this is the clock required to access the peripheral, rather
> > than the timekeeping clock? ?If so, does it need to be kept enabled all
> > the time the driver is probed, or can the clock be prepared & enabled and
> > disabled & unprepared when the device is opened/closed ?
> >
> Since some platform code is using RTC register in their suspend/resume
> routine, I have to always enable the clock of rtc module.

So what happens if they don't have the RTC module loaded in their kernel?
The proper solution to this is that they need to take care of that clock
themselves and stop relying on a module being loaded or built-in.
