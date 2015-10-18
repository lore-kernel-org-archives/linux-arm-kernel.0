From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 18 Oct 2015 22:13:52 +0200
Subject: [PATCH] arm64: kvm: restore EL1N SP for panic
In-Reply-To: <1444658690-8180-1-git-send-email-mark.rutland@arm.com>
References: <1444658690-8180-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20151018201352.GD7531@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 03:04:50PM +0100, Mark Rutland wrote:
> If we panic in hyp mode, we inject a call to panic() into the EL1N host
> kernel. If a guest context is active, we first attempt to restore the
> minimal amount of state necessary to execute the host kernel with
> restore_sysregs.
> 
> However, the SP is restored as part of restore_common_regs, and so we
> may return to the host's panic() function with the SP of the guest. Any
> calculations based on the SP will be bogus, and any attempt to access
> the stack will result in recursive data aborts.
> 
> When running Linux as a guest, the guest's EL1N SP is like to be some
> valid kernel address. In this case, the host kernel may use that region
> as a stack for panic(), corrupting it in the process.
> 
> Avoid the problem by restoring the host SP prior to returning to the
> host. To prevent misleading backtraces in the host, the FP is zeroed at
> the same time. We don't need any of the other "common" registers in
> order to panic successfully.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: <kvmarm@lists.cs.columbia.edu>

Applied - thanks,
-Christoffer
