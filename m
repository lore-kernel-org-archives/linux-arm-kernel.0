From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 17:06:50 +0100
Subject: [PATCH] KVM: arm/arm64: Remove struct vgic_irq pending field
In-Reply-To: <ef1d4338-8348-74a7-390d-dcc60fc47607@arm.com>
References: <20170123133951.10329-1-christoffer.dall@linaro.org>
 <ef1d4338-8348-74a7-390d-dcc60fc47607@arm.com>
Message-ID: <20170123160650.GF15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 03:44:16PM +0000, Marc Zyngier wrote:
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
> > 
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> I admit having lost a few brain cells looking at this patch, and I can't
> prove it wrong! ;-) I like the fact that it now provides a safe
> abstraction to the pending state, and that there is exactly *one* place
> where line_level is evaluated.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 

Thanks!

I suppose looking at this again, I don't need the
"irq_set_pending_latch()" indirection but I can just set this variable
directly.  What do you think?  Would it be cleaner?

-Christoffer
