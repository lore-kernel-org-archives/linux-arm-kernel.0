From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Aug 2016 17:18:24 +0100
Subject: [PATCH] arm64: Introduce execute-only page access permissions
In-Reply-To: <CAGXu5jJTeta2OnL8KKHesG_HdeCvcXtaqjAir1cUvyfivaQeuQ@mail.gmail.com>
References: <1470937490-7375-1-git-send-email-catalin.marinas@arm.com>
 <CAGXu5jJTuJ+k948BU4rDGF=tHv54TR0JQVTbcVvzp=NtfQrL9Q@mail.gmail.com>
 <20160815104751.GC22320@e104818-lin.cambridge.arm.com>
 <CAGXu5jJTeta2OnL8KKHesG_HdeCvcXtaqjAir1cUvyfivaQeuQ@mail.gmail.com>
Message-ID: <20160816161824.GB7609@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 10:45:09AM -0700, Kees Cook wrote:
> On Mon, Aug 15, 2016 at 3:47 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 12, 2016 at 11:23:03AM -0700, Kees Cook wrote:
> >> On Thu, Aug 11, 2016 at 10:44 AM, Catalin Marinas
> >> <catalin.marinas@arm.com> wrote:
> >> > The ARMv8 architecture allows execute-only user permissions by clearing
> >> > the PTE_UXN and PTE_USER bits. However, the kernel running on a CPU
> >> > implementation without User Access Override (ARMv8.2 onwards) can still
> >> > access such page, so execute-only page permission does not protect
> >> > against read(2)/write(2) etc. accesses. Systems requiring such
> >> > protection must enable features like SECCOMP.
> >>
> >> So, UAO CPUs will bypass this protection in userspace if using
> >> read/write on a memory-mapped file?
> >
> > It's the other way around. CPUs prior to ARMv8.2 (when UAO was
> > introduced) or with the CONFIG_ARM64_UAO disabled can still access
> > user execute-only memory regions while running in kernel mode via the
> > copy_*_user, (get|put)_user etc. routines. So a way user can bypass this
> > protection is by using such address as argument to read/write file
> > operations.
> 
> Ah, okay. So exec-only for _userspace_ will always work, but exec-only
> for _kernel_ will only work on ARMv8.2 with CONFIG_ARM64_UAO?

Yes (mostly). With UAO, we changed the user access routines in the
kernel to use the LDTR/STTR instructions which always behave
unprivileged even when executed in kernel mode (unless the UAO bit is
set to override this restriction, needed for set_fs(KERNEL_DS)).

Even with UAO, we still have two cases where the kernel cannot perform
unprivileged accesses (LDTR/STTR) since they don't have an exclusives
equivalent (LDXR/STXR). These are in-user futex atomic ops and the SWP
emulation for 32-bit binaries (armv8_deprecated.c). But these require
write permission, so they would always fault even when running in the
kernel. futex_atomic_cmpxchg_inatomic() is able to return the old value
without a write (if it differs from "oldval") but it doesn't look like
such value could leak to user space.

-- 
Catalin
