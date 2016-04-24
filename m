From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Sun, 24 Apr 2016 22:17:49 +0100
Subject: [PATCHv2 6/6] efi/runtime-wrappers: detect FW irq flag corruption
In-Reply-To: <1461333083-15529-7-git-send-email-mark.rutland@arm.com>
References: <1461333083-15529-1-git-send-email-mark.rutland@arm.com>
 <1461333083-15529-7-git-send-email-mark.rutland@arm.com>
Message-ID: <20160424211749.GN2829@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr, at 02:51:23PM, Mark Rutland wrote:
> The UEFI spec allows runtime services to be called with interrupts
> masked or unmasked, and if a runtime service function needs to mask
> interrupts, it must restore the mask to its original state before
> returning (i.e. from the PoV of the OS, this does not change across a
> call). Firmware should never unmask exceptions, as these may then be
> taken by the OS unexpectedly.
> 
> Unfortunately, some firmware has been seen to unmask IRQs (and
> potentially other maskable exceptions) across runtime services calls,
> leaving irq flags corrupted after returning from a runtime services
> function call. This may be detected by the IRQ tracing code, but often
> goes unnoticed, leaving a potentially disastrous bug hidden.
> 
> This patch detects when the irq flags are corrupted by an EFI runtime
> services call, logging the call and specific corruption to the console.
> While restoring the expected value of the flags is insufficient to avoid
> problems, we do so to avoid redundant warnings from elsewhere (e.g. IRQ
> tracing).
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: linux-efi at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  drivers/firmware/efi/runtime-wrappers.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> I'm not sure about the LOCKDEP_NOW_UNRELIABLE here. If FW unmasks IRQs there's
> the potential for deadlock, but arguably by the time we've detected the flag
> corruption the danger has passed. I'm erring on the side of caution here
> setting it, but perhaps that's not the best idea?

I think it makes sense to leave it as-is, not least to guard against
future changes we make to the kernel side that might have lockdep side
effects when this bug is triggered.
