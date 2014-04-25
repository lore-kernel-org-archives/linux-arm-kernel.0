From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 25 Apr 2014 16:36:01 +0200
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for components
 tracking
In-Reply-To: <20140423171351.GH24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk> <5351145D.8070207@samsung.com>
 <20140418124652.GE24070@n2100.arm.linux.org.uk> <535652B2.7000607@samsung.com>
 <20140422115145.GU24070@n2100.arm.linux.org.uk> <5357D68E.8060605@samsung.com>
 <20140423164328.GG24070@n2100.arm.linux.org.uk>
 <20140423171351.GH24070@n2100.arm.linux.org.uk>
Message-ID: <535A72D1.1060207@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 07:13 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 23, 2014 at 05:43:28PM +0100, Russell King - ARM Linux wrote:
>> So, maybe you would like to finally address *my* point about TDA998x
>> and your solution in a way that provides a satisfactory answer.  *Show*
>> how it can be done, or *outline* how it can be done.
> 
> Let me be absolutely clear *why* I'm very interested in this - and that
> is because I'm presently converting TDA998x and Armada DRM to use the
> component helpers.  If your solution is better, then I'd want to convert
> to that instead, and let's retire the component helpers.
> 
> At the moment, my belief is that your solution is *very* substandard and
> suboptimal precisely for the reasons I've outlined, especially when it
> comes to sharing a component between several drivers.
> 
> So, if you *really* care, you'll stop fobbing me off on this point and
> provide some real technical input how you'd see your solution being used
> in exactly the scenario that I've been outlining several times in this
> thread.
> 
> For example, you could show what kind of modifications you expect would
> be required to the _existing_ TDA998x driver to allow it to participate
> as a device declared in DT as an entirely separate entity, probed via the
> standard I2C probing methods, and then hook itself into the appropriate
> DRM driver.  Remembering, of course, that the TDA998x device is used by
> more than _just_ Armada DRM.
> 
> I don't care if you show it via pseudo-code or by real patch.  I just
> want to know _how_ your solution could be used.  And I won't want some
> silly remark like "trivially" or "I've already answered that."  I want
> _you_ to _show_ _how_ it can be done.
> 

Thats good, constructive discussion is better.

I have no experience with tda998x, armada and drm_encoder_slave, so
please be kind if I make some mistakes regarding them.
I will try to show the complete solution starting from the current state
of tda998x and armada in linux-next. I will present solution for DT as
it is more standardized than board files. I hope it should not be a
problem to port it back to board files if necessary.

First I will try to show how to get rid of ifdefs in armada_drv.c, it is
not a part of my proposition but you have emphasized it.

1. tda998x have already minimal DT support, so we can create proper i2c
client device node with "nxp,tda998x" compatible.

2. There are tda998x_encoder_params defined in armada_drv.c they should
be removed from armada and added to tda998x node, its parsing to tda
driver should be added as well.

3. In armada_drv.c there is armada_drm_slave_config specific for tda. I
am not sure of all its content but it seems it could be mapped to DT
video interface.
So if in armada_drm node there will be port node it means there
is something connected to the output and it uses drm_encoder_slave
interface, if there is no port node there is no encoder.
Sample bindings:

armada_drm {
	...
	port {
		drm_ep: endpoint {
			remote-endpoint = <&tda_ep>;
			crtcs = <1>;
			poll_connect;
			poll_disconnect;
			interlace_allowed;
		};
	};
};

...

i2c_x {
	tda at 70 {
		reg = <0x70>;
		compatible = "nxp,tda998x";
		swap_a = ...;
		swap_b = ...;
		...
		port {
			endpoint {
				remote-endpoint = <&drm_ep>;
			};
		};
	};
};

4. In armada_drm call of drm_i2c_encoder_init should be replaced
by sth like:
	client = of_find_i2c_device_by_node(dev node containing drm_ep phandle);
	device_lock(&client->dev);
	if (!client->dev.driver) {
		ret = -EPROBE_DEFER;
		goto unlock;
	}
	module_get(client->dev.driver->owner);
	encoder_drv = to_drm_i2c_encoder_driver(to_i2c_driver(client->dev.driver));
	encoder_drv->encoder_init(client, dev, encoder);
unlock:
	device_unlock(&client->dev);

Similar change should be done to destroy code.
Of course please consider this code as a draft.
	
All the above is just for removing ifdefs from armada_drv.c, it
is not really connected with my proposition.

It is not really safe, and I am not sure where exactly the locking
should be performed. For sure it can crash when unbind will be called
via sysfs property, but it seems at least as safe as
drm_i2c_encoder_init or it should be possible to make it such.
And it allows to attach to armada theoretically any hardware compatible
encoder having drm_i2c_encoder interface.

What do you think about above steps? Is it OK for you?

And now about my proposition for device probe order issue. My first
answer to your objections about 'glue problem' was to make global list
of 'ready' devices instead of the one glued to the main drm driver.
Over time my idea evolved.
My proposition is still in the form of adding one call to component
probe for reporting device readiness and one symmetrical call to remove.

It seems I can simply reuse notification framework which I am working
on. I will send RFC next week and I will accompany it with its usage for
solving drmdev problem.


Regards
Andrzej
