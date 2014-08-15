From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Aug 2014 14:55:20 +0100
Subject: [PATCH 2/2] asm-generic: add memfd_create system call to unistd.h
In-Reply-To: <20140812123736.GA16961@redhat.com>
References: <1407764228-7904-1-git-send-email-will.deacon@arm.com>
 <CANq1E4Q0gDaJ5XGnkoCQsG8xLh1Q-EBErtEVPpeeZgGj+Nr8dQ@mail.gmail.com>
 <20140811171511.GF8828@arm.com> <201408112057.01177.arnd@arndb.de>
 <CAMuHMdWZ30ZKO2ddh8whmw5ThrKZC0wsU+rhgoc8fRZni0Zduw@mail.gmail.com>
 <20140812102734.GG29013@arm.com> <20140812111030.GK29013@arm.com>
 <20140812123736.GA16961@redhat.com>
Message-ID: <20140815135520.GT27466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 12, 2014 at 01:37:36PM +0100, Vivek Goyal wrote:
> On Tue, Aug 12, 2014 at 12:10:30PM +0100, Will Deacon wrote:
> > Hmm, so whilst I can easily wire-up the new syscall, it's pretty useless for
> > anybody other than x86 at the moment. There are a bunch of arch helpers:
> > 
> >  arch_kexec_kernel_image_probe
> >  arch_kexec_kernel_verify_sig
> >  arch_kexec_kernel_image_load
> >  arch_kimage_file_post_load_cleanup
> > 
> > which are only implemented for x86 (arch/x86/kernel/machine_kexec_64.c),
> > even though I don't really see what makes them arch-specific as opposed to
> > file format specific.
> 
> Yes, at this point of time, this system call will work only on x86. Agreed
> that primarily it is file format details which are primarily in arch
> specific section.
> 
> I think that some of the code will become arch independent as other
> arches start implementing this syscall. 
> 
> > 
> > So this syscall will always fail with -ENOEXEC at the moment. Is it still
> > worth wiring it up?
> 
> I thought that for other arches I have not even defined the syscall. So
> it probably will fail with -ENOSYS.

What I meant was, if I wire it into asm-generic/unistd.h then it will return
-ENOEXEC for architectures using that file (e.g. arm64).

Patch below, but I don't think it's very useful.

Will

--->8

commit a20104072c8faeeacb2857ce24cdb2818f51ff1a
Author: Will Deacon <will.deacon@arm.com>
Date:   Mon Aug 11 14:24:47 2014 +0100

    asm-generic: add kexec_file_load system call to unistd.h
    
    Commit cb1052581e2b ("kexec: implementation of new syscall
    kexec_file_load") added a new system call (kexec_file_load) but didn't
    update the asm-generic unistd header.
    
    This patch adds the new system call to the asm-generic version of
    unistd.h so that it can be used by architectures such as arm64. Note
    that without the arch_kexec hooks, all file formats will result in
    -ENOEXEC.
    
    Cc: Arnd Bergmann <arnd@arndb.de>
    Cc: Vivek Goyal <vgoyal@redhat.com>
    Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 11d11bc5c78f..92ae121fa055 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -705,9 +705,11 @@ __SYSCALL(__NR_seccomp, sys_seccomp)
 __SYSCALL(__NR_getrandom, sys_getrandom)
 #define __NR_memfd_create 279
 __SYSCALL(__NR_memfd_create, sys_memfd_create)
+#define __NR_kexec_file_load 280
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
 
 #undef __NR_syscalls
-#define __NR_syscalls 280
+#define __NR_syscalls 281
 
 /*
  * All syscalls below here should go away really,
