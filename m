From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 May 2012 17:49:33 +0100
Subject: [PATCH] ARM: SMP: prevent use of the console when using idmap_pgd
In-Reply-To: <1336180444-26563-1-git-send-email-ccross@android.com>
References: <1336180444-26563-1-git-send-email-ccross@android.com>
Message-ID: <20120505164933.GQ897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 04, 2012 at 06:14:02PM -0700, Colin Cross wrote:
> Commit 4e8ee7de227e3ab9a72040b448ad728c5428a042 (ARM: SMP: use
> idmap_pgd for mapping MMU enable during secondary booting)
> switched secondary boot to use idmap_pgd, which is initialized
> during early_initcall, instead of a page table initialized during
> __cpu_up.  This causes idmap_pgd to contain the static mappings
> but be missing all dynamic mappings.
> 
> If a console is registered that creates a dynamic mapping, the
> printk in secondary_start_kernel will trigger a data abort on
> the missing mapping before the exception handlers have been
> initialized, leading to a hang.  Initial boot is not affected
> because no consoles have been registered, and resume is usually
> not affected because the offending console is suspended.
> Onlining a cpu with hotplug triggers the problem.
> 
> A workaround is to the printk in secondary_start_kernel until
> after the page tables have been switched back to init_mm.

I think this is fine.  Please put it in the patch system, thanks.
