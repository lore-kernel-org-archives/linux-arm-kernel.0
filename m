From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Nov 2012 15:04:12 +0800
Subject: [PATCH 1/4] rtc: sa1100: enable/disable rtc when probe/remove the
 device
In-Reply-To: <20121129102519.GG19440@n2100.arm.linux.org.uk>
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
 <20121129102519.GG19440@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZxUA2PPy4694ByX1FTyWiJkha8QpKFK5Jc3Wf3zT0huOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 6:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 28, 2012 at 09:21:07PM -0500, Chao Xie wrote:
>> The original sa1100_rtc_open/sa1100_rtc_release will be called
>> when the /dev/rtc0 is opened or closed.
>> In fact, these two functions will enable/disable the clock, and
>> register/unregister the irqs.
>> User application will use /dev/rtc0 to read the rtc time or set
>> the alarm. The rtc should still run indepent of open/close the
>> rtc device.
>> So only enable clock and register the irqs when probe the device,
>> and disable clock and unregister the irqs when remove the device.
>
> NAK.  I don't think you properly understand what's going on here if you
> think moving the entire open and release functions into the probe and
> remove functions is the right thing to do.

Since PXA27x & PXA3xx supports dual rtc device at the same time,
user could choose use either of rtc at run time. Then clk & irq are setup
in open().

Chao,
So you shouldn't remove them into probe().
