From: Michael.McTernan.2001@cs.bris.ac.uk (Michael McTernan)
Date: Tue, 05 Nov 2013 22:43:15 +0000
Subject: mm: get_user_pages_fast()
Message-ID: <52797483.2000105@cs.bris.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I think there's a problem on ARM with futex calls to FUTEX_WAIT and 
similar for addresses that have been mapped to userspace from /dev/mem 
or a device which sets VM_IO or VM_PFNMAP.  This can break 
pthread_mutex_lock() if placed on such mapped memory and attributed as 
process-shared.

The cause looks to be that ARM doesn't yet implement 
get_user_pages_fast(), which is called in get_futex_key() for a 
non-process private futex.

On ARM the weak wrapper function in mm/util.c is used as a compatibility 
fallback.  This fallback takes the mm->mmap_sem lock, and calls through 
to get_user_pages().  Unfortunately get_user_pages() then returns 
-EFAULT for pages marked with VM_IO | VM_PFNMAP set.  Memory which has 
been mapped to userspace through /dev/mem is correctly flagged in this 
way.

get_user_pages_fast() on other architectures, as implemented in 
arch/.../gup.c doesn't appear have the same checks for VM_IO or 
VM_PFNMAP, so futex functionality can work.

Implementing get_user_pages_fast() to the same spec on ARM should fix 
this.  The weak get_user_pages_fast() may then also need fixing or 
eventually removing since its behaviour isn't the same as 
get_user_pages_fast() in all cases and may be causing bugs where it us 
used.  Bugs in locking are not very nice.

I've seen a couple of patches go by that provide get_user_pages_fast() 
on ARM, but none yet accepted.  I therefore would like to highlight this 
particular case for context, and also to perhaps generate some movement 
on this issue, which I also reported here:

https://bugzilla.kernel.org/show_bug.cgi?id=64321

For reference, here are some previous patches and discussion on adding 
this function:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/162115.html
https://lkml.org/lkml/2013/10/3/529
http://patches.linaro.org/21130/

Kind Regards,

Mike
