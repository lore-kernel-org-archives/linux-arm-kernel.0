From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 19 Apr 2010 07:17:50 +0200
Subject: [Zaurus-devel] zaurus spitz suspend/resume issue
In-Reply-To: <i2i1f96a3531004181200ve1f71c03ydb7b4328cbcc6e26@mail.gmail.com>
References: <i2i1f96a3531004181200ve1f71c03ydb7b4328cbcc6e26@mail.gmail.com>
Message-ID: <20100419051750.GA1920@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

(please no html on lists)

On Sun 2010-04-18 21:00:13, - Cortez - wrote:
>    Since resuming my spitz from a suspended state doesn't work in 2.6.34-rc3
>    at the moment, I've tried to find out what the problem is with
>    suspend/resume. Using CONFIG_PM_DEBUG I tried to test this by setting
>    /sys/power/pm_test to "core" and switching the device off with the power
>    button. This indeed suspends and resumes the device, but shows following
>    in the system log:

Strange. Suspend works for me in 34-rc3. Config difference?

>    apm-power: Requesting system suspend...
>    PM: Syncing filesystems ...
>    done.
>    Freezing user space processes ... (elapsed 0.02 seconds) done.
>    Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
>    Suspending console(s) (use no_console_suspend to debug)
>    PM: suspend of devices complete after 95.695 msecs
>    PM: late suspend of devices complete after 1.460 msecs
>    suspend debug: Waiting for 5 seconds.
>    PM: early resume of devices complete after 722.103 msecs
>    ------------[ cut here ]------------
>    WARNING: at kernel/irq/manage.c:361 set_irq_wake+0xa4/0x130()
>    Unbalanced IRQ 191 wake disable

spitz has some crazy lets-link-irq-wakeups-together code, that
interacts badly with matrix kbd handler (but does not break
suspend). Try this.
								Pavel

--- ./arch/arm.ofic/mach-pxa/mfp-pxa2xx.c	2009-09-10 00:13:59.000000000 +0200
+++ ./arch/arm/mach-pxa/mfp-pxa2xx.c	2009-12-29 03:16:40.000000000 +0100
@@ -34,7 +34,6 @@
 struct gpio_desc {
 	unsigned	valid		: 1;
 	unsigned	can_wakeup	: 1;
-	unsigned	keypad_gpio	: 1;
 	unsigned	dir_inverted	: 1;
 	unsigned int	mask; /* bit mask in PWER or PKWR */
 	unsigned int	mux_mask; /* bit mask of muxed gpio bits, 0 if no mux */
@@ -178,9 +177,6 @@
 	if (!d->valid)
 		return -EINVAL;
 
-	if (d->keypad_gpio)
-		return -EINVAL;
-
 	mux_taken = (PWER & d->mux_mask) & (~d->mask);
 	if (on && mux_taken)
 		return -EBUSY;
@@ -231,32 +227,6 @@
 #endif /* CONFIG_PXA25x */
 
 #ifdef CONFIG_PXA27x
-static int pxa27x_pkwr_gpio[] = {
-	13, 16, 17, 34, 36, 37, 38, 39, 90, 91, 93, 94,
-	95, 96, 97, 98, 99, 100, 101, 102
-};
-
-int keypad_set_wake(unsigned int on)
-{
-	unsigned int i, gpio, mask = 0;
-
-	if (!on) {
-		PKWR = 0;
-		return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(pxa27x_pkwr_gpio); i++) {
-
-		gpio = pxa27x_pkwr_gpio[i];
-
-		if (gpio_desc[gpio].config & MFP_LPM_CAN_WAKEUP)
-			mask |= gpio_desc[gpio].mask;
-	}
-
-	PKWR = mask;
-	return 0;
-}
-
 #define PWER_WEMUX2_GPIO38	(1 << 16)
 #define PWER_WEMUX2_GPIO53	(2 << 16)
 #define PWER_WEMUX2_GPIO40	(3 << 16)
@@ -273,6 +243,12 @@
 	gpio_desc[(gpio)].mux_mask = PWER_ ## mux ## _MASK;	\
 } while (0)
 
+
+static int pxa27x_pkwr_gpio[] = {
+	13, 16, 17, 34, 36, 37, 38, 39, 90, 91, 93, 94,
+	95, 96, 97, 98, 99, 100, 101, 102
+};
+
 static void __init pxa27x_mfp_init(void)
 {
 	int i, gpio;
@@ -291,7 +267,6 @@
 	for (i = 0; i < ARRAY_SIZE(pxa27x_pkwr_gpio); i++) {
 		gpio = pxa27x_pkwr_gpio[i];
 		gpio_desc[gpio].can_wakeup = 1;
-		gpio_desc[gpio].keypad_gpio = 1;
 		gpio_desc[gpio].mask = 1 << i;
 	}
 
--- ./arch/arm.ofic/mach-pxa/pxa27x.c	2009-09-10 00:13:59.000000000 +0200
+++ ./arch/arm/mach-pxa/pxa27x.c	2009-12-29 03:13:00.000000000 +0100
@@ -323,9 +323,6 @@
 	if (gpio >= 0 && gpio < 128)
 		return gpio_set_wake(gpio, on);
 
-	if (irq == IRQ_KEYPAD)
-		return keypad_set_wake(on);
-
 	switch (irq) {
 	case IRQ_RTCAlrm:
 		mask = PWER_RTC;


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
