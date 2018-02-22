From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 22 Feb 2018 09:43:21 +0100
Subject: [PATCH v4 03/40] KVM: arm64: Avoid storing the vcpu pointer on
 the stack
In-Reply-To: <d00629e8-da68-a536-dc22-b8c26e962b85@arm.com>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-4-christoffer.dall@linaro.org>
 <d00629e8-da68-a536-dc22-b8c26e962b85@arm.com>
Message-ID: <20180222084321.GB29376@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 19, 2018 at 03:50:20PM +0000, Julien Grall wrote:
> Hi Christoffer,
> 
> On 15/02/18 21:02, Christoffer Dall wrote:
> >We already have the percpu area for the host cpu state, which points to
> >the VCPU, so there's no need to store the VCPU pointer on the stack on
> >every context switch.  We can be a little more clever and just use
> >tpidr_el2 for the percpu offset and load the VCPU pointer from the host
> >context.
> >
> >This does require us to calculate the percpu offset without including
> >the offset from the kernel mapping of the percpu array to the linear
> >mapping of the array (which is what we store in tpidr_el1), because a
> >PC-relative generated address in EL2 is already giving us the hyp alias
> >of the linear mapping of a kernel address.  We do this in
> >__cpu_init_hyp_mode() by using kvm_ksym_ref().
> >
> >This change also requires us to have a scratch register, so we take the
> >chance to rearrange some of the el1_sync code to only look at the
> >vttbr_el2 to determine if this is a trap from the guest or an HVC from
> >the host.  We do add an extra check to call the panic code if the kernel
> >is configured with debugging enabled and we saw a trap from the host
> >which wasn't an HVC, indicating that we left some EL2 trap configured by
> >mistake.
> 
> You might want to remove this paragraph as you don't seem to have rework
> that part of the code in this version.
> 
Yes, will do.

Thanks,
-Christoffer
