From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 00:01:42 +0000
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20120223000142.GK7041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 05:04:49PM +0800, Haojian Zhuang wrote:
> Remove the hardcode definition of rtc registers, use ioremap() instead.
> Append clk support for arch-mmp, so add dummy clk in arch-sa1100/arch-pxa.

One final comment: we need to get this sorted, because as things currently
stand, my builds for PXA are failing:

http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx=185

drivers/rtc/rtc-sa1100.c: In function 'sa1100_rtc_open':
drivers/rtc/rtc-sa1100.c:163: error: 'IRQ_RTC1Hz' undeclared (first use in this function)
drivers/rtc/rtc-sa1100.c:163: error: (Each undeclared identifier is reported only once
drivers/rtc/rtc-sa1100.c:163: error: for each function it appears in.)
drivers/rtc/rtc-sa1100.c:169: error: 'IRQ_RTCAlrm' undeclared (first use in this function)
drivers/rtc/rtc-sa1100.c: In function 'sa1100_rtc_release':
drivers/rtc/rtc-sa1100.c:192: error: 'IRQ_RTCAlrm' undeclared (first use in this function)
drivers/rtc/rtc-sa1100.c:193: error: 'IRQ_RTC1Hz' undeclared (first use in this function)
drivers/rtc/rtc-sa1100.c: In function 'sa1100_rtc_suspend':
drivers/rtc/rtc-sa1100.c:341: error: 'IRQ_RTCAlrm' undeclared (first use in this function)
drivers/rtc/rtc-sa1100.c: In function 'sa1100_rtc_resume':
drivers/rtc/rtc-sa1100.c:348: error: 'IRQ_RTCAlrm' undeclared (first use in this function)

which means PXA will be broken in the next merge window.  As that's
mostly down to Rob's IRQ stuff, the simple solution is to get the
conversion to use platform resources in place ASAP, and then start
worrying about the differences between the various SoCs.

What I don't want to be doing is going into the next merge window
with this in its current state.
