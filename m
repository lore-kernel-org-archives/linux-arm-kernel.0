From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 1 Nov 2010 15:23:15 +0100
Subject: Using non-Global mappings for kernel address space
Message-ID: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all.

For the purpose of performance evaluation of our KVM for ARM port, I
am interested in avoiding having to flush the TLB every time I switch
from the guest kernel to the host kernel and vice-versa. The only way
to accomplish this on ARMv6 would be to have non-Global mappings of
the host kernel address space using a separate ASID from that of the
guest kernel.

My general approach is outlined as follows:
 - Mark all pages and sections (except interrupt vector page) with
addr > TASK_SIZE as non-global
 - Set a special kernel reserved ASID at the same time of paging_init()
 - Defer setting the CP15 context id register until return from kernel
to userspace in ret_fast_syscall and ret_slow_syscall (ret_to_user)
 - Set the kernel reserved ASID as part of the vector_stub (and add a
little vector_stub code for the SWI handler for this purpose)
 - Modify the tlbflush.h functions so they  invalidate the requested
parts of the TLB matching the changes above. (Actually for testing
purposes, make all functions invalidate the entire TLB).

The problem is that with the above changes, the kernel seems to boot
just fine, but when it starts running user space processes, the system
eventually crashes with the messages:

"Kernel panic - not syncing: Attempted to kill init!
Rebooting in 5 seconds..<3>ARM9 has CRASHED"

While the mentioned modification probably affects the main kernel too
heavily to be accepted as part of any mainline KVM patch set it will
provide us with important hints about performance bottlenecks.

If anyone has pointers as to why I'm seeing this specific behavior or
have other suggestions as how to solve the address space conflict in
the TLB I would be very thankful.

The code is available at:
http://git.ncl.cs.columbia.edu/git/?p=linux-android-msm.git;a=shortlog;h=refs/heads/kvm-arm-2.6.29-host_asid_hack
and I attached the patch against my KVM tree for reference.

Thanks,
Christoffer
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm-Use-ASID-0-instead-of-global-mappings-for-TLB-in.patch
Type: application/octet-stream
Size: 11824 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101101/f3d06d4a/attachment-0001.obj>
