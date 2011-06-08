From: robherring2@gmail.com (Rob Herring)
Date: Tue, 07 Jun 2011 22:12:47 -0500
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform
	bus scan
In-Reply-To: <201106012329.20651.arnd@arndb.de>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<4DE66E39.2070300@gmail.com>
	<BANLkTimTdVKspjJ8GD4M90wiKCC0SzkgpA@mail.gmail.com>
	<201106012329.20651.arnd@arndb.de>
Message-ID: <4DEEE8AF.50603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2011 04:29 PM, Arnd Bergmann wrote:
> On Wednesday 01 June 2011, Grant Likely wrote:
>>>
>>> Shouldn't the hierarchy in linux reflect the h/w? It seems a bit pointless
>>> to me to create a device just to create another device. amba_bus is already
>>> a bit strange in that it is not really a bus type, but a certain class of
>>> peripherals.
>>>
>>> I'd like to hear Grant's thoughts on this.
>>
>> AMBA and platform_devices are "special" in that they don't have
>> requirements on their parent device.  I see absolutely zero issue with
>> having platform_device and amba_device as siblings.
>
> Hmm, if we accept that platform and AMBA devices are just different from
> all the others, maybe we can do a simpler solution and just hardcode that
> difference in the of_platform_bus_create function. It probably doesn't
> hurt if we grow a handful of these at most, as long as we wouldn't add
> code for a lot of different bus types to the common probing function.
>
> 	Arnd

The simplest solutions are usually the best. With that, the 2nd patch 
becomes:

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 9b785be..6955932 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -21,6 +21,7 @@
  #include <linux/of_irq.h>
  #include <linux/of_platform.h>
  #include <linux/platform_device.h>
+#include <linux/amba/bus.h>

  static int of_dev_node_match(struct device *dev, void *data)
  {
@@ -234,6 +235,11 @@ static int of_platform_bus_create(struct 
device_node *bus,
                 return 0;
         }

+       if (of_device_is_compatible(bus, "arm,amba-device")) {
+               of_amba_device_create(bus, parent);
+               return 0;
+       }
+
         dev = of_platform_device_create(bus, NULL, parent);
         if (!dev || !of_match_node(matches, bus))
                 return 0;
