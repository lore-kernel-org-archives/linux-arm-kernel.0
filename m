From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 17:30:06 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <mvm4mcrtski.fsf@hawking.suse.de>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <208897488.c0hkBy2G1S@wuerfel> <mvm4mcrtski.fsf@hawking.suse.de>
Message-ID: <2753057.uyT99zxyCM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 17:00:29 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > In https://github.com/norov/glibc/commit/5d4290435e428267171ece871539b76e1d079d11
> > you are defining a struct __kernel_stat64 in the glibc. Is this the expected
> > way to do it? I would have thought you'd get the definition from the kernel
> > headers.
> 
> The problem really is that struct stat64 does not match the kernel
> struct stat64.  The latter uses the broken st_ino, where the 64-bit
> inode is actually stored at the end of the structure, and there is
> padding *before* the 32-bit inode, not after (so you cannot overlay a
> 64-bit inode field in little endian mode).  You need to add the attached
> file as sysdeps/unix/sysv/linux/aarch64/bits/stat.h, then you can use
> the user-space struct stat64 to communicate with the *stat64 syscalls,
> and __kernel_stat64 is not needed any more.
> 

Ok, got it. So this is an unfortunate side-effect of using the same
'stat64' as arm32 does.

If it's really that broken, should we change the kernel (once more)
to use the layout of arm64 instead? That has the 64-bit time fields
though, so it might require similar hacks, unless we first merge
support for 64-bit time_t based syscalls (which seems unlikely
at this point, sorry for the delay on my end).

Is there possibly a way to reference the implementation that we
have for stat64 on arm32 rather than duplicating it?

	Arnd
