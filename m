From: avanbrunt@nvidia.com (Alexander Van Brunt)
Date: Wed, 20 Jun 2018 16:01:29 +0000
Subject: [PATCH 3/3] arm64: IPI each CPU after invalidating the I-cache
 for kernel mappings
In-Reply-To: <1529412495-17525-4-git-send-email-will.deacon@arm.com>
References: <1529412495-17525-1-git-send-email-will.deacon@arm.com>,
 <1529412495-17525-4-git-send-email-will.deacon@arm.com>
Message-ID: <1529510537801.73315@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When invalidating the instruction cache for a kernel mapping via
> flush_icache_range(), it is also necessary to flush the pipeline for
> other CPUs so that instructions fetched into the pipeline before the
> I-cache invalidation are discarded. For example, if module 'foo' is
> unloaded and then module 'bar' is loaded into the same area of memory,
> a CPU could end up executing instructions from 'foo' when branching into
> 'bar' if these instructions were fetched into the pipeline before 'foo'
> was unloaded.

I don't think this fixes the problem. If a CPU is executing 'foo', takes an IPI, and returns to find itself executing in the middle of 'bar' there is still a problem because the code changed. All this patch does is synchronize when two CPUs see 'foo' change to 'bar'.
