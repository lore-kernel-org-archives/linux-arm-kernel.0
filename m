From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Jan 2012 10:01:54 +0000
Subject: [PATCH 4/7] Store huge page linux pte in mm_struct
In-Reply-To: <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-5-git-send-email-bill4carson@gmail.com>
Message-ID: <20120131100154.GC889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 03:57:15PM +0800, bill4carson at gmail.com wrote:
> From: Bill Carson <bill4carson@gmail.com>
> 
> One easy way to store huge page linux pte is mm_struct instead of thread_info
> that's because when parent task with huge page VMA calls fork, parent huge page
> pagetable entries are copied into child pagetable. This is done in
> 
> int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> 			    struct vm_area_struct *vma)
> 
> We cannot derive child's thread_info just using struct mm_struct *dst.
> if we have struct mm_struct **dst, then it's easy to find the corresponding
> task_struct as well as thread_info, but we only get struct mm_struct *dst.
> It's possible to find the desired task_struct by iterating the global task list
> by comparing task_struct->mm with dst.
> So mm_struct is used for huge page linux pte for faster lookup and efficient.

I really do not understand this description, and it doesn't seem to tie
up with the code.  What problem are you trying to solve here?

Note that a mm_struct can be shared between multiple task_structs, so
if your thinking is that something in the mm_struct or page table needs
to know about a task_struct, you're ideas are wrong.
