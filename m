From: robherring2@gmail.com (Rob Herring)
Date: Thu, 26 May 2011 13:43:22 -0500
Subject: [RFC PATCH v3 2/2] dt: add custom device creation to platform
	bus scan
In-Reply-To: <201105261511.23659.arnd@arndb.de>
References: <1306359073-16274-1-git-send-email-robherring2@gmail.com>
	<1306359073-16274-3-git-send-email-robherring2@gmail.com>
	<201105261511.23659.arnd@arndb.de>
Message-ID: <4DDE9F4A.5050507@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 05/26/2011 08:11 AM, Arnd Bergmann wrote:
> On Wednesday 25 May 2011, Rob Herring wrote:
>>
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> Add support to the platform bus scanning to call custom device creation
>> functions. This enables creation of non-platform devices like amba_bus.
>>
>> Cc: Jeremy Kerr<jeremy.kerr@canonical.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: linux at arm.linux.org.uk
>> Cc: arnd at arndb.de
>> Cc: Linus Walleij<linus.walleij@linaro.org>
>> Signed-off-by: Rob Herring<rob.herring@calxeda.com>
>
> This creates a confusing mix of match table entries: Normally,
> all entries in the match table are meant to identify child buses,
> but if I read your patch correctly, you now also need to match
> on the amba devices themselves, including the creation of
> platform devices for each child device node under an amba
> device.
>
We should only create devices for each matching bus and the immediate 
children of each bus. A child device of an amba device would be 
something like an i2c bus which we don't want to create devices for. Or 
am I missing something?

> I don't think that was the intention. Maybe we need to pass
> two match tables into of_platform_bus_probe() instead:
> one to identify the buses, and another one that is used
> to create the actual devices.
>
That was my original thinking too, but some reason I had concluded 1 
could get by with just 1 table. After more thought, I think you are 
right. In fact, I broke platform device creation with this patch. I need 
to be able to tell if no match means create a platform device (child of 
bus) or not (child of a device).

Here's an updated version with just the interesting hunk. I've tested it 
with a made up bus structure that looks something like this:

soc bus
  -plat dev
  -amba dev
  -sub-bus
    -plat dev
    -amba dev
  -plat dev

As of_platform_bus_probe is not recommended to be used by Grant, I only 
plan to add 2 match tables to of_platform_bus_populate.

@@ -234,18 +237,32 @@ static int of_platform_bus_create(struct 
device_node *bus,
  		return 0;
  	}

-	dev = of_platform_device_create(bus, NULL, parent);
-	if (!dev || !of_match_node(matches, bus))
-		return 0;
-
-	for_each_child_of_node(bus, child) {
-		pr_debug("   create child: %s\n", child->full_name);
-		rc = of_platform_bus_create(child, matches, &dev->dev, strict);
-		if (rc) {
-			of_node_put(child);
-			break;
+	id = of_match_node(bus_matches, bus);
+	if (id) {
+		dev = of_platform_device_create(bus, NULL, parent);
+		if (!dev)
+			return 0;
+		for_each_child_of_node(bus, child) {
+			pr_debug("   create child: %s\n", child->full_name);
+			rc = of_platform_bus_create(child, bus_matches,
+						    dev_matches, dev, strict);
+			if (rc) {
+				of_node_put(child);
+				break;
+			}
  		}
+		return rc;
  	}
+
+	id = of_match_node(dev_matches, bus);
+	mdata = id ? id->data : NULL;
+	if (id && mdata && mdata->dev_create)
+		dev = mdata->dev_create(bus, parent);
+	else
+		dev = of_platform_device_create(bus, NULL, parent);
+	if (!dev)
+		return 0;
+
  	return rc;
  }


Rob
