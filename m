From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Sep 2016 18:06:51 +0100
Subject: [PATCH] arm64: Call numa_store_cpu_info() earlier.
In-Reply-To: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
References: <1474397195-16520-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160922170651.GB27704@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2016 at 11:46:35AM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The wq_numa_init() function makes a private CPU to node map by calling
> cpu_to_node() early in the boot process, before the non-boot CPUs are
> brought online.  Since the default implementation of cpu_to_node()
> returns zero for CPUs that have never been brought online, the
> workqueue system's view is that *all* CPUs are on node zero.
> 
> When the unbound workqueue for a non-zero node is created, the
> tsk_cpus_allowed() for the worker threads is the empty set because
> there are, in the view of the workqueue system, no CPUs on non-zero
> nodes.  The code in try_to_wake_up() using this empty cpumask ends up
> using the cpumask empty set value of NR_CPUS as an index into the
> per-CPU area pointer array, and gets garbage as it is one past the end
> of the array.  This results in:

Queued for 4.8. Thanks.

-- 
Catalin
