From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Oct 2013 09:37:39 +0100
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
Message-ID: <525FA1D3.8060001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/13 18:02, Anup Patel wrote:
> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
> functions hence cannot be emulated by the in-kernel PSCI emulation code.

Why can't we implement system-wide functionality in the kernel? I fail
to see the issue here.

> To tackle this, we forward PSCI SYSTEM_OFF and SYSTEM_RESET function
> calls from Guest to user space (i.e. QEMU or KVMTOOL) via KVM run
> structure with KVM_EXIT_PSCI exit reason.

I'm really not keen on this approach. Having part of the PSCI
implementation offloaded to userspace means we don't have a complete
implementation in KVM anymore, and we end-up duplicating functionality
all over the place.

Also, OFF and RESET are not PSCI specific concepts, and could be
implemented in various ways. I'm more inclined to return a
*standardized* exit code that the various platforms can interpret.

	M.
-- 
Jazz is not dead. It just smells funny...
