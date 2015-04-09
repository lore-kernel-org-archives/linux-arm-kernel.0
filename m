From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 9 Apr 2015 18:09:35 +0100
Subject: [PATCH 2/7] ARM: cache-v7: shift CLIDR to extract appropriate
 field before masking
In-Reply-To: <E1YdzF0-0008Cj-Dk@rmk-PC.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
 <E1YdzF0-0008Cj-Dk@rmk-PC.arm.linux.org.uk>
Message-ID: <20150409170934.GE23861@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 03, 2015 at 11:54:22AM +0100, Russell King wrote:
> Rather than have code which masks and then shifts, such as:
> 
> 	mrc     p15, 1, r0, c0, c0, 1
> ALT_SMP(ands	r3, r0, #7 << 21)
> ALT_UP( ands	r3, r0, #7 << 27)
> ALT_SMP(mov	r3, r3, lsr #20)
> ALT_UP(	mov	r3, r3, lsr #26)
> 
> re-arrange this as a shift and then mask.  The masking is the same for
> each field which we want to extract, so this allows the mask to be
> shared amongst code paths:
> 
> 	mrc     p15, 1, r0, c0, c0, 1
> ALT_SMP(mov	r3, r0, lsr #20)
> ALT_UP(	mov	r3, r0, lsr #26)
> 	ands	r3, r3, #7 << 1

It looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
