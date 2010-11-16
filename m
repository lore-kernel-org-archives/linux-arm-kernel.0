From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 Nov 2010 18:26:43 +0000
Subject: [PATCH 7/7] ARM: Thumb-2: Restore sensible zImage header
	layout for CONFIG_THUMB2_KERNEL
In-Reply-To: <1289913277-8822-7-git-send-email-dave.martin@linaro.org>
References: <1289913277-8822-1-git-send-email-dave.martin@linaro.org>
	<1289913277-8822-7-git-send-email-dave.martin@linaro.org>
Message-ID: <20101116182643.GC21926@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 01:14:37PM +0000, Dave Martin wrote:
> The code which makes up the zImage header clearly intends to
> leave a vector-table-sized gap of 8 words (NOPs, in fact),
> followed by a branch to the real entry point, a magic number,
> and a word containing the absolute entry point address.

That's an incorrect assumption.  The set of 8 words have nothing to do
with the CPUs vector table at all - it has more to do with compatibility
with a.out built kernels, where the a.out header was 32 bytes.

> This gets messed up with with CONFIG_THUMB2_KERNEL:
> 
>     * The NOPs making up the vector table become halfword-
>       sized.

Doesn't matter.

>     * The magic number and absolute entry point occur too early
>       and become misaligned.

Not used anymore - it's practically zero (and unused) for most cases
now anyway.

>     * The absolute entry point fails to indicate that the entry
>       point is Thumb code, which will cause incorrect execution
>       if the bootloader uses this to enter the kernel.

And as such...
