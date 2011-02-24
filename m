From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Feb 2011 19:55:23 +0000
Subject: [PATCH 4/4] msm: scm: Get cacheline size from CTR
In-Reply-To: <4D66B236.4030003@ru.mvista.com>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
	<1298573085-23217-5-git-send-email-sboyd@codeaurora.org>
	<4D66B236.4030003@ru.mvista.com>
Message-ID: <20110224195523.GA3640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 24, 2011 at 10:32:06PM +0300, Sergei Shtylyov wrote:
>    Won't generic cache_line_size() macro do instead? It's defined as  
> L1_CACHE_BYTES.

L1_CACHE_BYTES needs to be a compile time constant.  As such it ends up
being defined to the largest cache line size for the range of CPUs built
into the kernel.  This allows us to appropriately align data structures
to cache line boundaries which are boundaries for any of the CPUs which
are to be supported.

However, if you need to know exactly what cache line size you have for
doing things like cache maintainence then you can not use L1_CACHE_BYTES
or anything related to that.

One of the issues which complicates decoding the cache line size is that
on some CPUs, there's no way to read it.  On later CPUs, there's the
cache type register, of which there's several different formats which
makes decoding it rather painful and complicated.  Then there's the
related issue as to which cache line size you want - L1 Dcache, L1
Icache, or L2 cache, or some other level of cache?

It's all rather messy.
