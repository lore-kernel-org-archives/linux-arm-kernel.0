From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 28 Feb 2014 09:36:18 +0200
Subject: [RFC PATCH v4 3/8] staging: imx-drm: Document updated imx-drm
 device tree bindings
In-Reply-To: <1393520088.4507.92.camel@paszta.hi.pengutronix.de>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>	
 <1393338203-25051-4-git-send-email-p.zabel@pengutronix.de>	
 <530F1C4C.2010504@ti.com>	
 <1393506385.4507.49.camel@paszta.hi.pengutronix.de>	
 <20140227130020.GJ21483@n2100.arm.linux.org.uk> <530F43B9.800@ti.com>
 <1393520088.4507.92.camel@paszta.hi.pengutronix.de>
Message-ID: <53103C72.5030509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/14 18:54, Philipp Zabel wrote:

>> - One IPU enabled, one disabled: nothing special here, just set the
>> other IPU to status="disabled" in the DT data. The driver for the
>> enabled IPU would register the required DRM entities.
> 
> that should work. Let the enabled IPU create the imx-drm platform device
> on probe, parse the device tree and ignore everything only hanging off
> of the disabled IPU.

I think you misunderstood me a bit.

What I meant is that there's no need for imx-drm device at all, neither
in the DT data or in the kernel side.

There'd just be the DT nodes for the IPUs, which would cause the IPU
platform devices to be created, and a driver for the IPU. So just like
for any other normal platform device.

In the simplest cases, where only one IPU is enabled, or the IPUs want
to be considered as totally independent, there'd be nothing special. The
IPU driver would just register the drm entities.

> [Reordering a bit...]
>> - Two IPUs in combined mode:
>>
>> Pick one IPU as the master, and one as slave. Link the IPU nodes in DT
>> data with phandles, say: master=<&ipu1> on the slave IPU and
>> slave=<&ipu0> on the master.
>>
>> The master one will register the DRM entities, and the slave one will
>> just do what the master says.
> 
> That might work, too. Just let the each IPU scan the graph and try to
> find the imx-drm master before creating the imx-drm platform device.
> The first IPU fill find no preexisting master and create the imx-drm
> platform device as above, adding the other IPU as well as the other
> components with component_master_add_child. It just has to make sure
> that the other IPU is added to the list before the encoders are.
> 
> The second IPU will scan the graph, find a preexisting master for the
> other IPU node, register its component and just wait to be bound by the
> master.

Here the slave IPU doesn't need to scan the graph at all. It just needs
to make itself available somehow to the master. Maybe just by exported
functions, or registering itself somewhere.

Only the master IPU will scan the graph, and as all the entities are
connected to the same graph, including the slave IPU, the master can
find all the relevant nodes.

>> - Two IPUs as separate units: almost the same as above, but both would
>> independently register the DRM entities.
> 
> Here the second IPU would not be connected to the first IPU via the
> graph - it would not find a preexisting imx-drm device when scanning its
> graph and create its own imx-drm device just like the first IPU did.
> As a result there are two completely separate DRM devices.

I understood that that would be the idea, two separate, independent DRM
devices. Like two graphics cards on a PC.

> That being said, this change could be made at any time in the future,
> in a backwards compatible fashion, by just declaring the imx-drm node
> optional and ignoring it if it exists.

Yes, I agree.

And I don't even know if the master-slave method I described is valid,
although I don't see why it would not work. The master
"display-subsystem" DT node does make sense to me in cases like this,
where the IPUs need to be driven as a single unit.

> Did anybody propose such a generic term? How about:
> 
> -imx-drm {
> -	compatible = "fsl,imx-drm";
> -	ports = <&ipu1_di0>, <&ipu1_di1>;
> -};
> +display-subsystem {
> +	compatible = "fsl,imx-display-subsystem";
> +	ports = <&ipu1_di0>, <&ipu1_di1>;
> +};

That sounds fine to me.

I wonder how it works if, say, there are 4 IPUs, and you want to run
them in two pairs. In that case you need two of those display-subsystem
nodes. But I guess it's just a matter of assigning a number for them
with 'regs' property, and making sure the driver has nothing that
prevents multiple instances of it.

>>> If this wasn't the case, we wouldn't even attempt to describe what devices
>>> we have on which I2C buses - we'd just list the hardware on the board
>>> without giving any information about how it's wired together.
>>>
>>> This is no different - however, it doesn't have (and shouldn't) be
>>> subsystem specific... but - and this is the challenge we then face - how
>>> do you decide that on one board with a single zImage kernel, with both
>>> DRM and fbdev built-in, whether to use the DRM interfaces or the fbdev
>>> interfaces?  We could have both matching the same compatible string, but
>>> we'd also need some way to tell each other that they're not allowed to
>>> bind.
>>
>> Yes, that's an annoying problem, we have that on OMAP. It's a clear sign
>> that our video support is rather messed up.
>>
>> My opinion is that the fbdev and drm drivers for a single hardware
>> should be exclusive at compile time. We don't allow multiple drivers for
>> single device for other subsystems either, do we? Eventually we should
>> have only one driver for one hardware device.
>>
>> If that's not possible, then the drivers in question could have an
>> option to enable or disable themselves, passed via the kernel command
>> line, so that the user can select which subsystem to use.
> 
> That is the exact same problem as having multiple drivers that can bind
> to the same device.

Hmm, sorry? Weren't we just discussing about that problem =). Or maybe I
missed the original point from Russell, as the problem about DRM and
fbdev conflicting sounded a bit unrelated.

> For i.MX, for now, let's keep the mandatory imx-drm node. Maybe rename
> it so nobody can say we are leaking linux subsystem names into the
> device tree.

Sounds good to me.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140228/a50d02a3/attachment.sig>
