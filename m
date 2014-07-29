From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Jul 2014 14:19:51 +0100
Subject: [PATCH v15 01/12] irq: gic: support hip04 gic
In-Reply-To: <2455679.mpY3ZEfao6@wuerfel>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-2-git-send-email-haojian.zhuang@linaro.org>
 <87a97to025.fsf@approximate.cambridge.arm.com>
 <2455679.mpY3ZEfao6@wuerfel>
Message-ID: <20140729131951.GQ9245@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 02:05:06PM +0100, Arnd Bergmann wrote:
> On Monday 28 July 2014 18:38:58 Marc Zyngier wrote:
> > Overall, this code should be able to sitting within a #ifdef/#endif
> > block, only selected if this platform is enabled, and possibly find a
> > way not to impact all the other platforms when this is not selected.
> > 
> > Finally, I'd like to outline how much I dislike the way the GIC
> > architecture has been abused here. Yes, this solves a particular
> > problem, at a given point in time, but this also feels extremely short
> > sighted from whoever has put this thing together. This really feels like
> > a short-term HW hack that is already addressed by GICv3. Merging support
> > for non architecture compliant HW is never the best solution.
> 
> Not merging support for shipping hardware is also not a solution,
> and we already support any number of irqchip drivers and have all
> the logic we need to sort that out at runtime.
> 
> My feeling is that the original approach taken in the early version
> of the patch set was actually better, given all the problems with
> integrating this nicely into the gic driver.
> 
> Would you be happier with that? The downside of that would be
> that some driver bugs would get fixed in one driver but not the
> other one, which is why we normally try to avoid it. On the other
> hand, it means that the normal GIC driver does not get polluted
> with hacks that are only needed for the hip04 version and there
> is an obvious way to disable the driver at compile time when you
> build for other platforms.

Yeah, I think after all this, you're right and keeping the two drivers
strictly separate is probably the best thing after all. That also allows
the vgic and gicv3 work to continue regardless of the hip04 driver,
especially since we don't have any useful documentation for the hardware
itself.

As for the KVM side, I think we should treat this as something totally
separate to the GIC and *not* instantiate a vgic in response to
KVM_CREATE_IRQCHIP on systems with this hardware.

Will
