From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 30 Jun 2014 14:16:34 +0100
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <20140630104814.GA1495@ulmo>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
 <53AEF81D.3080408@ti.com> <20140628204025.GA16415@ulmo>
 <7497427.LQy8pJts8f@wuerfel> <20140630090118.GA24128@ulmo>
 <20140630103649.GF28951@arm.com> <20140630104814.GA1495@ulmo>
Message-ID: <20140630131628.GA31517@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 11:48:15AM +0100, Thierry Reding wrote:
> On Mon, Jun 30, 2014 at 11:36:49AM +0100, Catalin Marinas wrote:
> > On Mon, Jun 30, 2014 at 10:01:19AM +0100, Thierry Reding wrote:
> > > On Mon, Jun 30, 2014 at 09:20:30AM +0200, Arnd Bergmann wrote:
> > > > On Saturday 28 June 2014 22:40:26 Thierry Reding wrote:
> > > > > Also, the real win we get from moving code out into drivers/ is if we
> > > > > can provide a common framework for them. I don't see how we can possibly
> > > > > do that for this code since there simply isn't enough commonality
> > > > > between SoCs. At the same time we now have a situation where both 32-bit
> > > > > and 64-bit variants of some SoCs share some of the same hardware at the
> > > > > very low level and since we don't have mach-* directories for 64-bit ARM
> > > > > and shouldn't be duplicating code either, we need to find a new home for
> > > > > this type of code. drivers/soc seemed to fit perfectly well.
> > > > 
> > > > For the low-level stuff yes, but I agree with Santosh there needs to be
> > > > some more work trying to split out individual high-level drivers.
> > > > 
> > > > There are two common patterns for the interface between the low-level
> > > > register access and the more high-level stuff:  you can either use
> > > > a "syscon" driver that just exports a struct regmap and that gets referenced
> > > > from other drivers using a phandle in their device nodes, or you have
> > > > a driver in drivers/soc that exports a somewhat higher-level interface
> > > > and comes with its own header file that gets included by other drivers.
> > > > At the moment, the syscon/regmap variant can only be used once device
> > > > drivers are loaded, but there is some broad agreement that it should
> > > > be changed to allow calling syscon_regmap_lookup_by_phandle() at
> > > > early boot using just DT accessors.
> > > 
> > > Note that we already have all these drivers and they do work for earlier
> > > Tegra generations. My attempt to move these out of arch/arm/mach-tegra
> > > is merely about being able to share them with upcoming 64-bit variants.
> > > So it's not about adding new functionality but rather about keeping the
> > > existing level of functionality on 64-bit.
> > 
> > Only that for arm64 we try to do things slightly differently and not
> > because we just like to but because we want better standardisation
> > across SoCs. One example is the booting protocol. Another example, you
> > don't get some early initcalls for your SoC (no machine descriptor). The
> > hardware should be configured by firmware in such a way that it boots at
> > least up to arch_initcall() level (ideally, we should move anything to
> > device_initcall() but it's not always easy).
> 
> Well, one of the problems on Tegra is that we need part of the PMC to
> power up CPUs. There's no firmware that could do this for us. We need
> also access to another block called flow controller. Both of those
> drivers need to be available very early for things to work. At the same
> time the driver exposes control over power domains. So while we possibly
> can push CPU bringup/teardown to firmware for ARM64, we can't do the
> same for the other parts of the PMC, so we end up with a weird kind of
> driver.
> 
> Parts of it can't register with the driver model because it isn't
> available that early, and at the same time we need to register parts
> only later because they require the driver model.

That sounds familiar and that's exactly the problem, and that's a problem
that won't disappear by just moving code around directories (hey, it is
not that we have not tried =)), as you (and I) know very well:

https://lkml.org/lkml/2013/8/16/399
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html

Either a common way of dealing with this early CPU bring-up code is
implemented (but it can't be platform specific otherwise we are back to
square one) or we decide that this code does not belong in the kernel and
should be abstracted away.

And I think that most of the early bring up issues are just related to
powering-up/resetting a cpu for it to be booted, probably that's the
abstraction we should be focusing on, because it should just require poking
a bunch of registers to kickstart a CPU, no more than that, FW should be
able to deal with that and that's yet another reason behind PSCI design.

I am not convinced that the early device model would be useful for any
other reason, that's why shoehorning kernel changes in the current driver
model just to bring up secondaries is not something I consider useful
and proper, in the first place, but I am happy to hear other possible
concerns.

Lorenzo

> 
> > > I'm not a fan of the syscon/regmap approach at all and the existing
> > > drivers use a higher-level API already, so I think we're going to stick
> > > with that.
> > 
> > It's not about whether you are a fan of it or not but whether we can get
> > more code sharing across several SoCs and not just between tegra arm32
> > and arm64 versions.
> 
> syscon by definition cannot be shared between different SoCs.
> 
> Thierry


> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
