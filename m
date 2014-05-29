From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 May 2014 19:55:34 +0100
Subject: nommu build failures on ARM in linux-next
In-Reply-To: <5387661F.1050000@windriver.com>
References: <5387661F.1050000@windriver.com>
Message-ID: <20140529185534.GK3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 12:53:51PM -0400, Paul Gortmaker wrote:
> Hi Russell,
> 
> The allnoconfig builds in linux-next fail because __clear_cr
> lives in mmu.c without any stub or similar in nommu.c
> 
> Introduced by:
> 
> commit 247e4fff3aa927ad069447e6da05bb966b70dece
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Sun Apr 13 18:57:29 2014 +0100
> 
>     ARM: provide common method to clear bits in CPU control register
>     
> Sample failure:
>   http://kisskb.ellerman.id.au/kisskb/buildresult/11264405/

ALIGNMENT_TRAP depends on CPU_CP15_MMU, so it's quite reasonable that
__clear_cr should exist in this case - but it doesn't because it's in
mmu.c.  I guess we need __clear_cr moved to arch/arm/kernel/setup.c.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
