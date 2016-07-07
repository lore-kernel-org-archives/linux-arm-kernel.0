From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Thu, 7 Jul 2016 09:30:07 +0200
Subject: [PATCH 0/9] mm: Hardened usercopy
In-Reply-To: <1467843928-29351-1-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
Message-ID: <577E04FF.1090000@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/2016 12:25 AM, Kees Cook wrote:
> Hi,
> 
> This is a start of the mainline port of PAX_USERCOPY[1]. After I started
> writing tests (now in lkdtm in -next) for Casey's earlier port[2], I
> kept tweaking things further and further until I ended up with a whole
> new patch series. To that end, I took Rik's feedback and made a number
> of other changes and clean-ups as well.
> 
> Based on my understanding, PAX_USERCOPY was designed to catch a few
> classes of flaws around the use of copy_to_user()/copy_from_user(). These
> changes don't touch get_user() and put_user(), since these operate on
> constant sized lengths, and tend to be much less vulnerable. There
> are effectively three distinct protections in the whole series,
> each of which I've given a separate CONFIG, though this patch set is
> only the first of the three intended protections. (Generally speaking,
> PAX_USERCOPY covers what I'm calling CONFIG_HARDENED_USERCOPY (this) and
> CONFIG_HARDENED_USERCOPY_WHITELIST (future), and PAX_USERCOPY_SLABS covers
> CONFIG_HARDENED_USERCOPY_SPLIT_KMALLOC (future).)
> 
> This series, which adds CONFIG_HARDENED_USERCOPY, checks that objects
> being copied to/from userspace meet certain criteria:
> - if address is a heap object, the size must not exceed the object's
>   allocated size. (This will catch all kinds of heap overflow flaws.)
> - if address range is in the current process stack, it must be within the
>   current stack frame (if such checking is possible) or at least entirely
>   within the current process's stack. (This could catch large lengths that
>   would have extended beyond the current process stack, or overflows if
>   their length extends back into the original stack.)
> - if the address range is part of kernel data, rodata, or bss, allow it.
> - if address range is page-allocated, that it doesn't span multiple
>   allocations.
> - if address is within the kernel text, reject it.
> - everything else is accepted
> 
> The patches in the series are:
> - The core copy_to/from_user() checks, without the slab object checks:
> 	1- mm: Hardened usercopy
> - Per-arch enablement of the protection:
> 	2- x86/uaccess: Enable hardened usercopy
> 	3- ARM: uaccess: Enable hardened usercopy
> 	4- arm64/uaccess: Enable hardened usercopy
> 	5- ia64/uaccess: Enable hardened usercopy
> 	6- powerpc/uaccess: Enable hardened usercopy
> 	7- sparc/uaccess: Enable hardened usercopy

Was there a reason why you did not change s390?
