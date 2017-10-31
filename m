From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 31 Oct 2017 06:34:32 +0000
Subject: [PATCH v4 15/21] KVM: arm64: Set an impdef ESR for Virtual-SError
 using VSESR_EL2.
In-Reply-To: <20171019145807.23251-16-james.morse@arm.com> (James Morse's
 message of "Thu, 19 Oct 2017 15:58:01 +0100")
References: <20171019145807.23251-1-james.morse@arm.com>
 <20171019145807.23251-16-james.morse@arm.com>
Message-ID: <86tvyf3jwn.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19 2017 at  4:58:01 pm BST, James Morse <james.morse@arm.com> wrote:
> Prior to v8.2's RAS Extensions, the HCR_EL2.VSE 'virtual SError' feature
> generated an SError with an implementation defined ESR_EL1.ISS, because we
> had no mechanism to specify the ESR value.
>
> On Juno this generates an all-zero ESR, the most significant bit 'ISV'
> is clear indicating the remainder of the ISS field is invalid.
>
> With the RAS Extensions we have a mechanism to specify this value, and the
> most significant bit has a new meaning: 'IDS - Implementation Defined
> Syndrome'. An all-zero SError ESR now means: 'RAS error: Uncategorized'
> instead of 'no valid ISS'.
>
> Add KVM support for the VSESR_EL2 register to specify an ESR value when
> HCR_EL2.VSE generates a virtual SError. Change kvm_inject_vabt() to
> specify an implementation-defined value.
>
> We only need to restore the VSESR_EL2 value when HCR_EL2.VSE is set, KVM
> save/restores this bit during __deactivate_traps() and hardware clears the
> bit once the guest has consumed the virtual-SError.
>
> Future patches may add an API (or KVM CAP) to pend a virtual SError with
> a specified ESR.
>
> Cc: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
