From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 2 Aug 2017 16:15:21 +0100
Subject: [RFC PATCH v4 5/5] arm64: neon: Allow EFI runtime services to
 use FPSIMD in irq context
In-Reply-To: <20170802145801.nlmm6zfxe4xidkpg@armageddon.cambridge.arm.com>
References: <1501249824-18913-1-git-send-email-Dave.Martin@arm.com>
 <1501249824-18913-6-git-send-email-Dave.Martin@arm.com>
 <20170802145801.nlmm6zfxe4xidkpg@armageddon.cambridge.arm.com>
Message-ID: <20170802151521.GI6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 03:58:01PM +0100, Catalin Marinas wrote:
> On Fri, Jul 28, 2017 at 02:50:24PM +0100, Dave P Martin wrote:
> > Now that kernel-mode NEON use is non-nestable and not allowed in
> > hardirq/nmi context, we have a problem if the kernel decides to
> > call into EFI during an interrupt that interrupted a
> > kernel_neon_begin()..._end() block.  This will occur if the kernel
> > tries to write diagnostic data to EFI persistent storage during
> > a panic triggered by an NMI for example.
> > 
> > EFI runtime services specify an ABI that clobbers the FPSIMD state,
> > rather than being able to use it optionally as an accelerator.
> > This means that EFI is really a special case and can be handled
> > separately.
> > 
> > To enable EFI calls from interrupts, this patch creates dedicated
> > __efi_fpsimd_{begin,end}() helpers solely for this purpose, which
> > save/restore to a separate percpu buffer if called in a context
> > where kernel_neon_begin() is not usable.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Should this patch be reordered with patch 4? It looks like patch 4 no
> longer allows EFI runtime services in IRQ context.

Hmmm, yes, patches 4/5 are not bisectable at present.

I can't immediately see why patch 5 won't work if they're swapped:
rather, the !may_use_simd() fallback and efi_fpsimd_state won't get
used, and save/restore around EFI should work much the same as it does
today.

I'm happy to swap the patches, but I don't want to put too much effort
into confirming the above.  How concerned are you about the risk?

Cheers
---Dave
