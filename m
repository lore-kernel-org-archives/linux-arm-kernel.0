From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Tue, 14 Oct 2014 11:54:32 +0300
Subject: next build: 304 warnings 0 failures (next/next-20141013)
In-Reply-To: <8786463.d9VIC5J1Iz@wuerfel>
References: <543b63d2.a479420a.486e.ffffb6e2@mx.google.com>
 <20141013084618.GC27405@n2100.arm.linux.org.uk>
 <8786463.d9VIC5J1Iz@wuerfel>
Message-ID: <20141014085432.GC2255@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 13, 2014 at 11:12:46AM +0200, Arnd Bergmann wrote:
> On Monday 13 October 2014 09:46:18 Russell King - ARM Linux wrote:
> > On Sun, Oct 12, 2014 at 10:32:02PM -0700, Olof's autobuilder wrote:
> > >       1 arch/arm/mach-cns3xxx/pcie.c:313:1: warning: the frame size of 1072 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > This should be fixed.
> 
> This is an ancient bug, both Mark Brown and I have suggested fixes,
> we just need to apply one of them.
> 
> > >       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]
> > >       1 arch/arm/mach-omap1/board-htcherald.c:296:2: warning: (near initialization for 'gpio_leds[0].gpiod') [enabled by default]
> > >       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: initialization makes pointer from integer without a cast [enabled by default]
> > >       1 arch/arm/mach-omap1/board-htcherald.c:297:2: warning: (near initialization for 'gpio_leds[1].gpiod') [enabled by default]
> > ...
> > 
> > All of these need fixing.
> 
> Hadn't seen this one before, I guess it's because of
> https://lkml.org/lkml/2014/9/16/222.
> 
> adding Mika and Linus to Cc, should be easy to fix using
> named initializers like all other 120+ platforms do,
> but to be on the safe side, we could also move the new
> 'gpiod' member to the end of 'struct gpio_led'.

(+Rafael)

Fenghua's build bot noticed this some time ago and it got fixed but
looks like we forgot to merge the fix to the _DSD patch series.

Here it is again. Rafael, do you want to take this on top of the
'device-properties' -branch?

From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] leds: Move gpiod to be last member of struct gpio_led

Commit 8b0d4dc3d44 (leds: leds-gpio: Add support for GPIO descriptors)
added a new member 'gpiod' to struct gpio_led to support GPIO descriptors.
This is fine as long as board files use designated initializers but some
fail to do so causing following build errors:

  arch/arm/mach-omap1/board-htcherald.c:296:2: warning: initialization makes pointer from integer without a cast [enabled by default]
  arch/arm/mach-omap1/board-htcherald.c:296:2: warning: (near initialization for 'gpio_leds[0].gpiod') [enabled by default]
  arch/arm/mach-omap1/board-htcherald.c:297:2: warning: initialization makes pointer from integer without a cast [enabled by default]
  arch/arm/mach-omap1/board-htcherald.c:297:2: warning: (near initialization for 'gpio_leds[1].gpiod') [enabled by default]

To be on the safe side move the 'gpiod' member to be the last member of struct
gpiod_led.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/leds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7852b9365113..f3af5c4d9084 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -256,12 +256,12 @@ struct led_platform_data {
 struct gpio_led {
 	const char *name;
 	const char *default_trigger;
-	struct gpio_desc *gpiod;
 	unsigned 	gpio;
 	unsigned	active_low : 1;
 	unsigned	retain_state_suspended : 1;
 	unsigned	default_state : 2;
 	/* default_state should be one of LEDS_GPIO_DEFSTATE_(ON|OFF|KEEP) */
+	struct gpio_desc *gpiod;
 };
 #define LEDS_GPIO_DEFSTATE_OFF		0
 #define LEDS_GPIO_DEFSTATE_ON		1
-- 
2.1.1
