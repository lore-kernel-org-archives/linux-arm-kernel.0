From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 17:42:53 +0000
Subject: Cache maintenance on page table updates
In-Reply-To: <AANLkTikHpQLh53JN4OhjS2_T9XC=66Lk1MMPh2y1jc3u@mail.gmail.com>
References: <AANLkTikHpQLh53JN4OhjS2_T9XC=66Lk1MMPh2y1jc3u@mail.gmail.com>
Message-ID: <20101202174253.GI29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 05:39:58PM +0100, Christoffer Dall wrote:
> Hi Catalin.
> 
> I am hoping you can help me understand the following observed behavior in KVM.
> 
> When I update the page table mappings' AP bits, it is for some reason
> not enough to clean caches, but I must also invalidate them for the
> changes to take effect. The system runs on an arm1136 processor and I
> was under the impression that page table walks never read from the L1
> cache. If this is true, I cannot understand why an invalidation of
> caches would make a difference.
> 
> In the course of understanding this behavior I have come across the
> RGN, S and C bits in the TTBR0. I don't quite understand how these
> bits affect the memory system - should they simply match the way that
> the page tables themselves are mapped in virtual memory or do they
> somehow control how the page table walk mechanism behaves?

The CPU provides various controls during external memory accesses to
control down-stream caches.  These bits set those controls, and
should match the memory types etc used for accessing the page tables
from the CPU.
