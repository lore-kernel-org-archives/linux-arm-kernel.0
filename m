From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 11 May 2018 15:13:35 -0500
Subject: [PATCH 00/12] introduce support for early platform drivers
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Message-ID: <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> This series is a follow-up to the RFC[1] posted a couple days ago.
>
> NOTE: this series applies on top of my recent patches[2] that move the previous
> implementation of early platform devices to arch/sh.
>
> Problem:
>
> Certain class of devices, such as timers, certain clock drivers and irq chip
> drivers need to be probed early in the boot sequence. The currently preferred
> approach is using one of the OF_DECLARE() macros. This however does not create
> a platform device which has many drawbacks - such as not being able to use
> devres routines, dev_ log functions or no way of deferring the init OF function
> if some other resources are missing.

I skimmed though this and it doesn't look horrible (how's that for
positive feedback? ;) ). But before going into the details, I think
first there needs to be agreement this is the right direction.

The question does remain though as to whether this class of devices
should be platform drivers. They can't be modules. They can't be
hotplugged. Can they be runtime-pm enabled? So the advantage is ...

I assume that the clock maintainers had some reason to move clocks to
be platform drivers. It's just not clear to me what that was.

> For drivers that use both platform drivers and OF_DECLARE the situation is even
> more complicated as the code needs to take into account that there can possibly
> be no struct device present. For a specific use case that we're having problems
> with, please refer to the recent DaVinci common-clock conversion patches and
> the nasty workaround that this problem implies[3].

So devm_kzalloc will work with this solution? Why did we need
devm_kzalloc in the first place? The clocks can never be removed and
cleaning up on error paths is kind of pointless. The system would be
hosed, right?

> We also used to have an early platform drivers implementation but they were not
> integrated with the linux device model at all - they merely used the same data
> structures. The users could not use devres, defer probe and the early devices
> never became actual platform devices later on.
>
> Proposed solution:
>
> This series aims at solving this problem by (re-)introducing the concept of
> early platform drivers and devices - this time however in a way that seamlessly
> integrates with the existing platform drivers and also offers device-tree
> support.
>
> The idea is to provide a way for users to probe devices early, while already
> being able to use devres, devices resources and properties and also deferred
> probing.
>
> New structures are introduced: the early platform driver contains the
> early_probe callback which has the same signature as regular platform_device
> probe. This callback is called early on. The user can have both the early and
> regular probe speficied or only one of them and they both receive the same
> platform device object as argument. Any device data allocated early will be
> carried over to the normal probe.
>
> The architecture code is responsible for calling early_platform_start() in
> which the early drivers will be registered and devices populated from DT.

Can we really do this in one spot for different devices (clk, timers,
irq). The sequence is all very carefully crafted. Platform specific
hooks is another thing to consider.

> Once the device and kobject mechanisms are ready, all early drivers and devices
> will be converted into real platform drivers and devices. Also: if any of the
> early platform registration functions will be called once early initialization
> is done, these functions will work like regular platform_device/driver ones.

This could leave devices in a weird state. They've successfully probed
early, but then are on the deferred list for normal probe for example.

Rob
