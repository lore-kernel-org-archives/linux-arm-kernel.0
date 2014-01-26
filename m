From: js07.lee@samsung.com (Jungseung Lee)
Date: Sun, 26 Jan 2014 14:13:43 +0900
Subject: [Q] L1_CACHE_BYTES on flush_pfn_alias function.
In-Reply-To: <20140124154321.GI19052@arm.com>
References: <00d501cf136a$24ec49c0$6ec4dd40$@samsung.com>
 <20140124154321.GI19052@arm.com>
Message-ID: <003c01cf1a55$623979f0$26ac6dd0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not to flush some more bytes. In the scenario, they can *omit* to flush last 32 bytes.

L1_CACHE_BYTES = 64 (ARM v7, CA9)

asm(    "mcrr   p15, 0, %1, %0, c14\n"
    "   mcr p15, 0, %2, c7, c10, 4"
        :
        : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
        : "cc");
-----Original Message-----
From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
Sent: Saturday, January 25, 2014 12:43 AM
Cc: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk; linux-kernel at vger.kernel.org
Subject: Re: [Q] L1_CACHE_BYTES on flush_pfn_alias function.

On Fri, Jan 17, 2014 at 09:54:42AM +0000,        wrote:
> Follow the mailing-list
> http://comments.gmane.org/gmane.linux.ports.arm.omap/31686
> 
> >>Setting the L1 cache line size larger than it actually is should be safe.
> 
> the written code expected as L1_CACHE_BYTES should be real cache line 
> size has bug.
> It looks like that flush_pfn_alias function should be fixed.

Did you actually notice any problem with flushing some more bytes? It's a clean+invalidate rather than invalidate, I don't see any problem.

--
Catalin
