From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Aug 2012 07:56:30 +0000
Subject: [PATCH v2 17/31] arm64: System calls handling
In-Reply-To: <20120821220145.GA27934@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <201208212014.01837.arnd@arndb.de> <20120821220145.GA27934@arm.com>
Message-ID: <201208220756.31149.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 August 2012, Catalin Marinas wrote:
> As I understand, sys_mmap_pgoff can be used instead of sys_mmap2 on new
> 32-bit architectures. But on 64-bit architectures we don't have
> sys_mmap2, only sys_mmap with the difference that the last argument is
> the offset in bytes (and multiple of PAGE_SIZE) rather than in pages. So
> unless we change the meaning of this last argument for sys_mmap, we
> cannot just define it to sys_mmap_pgoff.
> 
> Since the other 64-bit architectures seem to have a sys_mmap wrapper
> that does this:
> 
>         sys_mmap_pgoff(..., off >> PAGE_SHIFT);
> 
> I think AArch64 should also use the same sys_mmap convention. We can
> make this wrapper generic.

But the wrapper can just as well be part of glibc, which already has
one. There is no reason for the kernel to export two generic interfaces
for mmap when one of them only works on 64 bit and the other one is
good for both 32 and 64 bit.

All the other 64 bit architectures (besides tile) were added to the
kernel before we had sys_mmap_pgoff.

	Arnd
