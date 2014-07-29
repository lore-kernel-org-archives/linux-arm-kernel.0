From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 29 Jul 2014 12:29:40 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140728164459.GD32359@quad.lixom.net>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-20-git-send-email-hanjun.guo@linaro.org>
 <CAOesGMhKHGkVK3dOLXXx9GQBMxDmjBu1WDBgHmwdGe1UK3jfcg@mail.gmail.com>
 <20140728100654.GC24078@leverpostej>
 <20140728164459.GD32359@quad.lixom.net>
Message-ID: <20140729102940.GB18250@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 09:44:59AM -0700, Olof Johansson wrote:
> On Mon, Jul 28, 2014 at 11:06:54AM +0100, Mark Rutland wrote:

[...]

> > >
> > > > +Relationship with Device Tree
> > > > +-----------------------------
> > > > +
> > > > +ACPI support in drivers and subsystems for ARMv8 should never be mutually
> > > > +exclusive with DT support at compile time.
> > > > +
> > > > +At boot time the kernel will only use one description method depending on
> > > > +parameters passed from the bootloader.
> > >
> > > Possibly overriden by kernel bootargs. And as debated for quite a
> > > while earlier this year, acpi should still default to off -- if a DT
> > > and ACPI are both passed in, DT should at this time be given priority.
> > 
> > Why? I really don't see the logic in doing that.
> 
> Seems like I am replying to your emails in reverse order.
> 
> > Currently the kernel can only boot using DT, so DT will be used even if
> > ACPI is present. In the presence of ACPI support in the kernel, ACPI
> > would be used on said systems.
> 
> For all the reasons we hashed out earlier this year: We can't trust that
> vendors will know how to do ACPI from day one, so instead of loading up the
> kernel with lots of quirks and workarounds, we'll default to not using it until
> we're at a point where things look mature enough.
> 
> The alternative is to keep this patch set out of the kernel. We can do that
> too, but I don't think that really helps anyone.
> 
> > From the discussions at the last Linaro Connect, this was seen as
> > important for virtual machines which want to provide ACPI services to
> > guests while still being able to boot DT-only kernels. I'll leave it to
> > Grant, Rob, and Christoffer to cover that.
> 
> Ok, waiting to see what they have to say then.
> 

Hmm, a virtual machine implementaion may provide either a DT or ACPI (or
both).  I think the point at Linaro Connect was that for a first cut,
there is no obvious need to provide ACPI to VMs and to be spec
compliant, server kernels must be able to boot with DT-only.  In most
cases such systems will only access a few limited emulated devices
(UART, GIC, RTC, flash controller) and VirtIO devices, which should just
work using DT only.

People are talking about adding ACPI for VM guests as well for various
reasons (device passthrough for example) in which case I would always
expect people to run UEFI inside their guests too (perhaps this is not
100% true in the case of Xen fast-boot scenarios though) and I would
expect Linux to only see the little stub DT and ACPI.

Does this clarify anything or add futher to the confusion?

-Christoffer
