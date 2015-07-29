From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 29 Jul 2015 19:17:00 +0800
Subject: [rtc-linux] [PATCH] drivers/rtc/rtc-pl031.c: reset registers in
 init flow
In-Reply-To: <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
References: <1438149721-11072-1-git-send-email-leo.yan@linaro.org>
 <CACRpkdZ5Kvc0LPeG_HAHwejoCRV4JRbpA2+zwNCAxTqzxdDYzQ@mail.gmail.com>
Message-ID: <20150729111700.GA12912@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Jul 29, 2015 at 11:08:30AM +0200, Linus Walleij wrote:
> On Wed, Jul 29, 2015 at 8:02 AM, Leo Yan <leo.yan@linaro.org> wrote:
> 
> > When use rtc-pl031 for suspend test on Hisilicon's SoC Hi6220, Usually
> > the data register (DR) will read back as value zero. So the suspend
> > test code will set the match register (MR) for 10 seconds' timeout; But
> > there have chance later will read back some random values from DR
> > register; So finally miss with match value and will not trigger
> > waken up event anymore.
> >
> > This issue can be dismissed by reset registers in initialization flow;
> > And this code have no harm for ST's variant.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> I don't understand this...

Sorry for confusion. This issue is found when i use file
kernel/power/suspend_test.c to verify the system suspend. Before the
system suspend, the flow need set 10's alarm in RTC for waken up
event.

But what i observed the phenomenon is:

At the init phase:
RTC_LR = 0x0;
RTC_DR = 0x0;
RTC_MR = 0x0;

According to the timeout is 10s, the function *pl031_set_alarm()* will
set RTC_MR = 10; So usually RTC_DR will increase one for every second
and will trigger interrupt when RTC_DR equal to RTC_MR. But on
Hi6220, though the RTC_DR init value is zero, but very soon it will be
set a random value which is bigger than 10. So it will never match with
RTC_MR register anymore; finally the system cannot resume back due the
waken up event will not be triggered.

So suspect RTC_LR has not been initailized correctly and it will load
random value to RTC_DR. After reset the RTC_LR, this issue will be
fixed.

> > +       /* Init registers */
> > +       writel(0x0, ldata->base + RTC_LR);
> 
> This will reset the clock to jan 1st 1970 on every reboot.
> The idea is that the RTC should *preserve* the system time
> if you reboot the system, so NACK.
> 
> Usually userspace has a script using hwclock to read the
> system time from the rtc to system time with hwclock -s
> after userspace comes up. Likewise it writes it back with
> hwclock -w before rebooting.

This change is wrong.

> > +       writel(0x0, ldata->base + RTC_DR);
> 
> This is a read-only register in the PL031 clean variant.
> What do you want to achieve here? Is this register writeable
> on the HiSilicon?

Checked the manual, this register is RO. Will drop it.

> > +       writel(0x0, ldata->base + RTC_IMSC);
> 
> OK
> 
> > +       writel(RTC_BIT_AI, ldata->base + RTC_ICR);
> 
> So why do we want to have the alarm enabled by
> default, before the kernel nor userspace has requested
> it?

This is to clear any pending interrupt, but not enable alarm.

> If your problem is with suspend/resume I suggest you work
> on the [runtime]_suspend/resume hooks instead of probe().
> Possibly you need to save/restore state across suspend/resume.

Do you think below change is make sense?

---8<---

diff --git a/drivers/rtc/rtc-pl031.c b/drivers/rtc/rtc-pl031.c
index 99181fff..c461e03 100644
--- a/drivers/rtc/rtc-pl031.c
+++ b/drivers/rtc/rtc-pl031.c
@@ -345,6 +345,10 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_dbg(&adev->dev, "designer ID = 0x%02x\n", amba_manf(adev));
 	dev_dbg(&adev->dev, "revision = 0x%01x\n", amba_rev(adev));
 
+	/* Init registers */
+	writel(0x0, ldata->base + RTC_IMSC);
+	writel(RTC_BIT_AI, ldata->base + RTC_ICR);
+
 	data = readl(ldata->base + RTC_CR);
 	/* Enable the clockwatch on ST Variants */
 	if (vendor->clockwatch)
@@ -368,6 +372,9 @@ static int pl031_probe(struct amba_device *adev, const struct amba_id *id)
 				writel(time, ldata->base + RTC_LR);
 			}
 		}
+	} else {
+		time = readl(ldata->base + RTC_DR);
+		writel(time, ldata->base + RTC_LR);
 	}
 
 	device_init_wakeup(&adev->dev, 1);

Thanks,
Leo Yan
