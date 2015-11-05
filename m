From: labbott@redhat.com (Laura Abbott)
Date: Thu, 5 Nov 2015 08:20:42 -0800
Subject: [PATCH] arm: Use kernel mm when updating section permissions
In-Reply-To: <20151105094615.GP8644@n2100.arm.linux.org.uk>
References: <1446685239-28522-1-git-send-email-labbott@fedoraproject.org>
 <20151105094615.GP8644@n2100.arm.linux.org.uk>
Message-ID: <563B81DA.2080409@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 01:46 AM, Russell King - ARM Linux wrote:
> On Wed, Nov 04, 2015 at 05:00:39PM -0800, Laura Abbott wrote:
>> Currently, read only permissions are not being applied even
>> when CONFIG_DEBUG_RODATA is set. This is because section_update
>> uses current->mm for adjusting the page tables. current->mm
>> need not be equivalent to the kernel version. Use pgd_offset_k
>> to get the proper page directory for updating.
>
> What are you trying to achieve here?  You can't use these functions
> at run time (after the first thread has been spawned) to change
> permissions, because there will be multiple copies of the kernel
> section mappings, and those copies will not get updated.
>
> In any case, this change will probably break kexec and ftrace, as
> the running thread will no longer see the updated page tables.
>

I think I was hitting that exact problem with multiple copies
not getting updated. The section_update code was being called
and I was seeing the tables get updated but nothing was being
applied when I tried to write to text or check the debugfs
page table. The current flow is:

rest_init -> kernel_thread(kernel_init) and from that thread
mark_rodata_ro. So mark_rodata_ro is always going to happen
in a thread.

Do we need to update for both init_mm and the first running
thread?

Thanks,
Laura
