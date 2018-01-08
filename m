From: james.morse@arm.com (James Morse)
Date: Mon, 08 Jan 2018 16:26:51 +0000
Subject: [PATCH v5 07/13] KVM: arm/arm64: mask/unmask daif around VHE
 guests
In-Reply-To: <20171215155101.23505-8-james.morse@arm.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-8-james.morse@arm.com>
Message-ID: <5A539BCB.8060509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15/12/17 15:50, James Morse wrote:
> Non-VHE systems take an exception to EL2 in order to world-switch into the
> guest. When returning from the guest KVM implicitly restores the DAIF
> flags when it returns to the kernel at EL1.
> 
> With VHE none of this exception-level jumping happens, so KVMs
> world-switch code is exposed to the host kernel's DAIF values, and KVM
> spills the guest-exit DAIF values back into the host kernel.
> On entry to a guest we have Debug and SError exceptions unmasked, KVM
> has switched VBAR but isn't prepared to handle these. On guest exit
> Debug exceptions are left disabled once we return to the host and will
> stay this way until we enter user space.
> 
> Add a helper to mask/unmask DAIF around VHE guests. The unmask can only
> happen after the hosts VBAR value has been synchronised by the isb in
> __vhe_hyp_call (via kvm_call_hyp()). Masking could be as late as
> setting KVMs VBAR value, but is kept here for symmetry.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> This isn't backportable because of the 'daif' helpers, I will produce a
> backport once its merged.
> 
> Changes since v4:
>  * Added empty declarations for 32bit. (how did I miss that?)

v4 of this patch had a Reviewed-by Christoffer, which I didn't pick up as I then
went on to confuse everyone...

https://patchwork.kernel.org/patch/10017467/

(Sorry Christoffer!)


Thanks,

James
