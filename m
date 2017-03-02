From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 2 Mar 2017 09:39:21 +0000
Subject: [PATCH V11 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <4ff98823-d6f0-eb2e-4b98-f6d5e255f6c3@huawei.com>
References: <1487712121-16688-1-git-send-email-tbaicar@codeaurora.org>
 <1487712121-16688-11-git-send-email-tbaicar@codeaurora.org>
 <df6ba5dc-d93f-925a-46bf-1e1e209d17f3@huawei.com> <58B43092.6040401@arm.com>
 <3df82a7b-1a32-e2d7-ae78-7132a4eab1a0@huawei.com> <58B57941.3000703@arm.com>
 <4ff98823-d6f0-eb2e-4b98-f6d5e255f6c3@huawei.com>
Message-ID: <6d0fa5a5-bcbf-38b8-45ac-d645220ee9e2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/03/17 02:31, Xiongfeng Wang wrote:

[lot of things]

> If an SEA is injected into guest OS, the guest OS will jump to the SEA
> exception entry when the context switched to guest OS. And the CPSR and
> FAR_EL1 are recovered according to the content of vcpu. Then the guest
> OS can signal a process or panic. If another guest process read the
> error data, another SEA will be generated and it will be single too.
> 
> Without QEMU involved, the drawback is that no APEI table can be mocked
> up in guest OS, and no memory_failure() will be called. So the memory of
> error data will be released into buddy system and assigned to another
> process. If the error was caused by instantaneous radiation or
> electromagnetic, the memory is usable again if it is written with a
> correct data. If the memory has wore out and a correct data is written,
> the ECC error may occurs again with high possibility. Before a 2-bit ECC
> error is reported, much more 1-bit errors will be reported. This is
> report to host os, the host os can determine the memory node has worn
> out and hot-plug out the memory node, and guest os may be terminated if
> its memory data can't be migrated.
> 
> Of course, it is better to get QEMU involved, so the memory_failure can
> be executed in guest OS. But before that implemented, can we add SEA
> injection in kvm_handle_guest_abort()?

No. I will strongly object to that. This is a platform decision to
forward SEAs, not an architectural one. The core KVM code is only
concerned about implementing the ARM architecture, and not something
that is firmware dependent.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
