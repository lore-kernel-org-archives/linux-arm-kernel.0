From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Feb 2014 12:17:45 +0100
Subject: [PATCH 1/2] arm64: Add seccomp support
In-Reply-To: <201402121205.10802.arnd@arndb.de>
References: <1391767892-5395-1-git-send-email-takahiro.akashi@linaro.org>
 <CAB5YjtB6XnXRd90AUw=rJCOBKyfcngTQd3Kxft33XLCK+K=Vuw@mail.gmail.com>
 <201402121205.10802.arnd@arndb.de>
Message-ID: <201402121217.45763.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014, Arnd Bergmann wrote:
> 
> On Wednesday 12 February 2014, Takahiro Akashi wrote:
> > Thank you for your comment.
> > I'm afraid that I can't do so because how compat syscall numbers
> > are named varies from arch to arch. __NR_compat_read is used
> > only on arm64, while __NR_ia32_read on x86. On other archs,
> > __NR_read is common to 32-bit and 64-bit tasks.
> 
> It's fine, I'm the maintainer for asm-generic ;-)
> 
> All future architectures are required to do it the same way as
> arm64 and use the generic syscall ABI. It just means we won't be
> able to share this header with x86 or other architectures that
> use a nonstandard string. We should have it in the generic place
> even if arm64 is the only user for now.
> 

Ok, I was wrong. The generic header file should only be used for
architectures on which both ABIs use the generic syscall numbers,
and arm64 obviously doesn't do that for arm32 compatibility.

The proper generic header file should contain

#if defined(CONFIG_COMPAT) && !defined(__NR_seccomp_read_32)
#define __NR_seccomp_read_32           __NR_read
#define __NR_seccomp_write_32          __NR_write
#define __NR_seccomp_exit_32           __NR_exit
#define __NR_seccomp_sigreturn_32      __NR_rt_sigreturn
#endif /* CONFIG_COMPAT && ! already defined */

#define __NR_seccomp_read              __NR_read
#define __NR_seccomp_write             __NR_write
#define __NR_seccomp_exit              __NR_exit
#define __NR_seccomp_sigreturn         __NR_rt_sigreturn

and then have arm64 override the first four by defining its
own. I would still prefer having it done this way, but it actually
doesn't gain us that much since this default wouldn't work on
any 64-bit architecture currently implementing seccomp. I'll leave
it up to you whether you want to do it or not.

	Arnd
