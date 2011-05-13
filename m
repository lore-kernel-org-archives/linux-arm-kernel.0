From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri, 13 May 2011 14:13:49 +0400
Subject: [PATCH] pxa/hx4700: Avoid unbalanced irq wakeup enables/disables
In-Reply-To: <E1QHn5f-0004Rb-6j@outmx07.plus.net>
References: <E1QHn5f-0004Rb-6j@outmx07.plus.net>
Message-ID: <20110513101348.GA18716@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01:10 Thu 05 May     , Paul Parsons wrote:
> Resuming a suspended hx4700 results in Unbalanced IRQ warnings:
> 
> WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0xe0/0xec()
> Unbalanced IRQ 246 wake disable
> ..
> 
> Likewise for IRQ 241 and IRQ 243. The 3 ASIC3 GPIO buttons - RECORD/CALENDAR/HOME - each fail in a call to enable_irq_wake() in gpio_keys_suspend() because of an absent irq_set_wake() handler in the asic3_gpio_irq_chip structure. Matching calls to disable_irq_wake() in gpio_keys_resume() then print the warnings. Since we should never need to resume via the 3 ASIC3 GPIO buttons, nor 2 of the 3 builtin GPIO buttons - MAIL/CONTACTS, the simplest remedy for the warnings is to enable irq wakeup on the POWER button only.

Not sure if it's right to allow only POWER button to wake the device.
In both Windows CE and handhelds.org 2.6.21 kernel any button can wake
device, and even start corresponding action (i.e. run some app) after wakeup.
I think we should just disable wakeup on ASIC3 button for now, and/or think
about how to implement .set_wake in ASIC3.

For first part I mean something like this (not sure if it still applies,
but you should get the idea):

Date: Sat, 31 Jul 2010 11:55:25 +0400
Subject: [PATCH 17/47] pxa/hx4700: don't wake on ASIC3 buttons

Currently ASIC3 driver doesn't support set_wake on its GPIOs,
which leads to "Unbalanced IRQ ### wake disable" warnings on wakeup.
Workaround this by simply not using buttons connected to ASIC3
gpios as wakeup sources.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-pxa/hx4700.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-pxa/hx4700.c b/arch/arm/mach-pxa/hx4700.c
index fa33fef..6c78f93 100644
--- a/arch/arm/mach-pxa/hx4700.c
+++ b/arch/arm/mach-pxa/hx4700.c
@@ -202,23 +202,23 @@ static struct pxaficp_platform_data ficp_info = {
  * GPIO Keys
  */
 
-#define INIT_KEY(_code, _gpio, _active_low, _desc)	\
+#define INIT_KEY(_code, _gpio, _active_low, _wake, _desc)	\
 	{						\
 		.code       = KEY_##_code,		\
 		.gpio       = _gpio,			\
 		.active_low = _active_low,		\
 		.desc       = _desc,			\
 		.type       = EV_KEY,			\
-		.wakeup     = 1,			\
+		.wakeup     = _wake,			\
 	}
 
 static struct gpio_keys_button gpio_keys_buttons[] = {
-	INIT_KEY(POWER,       GPIO0_HX4700_nKEY_POWER,   1, "Power button"),
-	INIT_KEY(MAIL,        GPIO94_HX4700_KEY_MAIL,    0, "Mail button"),
-	INIT_KEY(ADDRESSBOOK, GPIO99_HX4700_KEY_CONTACTS,0, "Contacts button"),
-	INIT_KEY(RECORD,      GPIOD6_nKEY_RECORD,        1, "Record button"),
-	INIT_KEY(CALENDAR,    GPIOD1_nKEY_CALENDAR,      1, "Calendar button"),
-	INIT_KEY(HOMEPAGE,    GPIOD3_nKEY_HOME,          1, "Home button"),
+	INIT_KEY(POWER,       GPIO0_HX4700_nKEY_POWER,   1, 1, "Power button"),
+	INIT_KEY(MAIL,        GPIO94_HX4700_KEY_MAIL,    0, 1, "Mail button"),
+	INIT_KEY(ADDRESSBOOK, GPIO99_HX4700_KEY_CONTACTS,0, 1, "Contacts button"),
+	INIT_KEY(RECORD,      GPIOD6_nKEY_RECORD,        1, 0, "Record button"),
+	INIT_KEY(CALENDAR,    GPIOD1_nKEY_CALENDAR,      1, 0, "Calendar button"),
+	INIT_KEY(HOMEPAGE,    GPIOD3_nKEY_HOME,          1, 0, "Home button"),
 };
 
 static struct gpio_keys_platform_data gpio_keys_data = {

-- 
Best regards,
Dmitry "MAD" Artamonow
