From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Nov 2014 13:09:22 -0600
Subject: [PATCH 06/10] input: touchscreen: edt-ft5x06: fix driver
 autoprobing
In-Reply-To: <20141118183847.GE3003@dtor-ws>
References: <1416334028-7766-1-git-send-email-balbi@ti.com>
 <1416334028-7766-6-git-send-email-balbi@ti.com>
 <20141118183847.GE3003@dtor-ws>
Message-ID: <20141118190922.GL6179@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 18, 2014 at 10:38:47AM -0800, Dmitry Torokhov wrote:
> Hi Felipe,
> 
> On Tue, Nov 18, 2014 at 12:07:04PM -0600, Felipe Balbi wrote:
> > i2c devices match against struct i2c_device_id
> > even for CONFIG_OF case, so adding a struct of_device_id
> > doesn't change anything. As a result, currently, edt-ft5x06
> > will not autoprobe if built as a module.
> 
> Why doe snot it autoprobe? We properly declare MODULE_DEVICE_TABLE for
> OF, is it because we are missing some data in device uevent?

because of of_i2c_register_devices(). Maybe Wolfram can give a better
explanation here, but it just doesn't match through of_device_id.

Apply this:

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 2f90ac6..f0dc16e 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -449,8 +449,10 @@ static const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 						const struct i2c_client *client)
 {
 	while (id->name[0]) {
-		if (strcmp(client->name, id->name) == 0)
+		if (strcmp(client->name, id->name) == 0) {
+			dev_info(&client->dev, "i2c_device_id match\n");
 			return id;
+		}
 		id++;
 	}
 	return NULL;
@@ -465,8 +467,10 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 		return 0;
 
 	/* Attempt an OF style match */
-	if (of_driver_match_device(dev, drv))
+	if (of_driver_match_device(dev, drv)) {
+		dev_info(dev, "of driver match\n");
 		return 1;
+	}
 
 	/* Then ACPI style match */
 	if (acpi_driver_match_device(dev, drv))
@@ -1081,6 +1085,7 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
 	client->dev.bus = &i2c_bus_type;
 	client->dev.type = &i2c_client_type;
 	client->dev.of_node = info->of_node;
+	dev_info(&adap->dev, "%s: of_node %p\n", __func__, info->of_node);
 	ACPI_COMPANION_SET(&client->dev, info->acpi_node.companion);
 
 	i2c_dev_set_name(adap, client);
@@ -1411,6 +1416,7 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
 
 		info.irq = irq_of_parse_and_map(node, 0);
 		info.of_node = of_node_get(node);
+		dev_info(&adap->dev, "%s: of_node %p\n", __func__, info.of_node);
 		info.archdata = &dev_ad;
 
 		if (of_get_property(node, "wakeup-source", NULL))

then boot the board and you get http://hastebin.com/oqemezajez

Interesting, it's matching against of but only when I modprobe.

Let me debug this one a little more.

> > To fix the issue and still maintain backwards compatibility
> > with all DTS files currently in tree, we're just moving
> > all ids from of_device_id to i2c_device_id while also
> > adding the following specific ids which should be used
> > from now on:
> > 
> > 	{ "edt-ft5206", 0, }
> > 	{ "edt-ft5306", 0, }
> > 	{ "edt-ft5406", 0, }
> 
> Is this a tee-wide change? Link to the discussion?

nope, just found it with my AM437x Starter Kit.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/743c97ad/attachment.sig>
