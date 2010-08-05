From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Aug 2010 15:47:59 +0100
Subject: cpu_get_pgd()
In-Reply-To: <4C5AC972.4010109@l4dev.org>
References: <4C5AC972.4010109@l4dev.org>
Message-ID: <20100805144759.GD23473@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 05, 2010 at 05:23:46PM +0300, Bahadir Balban wrote:
> There's a call to cpu_get_pgd() from do_translation_fault()
> that reads the TTBR to reach the pgd pointer.
> 
> Why not use pgd_offset(current->mm, addr)?

Because current->mm might not refer to the page table which is currently
being used by the hardware.  Think about this sequence:

task = current
schedule()
next = some_other_task
switch_mm(next)
IRQ occurs, handler is in a module which is unmapped in next's mm but
exists in task's mm
prefetch fault occurs

Now at this point, if we look at current->mm, we find that the entry exists.
If we used this, and just returned, we'd repeat the prefetch fault, and
make no progress.

So we have to read the page tables which the hardware is currently using
to ensure that we update the right set of page tables.
