From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Nov 2015 16:27:19 +0000
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <563B81DA.2080409@redhat.com>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
 <563B81DA.2080409@redhat.com>
Message-ID: <20151105162719.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 08:20:42AM -0800, Laura Abbott wrote:
> On 11/05/2015 01:46 AM, Russell King - ARM Linux wrote:
> >On Wed, Nov 04, 2015 at 05:00:39PM -0800, Laura Abbott wrote:
> >>Currently, read only permissions are not being applied even
> >>when CONFIG_DEBUG_RODATA is set. This is because section_update
> >>uses current->mm for adjusting the page tables. current->mm
> >>need not be equivalent to the kernel version. Use pgd_offset_k
> >>to get the proper page directory for updating.
> >
> >What are you trying to achieve here?  You can't use these functions
> >at run time (after the first thread has been spawned) to change
> >permissions, because there will be multiple copies of the kernel
> >section mappings, and those copies will not get updated.
> >
> >In any case, this change will probably break kexec and ftrace, as
> >the running thread will no longer see the updated page tables.
> >
> 
> I think I was hitting that exact problem with multiple copies
> not getting updated. The section_update code was being called
> and I was seeing the tables get updated but nothing was being
> applied when I tried to write to text or check the debugfs
> page table. The current flow is:
> 
> rest_init -> kernel_thread(kernel_init) and from that thread
> mark_rodata_ro. So mark_rodata_ro is always going to happen
> in a thread.
> 
> Do we need to update for both init_mm and the first running
> thread?

The "first running thread" is merely coincidental for things like kexec.

Hmm.  Actually, I think the existing code _should_ be fine.  At the
point where mark_rodata_ro() is, we should still be using init_mm, so
updating the current threads page tables should actually be updating
the swapper_pg_dir.

The other cases (kexec and ftrace) I think are also fine as they
stand - we want to be changing the currently active page tables
there.

So, I really think we do not want to be using pgd_offset_k() here at
all - but we need to find out what's changed to cause (presumably)
mark_rodata_ro() not to be hitting the swapper page tables.  Maybe
some debug in mark_rodata_ro() to find out what current->mm is?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
