From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Aug 2016 11:47:52 +0100
Subject: [PATCH] arm64: Introduce execute-only page access permissions
In-Reply-To: <CAGXu5jJTuJ+k948BU4rDGF=tHv54TR0JQVTbcVvzp=NtfQrL9Q@mail.gmail.com>
References: <1470937490-7375-1-git-send-email-catalin.marinas@arm.com>
 <CAGXu5jJTuJ+k948BU4rDGF=tHv54TR0JQVTbcVvzp=NtfQrL9Q@mail.gmail.com>
Message-ID: <20160815104751.GC22320@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2016 at 11:23:03AM -0700, Kees Cook wrote:
> On Thu, Aug 11, 2016 at 10:44 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > The ARMv8 architecture allows execute-only user permissions by clearing
> > the PTE_UXN and PTE_USER bits. However, the kernel running on a CPU
> > implementation without User Access Override (ARMv8.2 onwards) can still
> > access such page, so execute-only page permission does not protect
> > against read(2)/write(2) etc. accesses. Systems requiring such
> > protection must enable features like SECCOMP.
> 
> So, UAO CPUs will bypass this protection in userspace if using
> read/write on a memory-mapped file?

It's the other way around. CPUs prior to ARMv8.2 (when UAO was
introduced) or with the CONFIG_ARM64_UAO disabled can still access
user execute-only memory regions while running in kernel mode via the
copy_*_user, (get|put)_user etc. routines. So a way user can bypass this
protection is by using such address as argument to read/write file
operations.

I don't think mmap() is an issue since such region is already mapped, so
it would require mprotect(). As for the latter, it would most likely be
restricted (probably together with read/write) SECCOMP.

> I'm just trying to make sure I understand the bypass scenario. And is
> this something that can be fixed? If we add exec-only, I feel like it
> shouldn't have corner case surprises. :)

I think we need better understanding of the usage scenarios for
exec-only. IIUC (from those who first asked me for this feature), it is
an additional protection on top of ASLR to prevent an untrusted entity
from scanning the memory for ROP/JOP gadgets. An instrumented compiler
would avoid generating the literal pool in the same section as the
executable code, thus allowing the instructions to be mapped as
executable-only. It's not clear to me how such untrusted code ends up
scanning the memory, maybe relying on other pre-existent bugs (buffer
under/overflows). I assume if such code is allowed to do system calls,
all bets are off already.

-- 
Catalin
