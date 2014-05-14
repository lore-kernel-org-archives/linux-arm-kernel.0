From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 14 May 2014 20:42:17 +0200
Subject: [RFC PATCH 0/8] component helper improvements
In-Reply-To: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
References: <20140426230025.GZ26756@n2100.arm.linux.org.uk>
Message-ID: <20140514184212.GA14232@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 27, 2014 at 12:00:25AM +0100, Russell King - ARM Linux wrote:
> A while back, Laurent raised some comments about the component helper,
> which this patch set starts to address.
> 
> The first point it addresses is the repeated parsing inefficiency when
> deferred probing occurs.  When DT is used, the structure of the
> component helper today means that masters end up parsing the device
> tree for each attempt to re-bind the driver.
> 
> We remove this inefficiency by creating an array of matching data and
> functions, which the component helper can use internally to match up
> components to their master.
> 
> The second point was the inefficiency of destroying the list of
> components each time we saw a failure.  We did this to ensure that
> we kept things correctly ordered: component bind order matters.
> As we have an array instead, the array is already ordered, so we
> use this array to store the component pointers instead of a list,
> and remember which are duplicates (and thus should be avoided.)
> Avoiding the right duplicates matters as we walk the array in the
> opposite direction at tear down.

I've been looking at converting the Tegra DRM driver to the component
helpers for a while now and had to make some changes to make it work for
that particular use-case. While updating the imx-drm and msm DRM drivers
for those changes I noticed an oddity. Both of the existing drivers use
the following pattern:

	static int driver_component_bind(struct device *dev,
					 struct device *master,
					 void *data)
	{
		allocate memory
		request resources
		...
		hook up to subsystem
		...
		enable hardware
	}

	static const struct component_ops driver_component_ops = {
		.bind = driver_component_bind,
	};

	static int driver_probe(struct platform_device *pdev)
	{
		return component_add(&pdev->dev, &driver_component_ops);
	}

While converting Tegra DRM, what I intuitively did (I didn't actually
look at the other drivers for inspiration) was something more along the
lines of the following:

	static int driver_component_bind(struct device *dev,
					 struct device *master,
					 void *data)
	{
		hook up to subsystem
		...
		enable hardware
	}

	static const struct component_ops driver_component_ops = {
		.bind = driver_component_bind,
	};

	static int driver_probe(struct platform_device *pdev)
	{
		allocate memory
		request resources
		...
		return component_add(&pdev->dev, &driver_component_ops);
	}

Since usually deferred probing is caused by resource allocations failing
this has the side-effect of handling deferred probing before the master
device is even bound (the component_add() happens as the very last step)
and therefore there is less risk for component_bind_all() to fail. I've
actually never seen it fail at all. Failure at that point is almost
certainly irrecoverable anyway.

It would seem to me that if other drivers followed the same pattern, the
second point above is solved by moving deferred probe handling one level
up and reduce the work of the component helpers to gluing together the
components on a subsystem level.

Another advantage to that pattern is that probe failure happens on a
much more granular level. It's handled by each component device rather
than all at once when the master is bound. By that time all components
will be ready and the heavy work of building the subsystem device will
usually not have to be undone as opposed to the former pattern where
that process is bound to be interrupted possibly many times be deferred
probing.

But perhaps I'm missing something. Was there another reason for choosing
this particular pattern?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140514/2cd86462/attachment.sig>
