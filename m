From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 May 2014 10:55:25 +0200
Subject: [PATCH v2 9/9] arm64: KVM: enable trapping of all debug registers
In-Reply-To: <53860A5A.8030009@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-10-git-send-email-marc.zyngier@arm.com>
 <20140525153629.GJ3866@lvm> <53860A5A.8030009@arm.com>
Message-ID: <20140529085525.GD61607@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 28, 2014 at 05:10:02PM +0100, Marc Zyngier wrote:
> On 25/05/14 16:36, Christoffer Dall wrote:
> > On Tue, May 20, 2014 at 05:55:45PM +0100, Marc Zyngier wrote:
> >> Enable trapping of the debug registers, preventing the guests to
> >> mess with the host state (and allowing guests to use the debug
> >> infrastructure as well).
> >>
> >> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> >> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> >> ---
> >>  arch/arm64/kvm/hyp.S | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
> >> index 73ec5c4..72ed0bf8 100644
> >> --- a/arch/arm64/kvm/hyp.S
> >> +++ b/arch/arm64/kvm/hyp.S
> >> @@ -777,6 +777,14 @@ __kvm_hyp_code_start:
> >>  	mrs	x2, mdcr_el2
> >>  	and	x2, x2, #MDCR_EL2_HPMN_MASK
> >>  	orr	x2, x2, #(MDCR_EL2_TPM | MDCR_EL2_TPMCR)
> >> +	orr	x2, x2, #(MDCR_EL2_TDRA | MDCR_EL2_TDOSA)
> > 
> > so we unconditionally trap on the OS register access, but we don't
> > properly emulate these do we?  What's the rationale?  (atmittedly,
> > again, I'm not 100% clear on how the OS lock thingy is supposed to
> > work/be used).
> 
> The rational is that we don't want the guest to mess with the host
> state, which may have decided to use the OSlock thing (we don't use it
> at all, but who knows...). So we trap it, discard whatever the guest
> wants to put there, and carry on.
> 
> I'm not sure if this would confuse any guest (we only have Linux so far,
> so I'm not too worried). Should a more adventurous guest show up, we can
> revisit this.
> 
Yes, your explanation in the cover letter reply calmed me down.

I'm happy with this.

Thanks,
-Christoffer
