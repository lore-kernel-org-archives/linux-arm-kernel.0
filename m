From: peda@axentia.se (Peter Rosin)
Date: Tue, 24 Apr 2018 08:58:42 +0200
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180423160833.GF16141@n2100.armlinux.org.uk>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
Message-ID: <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-23 18:08, Russell King - ARM Linux wrote:
> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>  static int tda998x_remove(struct i2c_client *client)
>>  {
>> -	component_del(&client->dev, &tda998x_ops);
>> +	struct device *dev = &client->dev;
>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>> +
>> +	drm_bridge_remove(&bridge->bridge);
>> +	component_del(dev, &tda998x_ops);
>> +
> 
> I'd like to ask a rather fundamental question about DRM bridge support,
> because I suspect that there's a major fsckup here.
> 
> The above is the function that deals with the TDA998x device being
> unbound from the driver.  With the component API, this results in the
> DRM device correctly being torn down, because one of the hardware
> devices has gone.
> 
> With DRM bridge, the bridge is merely removed from the list of
> bridges:
> 
> void drm_bridge_remove(struct drm_bridge *bridge)
> {
>         mutex_lock(&bridge_lock);
>         list_del_init(&bridge->list);
>         mutex_unlock(&bridge_lock);
> }
> EXPORT_SYMBOL(drm_bridge_remove);
> 
> and the memory backing the "struct tda998x_bridge" (which contains
> the struct drm_bridge) will be freed by the devm subsystem.
> 
> However, there is no notification into the rest of the DRM subsystem
> that the device has gone away.  Worse, the memory that is still in
> use by DRM has now been freed, so further use of the DRM device
> results in a use-after-free bug.
> 
> This is really not good, and to me looks like a fundamental problem
> with the DRM bridge code.  I see nothing in the DRM bridge code that
> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
> the actual device itself.
> 
> So, from what I can see, there seems to be a fundamental lifetime
> issue with the design of the DRM bridge code.  This needs to be
> fixed.

Oh crap. A gigantic can of worms...

Would a patch (completely untested btw) along this line of thinking make
any difference whatsoever?

Yeah, I know, all other drm_bridges also need to fill in .owner, and
the .of_node member could probably be ditched from struct drm_device
etc, but this was just a quick sketch...

Cheers,
Peter

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 1638bfe9627c..3577e50cc6c0 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -138,6 +138,10 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	else
 		encoder->bridge = bridge;
 
+	if (!device_link_add(encoder->dev->dev, bridge->owner,
+			     DL_FLAG_AUTOREMOVE))
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_bridge_attach);
diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index b8cb6237a38b..29eba4e9a39d 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -1857,6 +1857,7 @@ tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	bridge->dev = dev;
 	dev_set_drvdata(dev, bridge);
 
+	bridge->bridge.owner = dev;
 	bridge->bridge.funcs = &tda998x_bridge_funcs;
 #ifdef CONFIG_OF
 	bridge->bridge.of_node = dev->of_node;
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 682d01ba920c..f0f8b2a85c28 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -224,6 +224,7 @@ struct drm_bridge_funcs {
 
 /**
  * struct drm_bridge - central DRM bridge control structure
+ * @owner: device that owns the bridge
  * @dev: DRM device this bridge belongs to
  * @encoder: encoder to which this bridge is connected
  * @next: the next bridge in the encoder chain
@@ -233,6 +234,7 @@ struct drm_bridge_funcs {
  * @driver_private: pointer to the bridge driver's internal context
  */
 struct drm_bridge {
+	struct device *owner;
 	struct drm_device *dev;
 	struct drm_encoder *encoder;
 	struct drm_bridge *next;
