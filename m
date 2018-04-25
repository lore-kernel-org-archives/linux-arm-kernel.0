From: peda@axentia.se (Peter Rosin)
Date: Wed, 25 Apr 2018 11:09:25 +0200
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180424170625.GL16141@n2100.armlinux.org.uk>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
Message-ID: <bc00b6ca-38bd-bced-b86f-cbb49e5b0960@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-24 19:06, Russell King - ARM Linux wrote:
> On Tue, Apr 24, 2018 at 07:04:16PM +0300, Jyri Sarha wrote:
>> On 24/04/18 13:14, Peter Rosin wrote:
>>> On 2018-04-24 10:08, Russell King - ARM Linux wrote:
>>>> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
>>>>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
>>>>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>>>>>>  static int tda998x_remove(struct i2c_client *client)
>>>>>>>  {
>>>>>>> -	component_del(&client->dev, &tda998x_ops);
>>>>>>> +	struct device *dev = &client->dev;
>>>>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>>>>>>> +
>>>>>>> +	drm_bridge_remove(&bridge->bridge);
>>>>>>> +	component_del(dev, &tda998x_ops);
>>>>>>> +
>>>>>>
>>>>>> I'd like to ask a rather fundamental question about DRM bridge support,
>>>>>> because I suspect that there's a major fsckup here.
>>>>>>
>>>>>> The above is the function that deals with the TDA998x device being
>>>>>> unbound from the driver.  With the component API, this results in the
>>>>>> DRM device correctly being torn down, because one of the hardware
>>>>>> devices has gone.
>>>>>>
>>>>>> With DRM bridge, the bridge is merely removed from the list of
>>>>>> bridges:
>>>>>>
>>>>>> void drm_bridge_remove(struct drm_bridge *bridge)
>>>>>> {
>>>>>>         mutex_lock(&bridge_lock);
>>>>>>         list_del_init(&bridge->list);
>>>>>>         mutex_unlock(&bridge_lock);
>>>>>> }
>>>>>> EXPORT_SYMBOL(drm_bridge_remove);
>>>>>>
>>>>>> and the memory backing the "struct tda998x_bridge" (which contains
>>>>>> the struct drm_bridge) will be freed by the devm subsystem.
>>>>>>
>>>>>> However, there is no notification into the rest of the DRM subsystem
>>>>>> that the device has gone away.  Worse, the memory that is still in
>>>>>> use by DRM has now been freed, so further use of the DRM device
>>>>>> results in a use-after-free bug.
>>>>>>
>>>>>> This is really not good, and to me looks like a fundamental problem
>>>>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
>>>>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
>>>>>> the actual device itself.
>>>>>>
>>>>>> So, from what I can see, there seems to be a fundamental lifetime
>>>>>> issue with the design of the DRM bridge code.  This needs to be
>>>>>> fixed.
>>>>>
>>>>> Oh crap. A gigantic can of worms...
>>>>
>>>> Yes, it's especially annoying for me, having put the effort in to
>>>> the component helper to cover all these cases.
>>>>
>>>>> Would a patch (completely untested btw) along this line of thinking make
>>>>> any difference whatsoever?
>>>>
>>>> It looks interesting - from what I can see of the device links code,
>>>> it would have the effect of unbinding the DRM device just before
>>>> TDA998x is unbound, so that's an improvement.
>>>>
>>>> However, from what I can see, the link vanishes at that point (as
>>>> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
>>>> in nothing further happening - the link will be recreated, but there
>>>> appears to be nothing that triggers the "consumer" to rebind at that
>>>> point.  Maybe I've missed something?
>>>
>>> Right, auto-remove is a no-go. So, improving on the previous...
>>>
>>> (I think drm_panel might suffer from this issue too?)
>>
>> Yes it does and I took a shot at trying to fix it at the end of the
>> previous merge window, but gave up as I run out of time. I re-spun the
>> work now after reading this thread. I add you and Russell to cc.
> 
> Right, and these exact problems are what the component helper is
> there to sort out, in a subsystem independent way.
> 
> What is the problem with the component helper that people seem to
> be soo loathed to use it, instead preferring to come up with sub-
> standard and broken alternatives?

I think the answer to that is rather obvious. If you design with these
components from the get-go, I see no problem with them, but it simply
seems way easier to retrofit device-links. Just take a look at my
untested patch and patch v3 2/2 from Jyri [1] for panels (that presumably
fix the big issue, namely leaving wild pointers). They either don't touch
neither suppliers nor consumers or are totally trivial (assigning a new
.owner field in suppliers). Compare that with adding a couple of dozen
boilerplate lines with hook functions etc to each and every drm_device,
drm_panel and drm_bridge.

Couple that with the fact that apparently the problem of unbinding
and leaving wild pointers hasn't been all that prevalent, implying that
the problem of rebinding can't be all that critical either.

But what do I know?

Cheers,
Peter

[1] I can't seem to find it in archives, so I'm including it here for
reference. It's small enough.

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 29d2c74..7474045 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 
+#include <drm/drm_device.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_panel.h>
 
@@ -101,6 +102,13 @@ int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
 	if (panel->connector)
 		return -EBUSY;
 
+	panel->link = device_link_add(connector->dev->dev, panel->dev, 0);
+	if (!panel->link) {
+		dev_err(panel->dev, "failed to link panel to %s\n",
+			dev_name(connector->dev->dev));
+		return -EINVAL;
+	}
+
 	panel->connector = connector;
 	panel->drm = connector->dev;
 
@@ -123,6 +131,8 @@ EXPORT_SYMBOL(drm_panel_attach);
  */
 int drm_panel_detach(struct drm_panel *panel)
 {
+	device_link_del(panel->link);
+
 	panel->connector = NULL;
 	panel->drm = NULL;
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 14ac240..26a1b5f 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -89,6 +89,7 @@ struct drm_panel {
 	struct drm_device *drm;
 	struct drm_connector *connector;
 	struct device *dev;
+	struct device_link *link;
 
 	const struct drm_panel_funcs *funcs;
 
