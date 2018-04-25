From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 25 Apr 2018 23:01:15 +0300
Subject: [PATCH v4 7/8] drm/i2c: tda998x: register as a drm bridge
In-Reply-To: <20180424232523.GN16141@n2100.armlinux.org.uk>
References: <20180423072301.11962-1-peda@axentia.se>
 <20180423072301.11962-8-peda@axentia.se>
 <20180423160833.GF16141@n2100.armlinux.org.uk>
 <5d6866d0-75bc-4de8-9b87-4fee5430e9dd@axentia.se>
 <20180424080833.GJ16141@n2100.armlinux.org.uk>
 <8448e90a-4562-b564-c160-1b5c67e0f92f@axentia.se>
 <0cbee3bd-8987-5f2f-519d-f8d1b426f2a3@ti.com>
 <20180424170625.GL16141@n2100.armlinux.org.uk>
 <b7a7ffb6-b282-cbc5-435e-9ca1cd405e33@ti.com>
 <20180424232523.GN16141@n2100.armlinux.org.uk>
Message-ID: <7e8cdcf6-c816-1e01-24f1-a526fb0a591f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/18 02:25, Russell King - ARM Linux wrote:
> On Tue, Apr 24, 2018 at 09:25:44PM +0300, Jyri Sarha wrote:
>> On 24/04/18 20:06, Russell King - ARM Linux wrote:
>>> On Tue, Apr 24, 2018 at 07:04:16PM +0300, Jyri Sarha wrote:
>>>> On 24/04/18 13:14, Peter Rosin wrote:
>>>>> On 2018-04-24 10:08, Russell King - ARM Linux wrote:
>>>>>> On Tue, Apr 24, 2018 at 08:58:42AM +0200, Peter Rosin wrote:
>>>>>>> On 2018-04-23 18:08, Russell King - ARM Linux wrote:
>>>>>>>> On Mon, Apr 23, 2018 at 09:23:00AM +0200, Peter Rosin wrote:
>>>>>>>>>  static int tda998x_remove(struct i2c_client *client)
>>>>>>>>>  {
>>>>>>>>> -	component_del(&client->dev, &tda998x_ops);
>>>>>>>>> +	struct device *dev = &client->dev;
>>>>>>>>> +	struct tda998x_bridge *bridge = dev_get_drvdata(dev);
>>>>>>>>> +
>>>>>>>>> +	drm_bridge_remove(&bridge->bridge);
>>>>>>>>> +	component_del(dev, &tda998x_ops);
>>>>>>>>> +
>>>>>>>>
>>>>>>>> I'd like to ask a rather fundamental question about DRM bridge support,
>>>>>>>> because I suspect that there's a major fsckup here.
>>>>>>>>
>>>>>>>> The above is the function that deals with the TDA998x device being
>>>>>>>> unbound from the driver.  With the component API, this results in the
>>>>>>>> DRM device correctly being torn down, because one of the hardware
>>>>>>>> devices has gone.
>>>>>>>>
>>>>>>>> With DRM bridge, the bridge is merely removed from the list of
>>>>>>>> bridges:
>>>>>>>>
>>>>>>>> void drm_bridge_remove(struct drm_bridge *bridge)
>>>>>>>> {
>>>>>>>>         mutex_lock(&bridge_lock);
>>>>>>>>         list_del_init(&bridge->list);
>>>>>>>>         mutex_unlock(&bridge_lock);
>>>>>>>> }
>>>>>>>> EXPORT_SYMBOL(drm_bridge_remove);
>>>>>>>>
>>>>>>>> and the memory backing the "struct tda998x_bridge" (which contains
>>>>>>>> the struct drm_bridge) will be freed by the devm subsystem.
>>>>>>>>
>>>>>>>> However, there is no notification into the rest of the DRM subsystem
>>>>>>>> that the device has gone away.  Worse, the memory that is still in
>>>>>>>> use by DRM has now been freed, so further use of the DRM device
>>>>>>>> results in a use-after-free bug.
>>>>>>>>
>>>>>>>> This is really not good, and to me looks like a fundamental problem
>>>>>>>> with the DRM bridge code.  I see nothing in the DRM bridge code that
>>>>>>>> deals with the lifetime of a "DRM bridge" or indeed the lifetime of
>>>>>>>> the actual device itself.
>>>>>>>>
>>>>>>>> So, from what I can see, there seems to be a fundamental lifetime
>>>>>>>> issue with the design of the DRM bridge code.  This needs to be
>>>>>>>> fixed.
>>>>>>>
>>>>>>> Oh crap. A gigantic can of worms...
>>>>>>
>>>>>> Yes, it's especially annoying for me, having put the effort in to
>>>>>> the component helper to cover all these cases.
>>>>>>
>>>>>>> Would a patch (completely untested btw) along this line of thinking make
>>>>>>> any difference whatsoever?
>>>>>>
>>>>>> It looks interesting - from what I can see of the device links code,
>>>>>> it would have the effect of unbinding the DRM device just before
>>>>>> TDA998x is unbound, so that's an improvement.
>>>>>>
>>>>>> However, from what I can see, the link vanishes at that point (as
>>>>>> DL_FLAG_AUTOREMOVE is set), and re-binding the TDA998x device results
>>>>>> in nothing further happening - the link will be recreated, but there
>>>>>> appears to be nothing that triggers the "consumer" to rebind at that
>>>>>> point.  Maybe I've missed something?
>>>>>
>>>>> Right, auto-remove is a no-go. So, improving on the previous...
>>>>>
>>>>> (I think drm_panel might suffer from this issue too?)
>>>>
>>>> Yes it does and I took a shot at trying to fix it at the end of the
>>>> previous merge window, but gave up as I run out of time. I re-spun the
>>>> work now after reading this thread. I add you and Russell to cc.
>>>
>>> Right, and these exact problems are what the component helper is
>>> there to sort out, in a subsystem independent way.
>>>
>>> What is the problem with the component helper that people seem to
>>> be soo loathed to use it, instead preferring to come up with sub-
>>> standard and broken alternatives?
>>>
>>
>> Nothing but time. Embedding component helpers seamlessly into drm
>> framework does not sound like a couple of days job. Right now I simply
>> do not have time to take on a challenge like that. If someone does it I
>> am all for it.
>>
>> However, I would not call device links substandard. They are in the
>> device core after all.
> 
> Umm, no, I was not talking about the device links, but the tendency to
> have subsystem or component specific solutions to this problem.
> 

Oh yes. But in this case the substandard solution is already there and
it is already widely used, despite it being severely broken. I am merely
trying to fix the existing substandard solution.

I admit that a full integration with component helpers would probably be
more elegant solution to the problem, but the amount of work is just too
much. The change would impact the way all the master drm drivers pull
them selves together. The drivers that already use the component helpers
for some internal stuff will add their own challenge. Separate component
matching implementations are needed for device-tree and ACPI (are ther
more flavors?) etc. I just do not see this happening any time soon (am
happy to be wrong about this).

> We're now heading down the path of trying to retrofit the functionality
> that one expects and is provided by the component helpers into DRM
> bridge and DRM panel by using device links, which appears to only
> partially resolve the problem.
> 
> On the point of device links, I've been wondering whether the component
> helpers could take advantage of the device links, but at the moment
> that would cause a regression if there's no facility to re-probe the
> "consumer" when a "supplier" returns.
> 

I sent a patch[1] in February that solves the re-probing problem at
least in my environment.

> As you bring that up, I would say that they _are_ a substandard way to
> solve this problem _if_, as I suspect, they would cause a regression
> to the component helper if the component helper were to use them as a
> means to control the probing of the "master" device.  This is not a
> matter of which part of the kernel they are "in", but the functionality
> that they can offer vs what would be expected.
> 

The component helpers certainly have many features in that are not
(yet?) in device core's device links, but the amount of work needed to
fix the most pressing problem of attached drm panels or bridges is
couple of magnitudes less with device links when compared to full blown
component helper usage.

Best regards,
Jyri

[1]
https://lists.freedesktop.org/archives/dri-devel/2018-February/166907.html

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
