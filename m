From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Sep 2014 17:04:26 +0100
Subject: [PATCH] mfd: syscon: Decouple syscon interface from syscon devices
In-Reply-To: <12348292.z1qJl96tVA@wuerfel>
References: <1408694991-21615-1-git-send-email-pankaj.dubey@samsung.com>
 <4121644.3haxjiIdIo@wuerfel> <20140901112549.GM7374@lee--X1>
 <12348292.z1qJl96tVA@wuerfel>
Message-ID: <20140901160426.GJ8796@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Sep 2014, Arnd Bergmann wrote:

> On Monday 01 September 2014 12:25:49 Lee Jones wrote:
> > On Mon, 01 Sep 2014, Arnd Bergmann wrote:
> > > On Monday 01 September 2014 08:49:18 Lee Jones wrote:
> > > > On Fri, 22 Aug 2014, Pankaj Dubey wrote:
> > > > 
> > > > > From: Tomasz Figa <t.figa@samsung.com>
> > > > > 
> > > > > Currently a syscon entity can be only registered directly through a
> > > > > platform device that binds to a dedicated driver. However in certain use
> > > > > cases it is desirable to make a device used with another driver a syscon
> > > > > interface provider. For example, certain SoCs (e.g. Exynos) contain
> > > > > system controller blocks which perform various functions such as power
> > > > > domain control, CPU power management, low power mode control, but in
> > > > > addition contain certain IP integration glue, such as various signal
> > > > > masks, coprocessor power control, etc. In such case, there is a need to
> > > > > have a dedicated driver for such system controller but also share
> > > > > registers with other drivers. The latter is where the syscon interface
> > > > > is helpful.
> > > > > 
> > > > > This patch decouples syscon object from syscon driver, so that it can be
> > > > > registered from any driver in addition to the original "syscon" platform
> > > > > driver.
> > > > > 
> > > > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > > > ---
> > > > > 
> > > > > RFC patch [1] was posted by Tomasz Figa. This patch addresses some of
> > > > > comments given by Arnd to RFC patch, and further decouples syscon from
> > > > > device model. It also gives flexibility of registering with syscon at
> > > > > early stage using device_node object.
> > > > 
> > > > It would be helpful if Arnd gave this revision his blessing (Ack).
> > > 
> > > I never saw a reason why we don't take this all the way as discussed
> > > a few times: Completely remove the dependency of syscon on having
> > > a platform driver for it, and make it possible to just call
> > > syscon_regmap_lookup_by_phandle() without having to register
> > > it first.
> > 
> > I think this sounds like a good end-state.  Migrating over by
> > supporting both methods in this way does sound like the correct thing
> > to do though.  Doing so is likely to dramatically reduce the effect on
> > current users.
> 
> Maybe I'm misreading the patch, but I don't see how it creates a
> migration path. What I want to end up with is infrastructure that
> lets anybody call syscon_regmap_lookup_by_pdevname or
> syscon_regmap_lookup_by_compatible (if they really need to)
> without needing the platform_driver for syscon. That should not
> require any form of compatibility layer because to the driver
> using it there is no API change.

Somehow I think the likelyhood is that I am misreading the patch.

I thought that before this patch drivers we had to register a syscon
device to bind to this driver, which was fine for the first use-cases
of syscon as it wasn't required too early during boot.  However, now
there are use-cases where systems require access to syscon registers
eariler in boot we require a means to obtain access prior to device
probing.  I thought this patch not only provides that possibilty, but
also leaves in the ability to register direct from DT.

> In contrast, this patch introduces a new of_syscon_{un,}register()
> interface that would get removed after the the above has
> been implemented, causing extra churn for any driver that also
> wants to provide a regmap-like interface.

When will we ever not have to register syscon?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
