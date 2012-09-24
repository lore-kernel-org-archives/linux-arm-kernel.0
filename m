From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 18:03:33 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120924165555.GF26454@n2100.arm.linux.org.uk>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk>
 <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk>
 <50608D3D.2010106@ti.com>
 <20120924165555.GF26454@n2100.arm.linux.org.uk>
Message-ID: <20120924170333.GE14198@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 05:55:55PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 24, 2012 at 12:41:33PM -0400, Cyril Chemparathy wrote:
> > It appears to be not that hard actually... Or maybe I'm totally missing  
> > your point.  Could it be that you last looked at this prior to the  
> > nobootmem compatibility stuff being added in?
> 
> Quite possible - we converted over to memblock here:
> 
> commit 2778f62056ada442414392d7ccd41188bb631619
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Fri Jul 9 16:27:52 2010 +0100
> 
> It looks like nobootmem.c was created here:
> 
> commit 0932587328d9bd5b500a640fbaff3290c8d4cabf
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Thu Feb 24 14:43:05 2011 +0100
> 
> So, when I was porting ARM to memblock, we had:
> 
> commit 08677214e318297f228237be0042aac754f48f1d
> Author: Yinghai Lu <yinghai@kernel.org>
> Date:   Wed Feb 10 01:20:20 2010 -0800
> 
> which causes a load of bootmem functions to panic() when bootmem is
> disabled.
> 
> > The following patch appears to work just fine on a faked sparsemem system:
> 
> Great.  Don't forget to also check flatmem too, just to be sure.

There is still a problem since nobootmem.c doesn't handle 64-bit
physical addresses, so calling free_bootmem() still truncates the
values. Simply replacing bootmem.c with nobootmem.c is not enough, we
need to also replace bootmem calls with the corresponding memblock ones.

-- 
Catalin
