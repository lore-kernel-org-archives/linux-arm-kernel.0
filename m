From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 17 Apr 2016 23:37:12 +0200
Subject: [PATCH 1/2] char: PC rtc: replace blacklist with whitelist
In-Reply-To: <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <CAMuHMdU26GkyUYxs3DJOFRB5LTdYCOaGTMUwFMd9YXYhkS1W3g@mail.gmail.com>
Message-ID: <4192558.Mh1hb3LCLb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 11:22:04 Geert Uytterhoeven wrote:
> On Wed, Mar 2, 2016 at 10:48 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Every new architecture has to add itself to the growing list of those
> > that do not support the legacy PC RTC driver.
> >
> > This replaces the long list of architectures that don't support it
> > with a shorter list of those that do.
> >
> > The list is taken from those architectures that have a non-empty
> > asm/mc146818rtc.h header file and were not explicitly blacklisted.
> 
> M68K was blacklisted...

I never got back to you on this topic, sorry about that. I've fixed
up the patch to leave out m68k now.

On a semi-related note, I see that m68k is one of the few architectures
still using the (other) genrtc driver. It would be nice to reduce that
list and change m68k to use its own rtc driver (ideally one per
platform), but the q40 platform is the only one providing
get_rtc_pll()/set_rtc_pll() for the RTC_PLL_GET/RTC_PLL_SET ioctl
commands.

If we do this change on top of the other m68k patch I have, the
rtc-generic driver should be usable as a full replacement for
genrtc.c on m68k and we can remove all the set_rtc_pll/get_rtc_pll
handling from genrtc.

diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 773b2187210d..f4781d612c37 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -100,7 +100,32 @@ static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
+static int rtc_ioctl(struct device *dev, unsigned int cmd, unsigned long arg)
+{
+	struct rtc_pll_info pll;
+	struct rtc_pll_info __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case RTC_PLL_GET:
+		if (!mach_get_rtc_pll || mach_get_rtc_pll(&pll))
+			return -EINVAL;
+		return copy_to_user(argp, &pll, sizeof pll) ? -EFAULT : 0;
+
+	case RTC_PLL_SET:
+		if (!mach_set_rtc_pll)
+			return -EINVAL;
+		if (!capable(CAP_SYS_TIME))
+			return -EACCES;
+		if (copy_from_user(&pll, argp, sizeof(pll)))
+			return -EFAULT;
+		return mach_set_rtc_pll(&pll);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static const struct rtc_class_ops generic_rtc_ops = {
+	.ioctl = rtc_ioctl,
 	.read_time = rtc_generic_get_time,
 	.set_time = rtc_generic_set_time,
 };


	Arnd 
