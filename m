From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 25 Jun 2018 10:52:41 +0100
Subject: [PATCH 0/4] KVM: arm/arm64: vgic: Virtual interrupt grouping
 support
In-Reply-To: <20180624221103.15055-1-christoffer.dall@arm.com>
References: <20180624221103.15055-1-christoffer.dall@arm.com>
Message-ID: <CAFEAcA_C6Voh_6Ljj9--cbo14X_uWTOekM30dU=Rp9CtZK-6ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 June 2018 at 23:10, Christoffer Dall <christoffer.dall@arm.com> wrote:
> This small series addresses a peculiarity of the current VGIC
> implementation, namely that we don't support interrupt grouping.
>
> KVM either implements a GICv2 without support for the security
> extensions, or a GICv3 with DS=1.  For GICv2, on systems without the
> security extensions, group 0 interrupts can be configured to be either
> signalled as FIQs or as IRQs by the VM, whereas group 1 interrupts are
> always IRQs.  For GICv3, with DS=1, group 1 interrupts are always IRQs
> and group 0 interrupts are always FIQs, and there is no concept of
> secure vs. non-secure group 1 interrupts when DS=1.
>
> We were treating all interrupts on GICv2 as group 0, but yet telling the
> geust that they were group 1.  The first patch changes this behavior,
> which seems to have no effect on no known guests, but still.
>
> The remaining patches introduce proper interrupt grouping support, along
> with MMIO accessors for the VM and userspace to retrieve and set the
> which group SGIs, PPIs, and SPIs belong to.  LPIs are always group 1
> interrupts as per the architecture, and there is no way to modify this
> configuration (no IGROUPR registers for LPIs or equivalent ITS
> commands).

How do we handle migration compatibility here? For instance if
we have a guest running on an old kernel with GICv2, presumably
it reports the GICD_IGROUPRn to userspace as being all-1 (but
they behave as group 0); then when we load on the new kernel
the new kernel will honour the IGROUPRn values and the interrupts
will start behaving like group 1 ? Maybe this works because the
guest is expecting them to be signalled as IRQ either way...

thanks
-- PMM
