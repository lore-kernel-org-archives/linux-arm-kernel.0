From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Apr 2010 19:27:27 +0100
Subject: [PATCH 2/2] arm: invalidate TLBs when enabling mmu
In-Reply-To: <1268143623-22361-3-git-send-email-saeed@marvell.com>
References: <1268143623-22361-1-git-send-email-saeed@marvell.com>
	<1268143623-22361-2-git-send-email-saeed@marvell.com>
	<1268143623-22361-3-git-send-email-saeed@marvell.com>
Message-ID: <20100414182726.GB13275@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 09, 2010 at 04:07:03PM +0200, Saeed Bishara wrote:
> Signed-off-by: Saeed Bishara <saeed@marvell.com>
> ---
>  arch/arm/boot/compressed/head.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 4fddc50..a1ab79f 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -489,6 +489,7 @@ __armv7_mmu_cache_on:
>  		mcr	p15, 0, r0, c1, c0, 0	@ load control register
>  		mrc	p15, 0, r0, c1, c0, 0	@ and read it back
>  		mov	r0, #0
> +		mcr	p15, 0, r0, c8, c7, 0	@ invalidate I,D TLBs
>  		mcr	p15, 0, r0, c7, c5, 4	@ ISB
>  		mov	pc, r12
>  

This can't be unconditional - if we're running on PMSA (iow, uclinux)
we should not execute this instruction.  Notice that the previous one
is conditional.

The other question is whether this should be done before or after the
ISB - if it's done before, my understanding is that it could occur
unordered with respect to the MMU being enabled - if that's indeed
the problem.
