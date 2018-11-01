From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 1 Nov 2018 14:01:43 +0000
Subject: [PATCH] RFC: ARM: do not handle Spectre V2 on Vexpress CA9
In-Reply-To: <42704270-8d9f-3f7a-9af1-4bd87f413815@arm.com>
References: <20181101125406.8874-1-linus.walleij@linaro.org>
 <42704270-8d9f-3f7a-9af1-4bd87f413815@arm.com>
Message-ID: <20181101140143.GA27913@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 01:56:41PM +0000, Robin Murphy wrote:
> Hi Linus,
> 
> On 01/11/2018 12:54, Linus Walleij wrote:
> > Since the introduction of the Spectre V2 fixes for ARMv7,
> > especially the BPIALL workaround, the Versatile Express CA9
> > with its fragile CA9 core tile simply doesn't boot for me
> > anymore.
> > 
> > If I turn on low level debugging the boot log stops short
> > at:
> > 
> > smp: Bringing up secondary CPUs ...
> > GIC: PPI13 is secure or misconfigured
> > CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > CPU1: Spectre v2: using BPIALL workaround
> > GIC: PPI13 is secure or misconfigured
> > CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
> > CPU1: Spectre v2: using BPIALL workaround
> > 
> > This is pretty much consistent behaviour, I think it managed
> > to boot at one point but these fixes are definately rubbing
> > this CPU the wrong way.
> > 
> > This (not elegant) workaround tries to work around it by
> > simply not applying any Spectre v2 fixes on the ARM
> > Vexpress CA9. My other A9 platforms seem to work fine
> > with the fixes, so this appears to be related to the
> > fragility of the core tile on this one reference design,
> > so maybe it would be acceptable to mitigate it like this.
> > 
> > I don't know how much this could be related to my particular
> > specimen, it would be great if others with this machine
> > could verify the problem.
> 
> As far as I remember, the usual V2P_CA9 problem where the L2 cache locks up
> for unfathomable reasons can come and go reasonably consistently depending
> on the exact kernel configuration/version, and ultimately seems like it
> might be more sensitive to the general shape and timing of the early boot
> code than any particular feature. As such I'd be wary that there might still
> be some other combinations of options which would manage to boot with the
> mitigation left enabled, and others which won't even if (or at worst
> *because*) we do skip it.

Indeed, I was about ask if disabling L2 makes it any consistent.
We did try increasing the read/write/tag latencies in the past but never
got it fully consistent to push the change.

--
Regards,
Sudeep
