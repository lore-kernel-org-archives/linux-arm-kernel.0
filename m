From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 27 Jan 2014 16:43:37 +0000
Subject: [Q] L1_CACHE_BYTES on flush_pfn_alias function.
In-Reply-To: <003c01cf1a55$623979f0$26ac6dd0$@samsung.com>
References: <00d501cf136a$24ec49c0$6ec4dd40$@samsung.com>
 <20140124154321.GI19052@arm.com>
 <003c01cf1a55$623979f0$26ac6dd0$@samsung.com>
Message-ID: <20140127164337.GB8358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please do not top-post.

On Sun, Jan 26, 2014 at 05:13:43AM +0000, Jungseung Lee wrote:
> Not to flush some more bytes. In the scenario, they can *omit* to flush last 32 bytes.
> 
> L1_CACHE_BYTES = 64 (ARM v7, CA9)
> 
> asm(    "mcrr   p15, 0, %1, %0, c14\n"
>     "   mcr p15, 0, %2, c7, c10, 4"
>         :
>         : "r" (to), "r" (to + PAGE_SIZE - L1_CACHE_BYTES), "r" (zero)
>         : "cc");

Ah, I got it now. I think this should be (to + PAGE_SIZE - 1). My
reading of the ARM ARM is that the bottom bits of the address are
ignored by mcrr.

-- 
Catalin
