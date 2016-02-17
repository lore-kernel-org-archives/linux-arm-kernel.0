From: joshc@ni.com (Josh Cartwright)
Date: Wed, 17 Feb 2016 13:55:43 -0600
Subject: Bunch of machines are not booting in next again, GPIO regression?
In-Reply-To: <20160217192755.GC21202@atomide.com>
References: <20160217192755.GC21202@atomide.com>
Message-ID: <20160217195543.GA871@jcartwri.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 11:27:55AM -0800, Tony Lindgren wrote:
> Hi Linus,
> 
> Looks like ff2b13592299 ("gpio: make the gpiochip a real device")
> broke booting on all omaps, and probably other machines too according
> to this:
> 
> https://kernelci.org/boot/all/job/next/kernel/next-20160217/
> 
> So far we've gone from 1 failed machine with next-20160216 to
> 18 failed machines with next-20160217.
> 
> The error I'm getting on omaps is below with debug_ll enable,
> any ideas?

Hey Tony-

Looks like the newly allocated gpio_device object isn't zeroed,
confusing dev_set_name.  Can you give this a try?

  Josh

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d8511cd..59f0045 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -435,7 +435,7 @@ int gpiochip_add_data(struct gpio_chip *chip, void *data)
 	 * First: allocate and populate the internal stat container, and
 	 * set up the struct device.
 	 */
-	gdev = kmalloc(sizeof(*gdev), GFP_KERNEL);
+	gdev = kzalloc(sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
 		return -ENOMEM;
 	gdev->dev.bus = &gpio_bus_type;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160217/a380e06e/attachment.sig>
