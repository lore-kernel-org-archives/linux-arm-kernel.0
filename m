From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 May 2012 10:21:09 +0100
Subject: [PATCH] ARM: SMP: prevent use of the console when using idmap_pgd
In-Reply-To: <1336180444-26563-1-git-send-email-ccross@android.com>
References: <1336180444-26563-1-git-send-email-ccross@android.com>
Message-ID: <20120508092109.GB2263@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Colin,

Sorry for the delayed response.

On Sat, May 05, 2012 at 02:14:02AM +0100, Colin Cross wrote:
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

You missed a word out here (`delay'?) but it looks like Russell has taken
this now so I'm sure we'll cope.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
