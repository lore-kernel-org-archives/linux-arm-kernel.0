From: drjones@redhat.com (Andrew Jones)
Date: Wed, 21 Feb 2018 18:32:44 +0100
Subject: [PATCH v4 04/40] KVM: arm64: Rework hyp_panic for VHE and non-VHE
In-Reply-To: <20180215210332.8648-5-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-5-christoffer.dall@linaro.org>
Message-ID: <20180221173244.bszvzbs7whmr5p3x@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 10:02:56PM +0100, Christoffer Dall wrote:
> VHE actually doesn't rely on clearing the VTTBR when returning to the
> host kernel, and that is the current key mechanism of hyp_panic to
> figure out how to attempt to return to a state good enough to print a
> panic statement.
> 
> Therefore, we split the hyp_panic function into two functions, a VHE and
> a non-VHE, keeping the non-VHE version intact, but changing the VHE
> behavior.
> 
> The vttbr_el2 check on VHE doesn't really make that much sense, because
> the only situation where we can get here on VHE is when the hypervisor
> assembly code actually called into hyp_panic, which only happens when
> VBAR_EL2 has been set to the KVM exception vectors.  On VHE, we can
> always safely disable the traps and restore the host registers at this
> point, so we simply do that unconditionally and call into the panic
> function directly.
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
> 
> Notes:
>     Changes since v1:
>      - Fixed typos in the commit message
>      - Still use the generic __deactivte_traps() function in the hyp panic
>        code until we rework that logic later.
> 
>  arch/arm64/kvm/hyp/switch.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
