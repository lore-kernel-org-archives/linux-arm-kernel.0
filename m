From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 19:34:47 +0100
Subject: [PATCH] KVM: arm/arm64: Remove struct vgic_irq pending field
In-Reply-To: <154ecb7e-457d-ea56-4ae2-c2b37c951a8a@arm.com>
References: <20170123133951.10329-1-christoffer.dall@linaro.org>
 <154ecb7e-457d-ea56-4ae2-c2b37c951a8a@arm.com>
Message-ID: <20170123183447.GH15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 05:57:05PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 23/01/17 13:39, Christoffer Dall wrote:
> > One of the goals behind the VGIC redesign was to get rid of cached or
> > intermediate state in the data structures, but we decided to allow
> > ourselves to precompute the pending value of an IRQ based on the line
> > level and pending latch state.  However, this has now become difficult
> > to base proper GICv3 save/restore on, because there is a potential to
> > modify the pending state without knowing if an interrupt is edge or
> > level configured.
> > 
> > See the following post and related message for more background:
> > https://lists.cs.columbia.edu/pipermail/kvmarm/2017-January/023195.html
> > 
> > This commit gets rid of the precomputed pending field in favor of a
> > function that calculates the value when needed, irq_is_pending().
> > 
> > The soft_pending field is renamed to pending_latch to represent that
> > this latch is the equivalent hardware latch which gets manipulated by
> > the input signal for edge-triggered interrupts and when writing to the
> > SPENDR/CPENDR registers.
> > 
> > After this commit save/restore code should be able to simply restore the
> > pending_latch state, line_level state, and config state in any order and
> > get the desired result.
> 
> In general I like this very much and am wondering why we didn't come up
> with this earlier. But I guess we were so subscribed to our "cached
> pending" bit.
> 
> So I checked several cases, tested some logic equations and drew the
> state diagrams for the "before" and "after" case, but I couldn't find a
> reason why this wouldn't work.
> 
> I also think you can get rid of the irq_set_pending_latch() wrapper and
> assign the value directly, as I don't see any reason to hide the fact
> that it's indeed a simple assignment and nothing magic behind this
> function. Also it would make the diff a bit easier to read.

Agreed.  Once we have agreement about if we should cleanup clearing the
latch state, I'll respin with that and add you and Marc's RB tags with
the changed version.

> 
> But apart from that:
> 
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> 
> 
> I also gave this a quick test on the Juno and the Midway with both
> kvmtool and QEMU and they survived some basic testing.
> 
> I need to check a GICv3 machine tomorrow, but I don't expect any
> differences here.
> 

Thanks.

I tested this, including GICv2 migration on Mustang, and was going to do
GICv3 testing and 32-bit testin tomorrow, but I'm quite happy to hear
you gave it a spin on a 32-bit platform already.


-Christoffer
