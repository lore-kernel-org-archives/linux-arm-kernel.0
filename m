From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 12 Jan 2010 15:46:26 -0500
Subject: [PATCH 1/3] ARM: SAMSUNG: Add config option for number
	ofadditional GPIO pins.
In-Reply-To: <20100112001526.GH1224@trinity.fluff.org>
References: <1263203046-29219-1-git-send-email-kgene.kim@samsung.com><20100111103338.GA3440@sirena.org.uk><20100111122715.GG1224@trinity.fluff.org><20100111124927.GB27161@rakim.wolfsonmicro.main>
	<20100112001526.GH1224@trinity.fluff.org>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089AF8@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, January 11, 2010 5:15 PM, Ben Dooks wrote:
> On Mon, Jan 11, 2010 at 12:49:27PM +0000, Mark Brown wrote:
>> On Mon, Jan 11, 2010 at 12:27:15PM +0000, Ben Dooks wrote:
>> 
>>> Having this as a user settable field might be useful if plugging on
>>> GPIO expanders at runtime.
>> 
>> If that gets to be anything other than an extremely niche use case the
>> GPIO allocation would need to have a dynamic limit anyway, though.
>
> Yes, however a kconfig case where you can set the minimum value of an
> integer would make the whole extra-gpio configuration much cleaner and
> avoid having toadd further configuration symbols when someone wants an
> extra 256 or whatever GPIOS.
>
> Having a dynamic GPIO range would also be nice, someone should look at
> adding it to the GPIO code.

I would also like to see a dynamic GPIO range but it looks like it will
create a lot of overhead for all the gpiolib calls.

The only way I can see to make it dynamic is by putting gpio_desc (one
for each gpio) into a list and adding the gpio number to struct gpio_desc:

struct gpio_desc {
	struct gpio_chip	*chip;
+	unsigned		nr;
	unsigned long	flags;
...
- static struct gpio_desc gpio_desc[MAX_NR_GPIOS];
+ struct gpio_dev {
+	struct list_head	list;
+	struct gpio_desc	*gpio_desc;
+ };
+
+ static LIST_HEAD(gpio_devices);

Then changing the inline gpio_to_chip so that it works thru the list
in order to find the proper gpio_desc for the gpio in order to return
the chip.

-/* caller holds gpio_lock *OR* gpio is marked as requested */
-static inline struct gpio_chip *gpio_to_chip(unsigned gpio)
-{
-	return gpio_desc[gpio].chip;
-}
+/* is the locking needed for the list? */
+static struct gpio_chip *gpio_to_chip(unsigned gpio)
+{
+	struct gpio_chip *chip;
+	unsigned long flags;
+
+	spin_lock_irqsave(&gpio_lock, flags);
+	list_for_each_entry(gpio_dev, &gpio_devices, list) {
+		if (gpio_dev->gpio_desc->nr == gpio) {
+			chip = gpio_dev->gpio_desc->chip;
+			goto found;
+		}
+	}
+	chip = NULL;
+found:
+	spin_unlock(&gpio_lock);
+	return chip;
+}

Plus, a similar function will be needed to get gpio_desc for
everything in gpiolib that currently uses gpio_desc[].  I'm sure
there are a lot of other issues but I'm just trying to work out
a way to make the GPIO range dynamic.

An alternative would be to just put each gpio chip into a list.
Each gpio chip would then contain another list of the individual
gpio's.

Any other ideas?

Regards,
Hartley
