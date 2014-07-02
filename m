From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 12:12:06 +0100
Subject: [RFC PATCH 0/8] component helper improvements
In-Reply-To: <20140514184212.GA14232@ulmo>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
 <20140514184212.GA14232@ulmo>
Message-ID: <20140702111206.GA21252@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 08:42:17PM +0200, Thierry Reding wrote:
> I've been looking at converting the Tegra DRM driver to the component
> helpers for a while now and had to make some changes to make it work for
> that particular use-case. While updating the imx-drm and msm DRM drivers
> for those changes I noticed an oddity. Both of the existing drivers use
> the following pattern:
> 
> 	static int driver_component_bind(struct device *dev,
> 					 struct device *master,
> 					 void *data)
> 	{
> 		allocate memory
> 		request resources
> 		...
> 		hook up to subsystem
> 		...
> 		enable hardware
> 	}
> 
> 	static const struct component_ops driver_component_ops = {
> 		.bind = driver_component_bind,
> 	};
> 
> 	static int driver_probe(struct platform_device *pdev)
> 	{
> 		return component_add(&pdev->dev, &driver_component_ops);
> 	}
> 
> While converting Tegra DRM, what I intuitively did (I didn't actually
> look at the other drivers for inspiration) was something more along the
> lines of the following:
> 
> 	static int driver_component_bind(struct device *dev,
> 					 struct device *master,
> 					 void *data)
> 	{
> 		hook up to subsystem
> 		...
> 		enable hardware
> 	}
> 
> 	static const struct component_ops driver_component_ops = {
> 		.bind = driver_component_bind,
> 	};
> 
> 	static int driver_probe(struct platform_device *pdev)
> 	{
> 		allocate memory
> 		request resources
> 		...
> 		return component_add(&pdev->dev, &driver_component_ops);
> 	}
> 
> Since usually deferred probing is caused by resource allocations failing
> this has the side-effect of handling deferred probing before the master
> device is even bound (the component_add() happens as the very last step)
> and therefore there is less risk for component_bind_all() to fail. I've
> actually never seen it fail at all. Failure at that point is almost
> certainly irrecoverable anyway.

It isn't irrecoverable - that case is handled.

I really don't like two-stage driver initialisation - it increases the
chances of bugs creeping in.  Take for example this code:

probe()
{
	priv = devm_kzalloc(dev, whatever);
	priv->mem = devm_ioremap_resource(dev, res);
	dev_set_drvdata(dev, priv);
	return component_add(dev, &ops);
}

So far so good, not much can go wrong at that point - we know exactly
what state the 'priv' structure is at the point where the component_add
call is made.

Now, when the ops' bind method is called, we retrieve the private data.
At this point, we can no longer rely on the initialisation state of
many of the members.  We can't assume that they were zero when we're
called, because we can have this sequence of events:

- driver is probed
- component is bound
- component is unbound
- component is bound

At this point, the private data will be dirty.  This actually makes the
use of devm_kzalloc() a joke in the probe function - although it does
initialise all members to zero, we can't rely on that at all when the
component is bound.

While the driver itself may be coded for this to be safe, can we say the
same for any structures which are embedded into the private data, which
may be private to other subsystems?

By way of illustration, ASoC can also have this two stage approach.  I'll
draw your attention to SGTL5000, and the recent patch I submitted (which
I don't think will be taken.)  This driver suffers badly if the ASoC
"card" is bound, then unbound, and an attempt to rebind it again.  That's
because the driver gets some managed resources in both the first stage and
the second stage, and expects them to be automatically released in when
the second stage is torn down.  This bug has existed for a very long
time, and has gone unnoticed (it will be unnoticed until you try to debug
by removing modules and trying to load replacements, which is how I found
it.)

That exact bug can't happen with the component helpers, because I
explicitly thought about the handling of managed resources, and added
the necessary support to deal with these correctly.  However, it serves
as an example that, despite comments from people saying that my fear
is unlikely to happen, we already have code which suffers from issues
with two-stage initialisation.

The unfortunate thing is that validation testing for Linux tends not to
venture much past "does it boot", "are my devices present" and "can I run
some programs".  It doesn't cover system shutdown/reboot very often
(we've had bugs which have been present for ages there - my test farm
explicitly does a power off after boot testing now) and it hardly ever
covers drivers being unbound or module removal.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
