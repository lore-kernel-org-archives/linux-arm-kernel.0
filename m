From: davem@davemloft.net (David Miller)
Date: Fri, 11 Apr 2014 14:00:44 -0400 (EDT)
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411173853.GA21370@redhat.com>
References: <20140411153041.GQ16119@n2100.arm.linux.org.uk>
 <20140411172456.GA20506@redhat.com>
 <20140411173853.GA21370@redhat.com>
Message-ID: <20140411.140044.1787758980997246871.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 11 Apr 2014 19:38:53 +0200

> And perhaps the patch is not complete. "if (vma)" is not enough, a probed
> task can mmap something else at this vaddr.
> 
> copy_to_user_page() should only change the contents of area->page, so memcpy
> should be fine. But I am not sure that flush_icache_user_range() or
> flush_ptrace_access() is always safe on every arch if "struct page *page"
> doesn't match vma.

The architectures want the VMA for two reasons:

1) To get at the 'mm'.  The 'mm' is absolutely essential so that we can look
   at the MM cpumask and therefore determine what cpus this address space has
   executed upon, and therefore what cpus need the flush broadcast to.

2) To determine if the VMA is executable, in order to avoid the I-cache flush
   if possible.

I think you can get at the 'mm' trivially in this uprobes path, and we can just
as well assume that the VMA is executable since this thing is always writing
instructions.

So we could create a __copy_to_user_page() that takes an 'mm' and a boolean
'executable' which uprobes could unconditionally set true, and copy_to_user_page()
would then be implemented in terms of __copy_to_user_page().
