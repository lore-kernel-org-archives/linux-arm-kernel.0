From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 Mar 2015 13:47:36 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
In-Reply-To: <550025E0.7030008@suse.de>
References: <1417707993-82290-1-git-send-email-agraf@suse.de>
 <20141208101026.GD27367@arm.com> <550025E0.7030008@suse.de>
Message-ID: <5396604.TRferrWZgF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 11 March 2015 06:24:16 Alexander Graf wrote:
> So after recompiling all of the distribution with newer binutils we now
> have an openSUSE Factory tree that has 64k aligned 32bit binaries.
> 
> Unfortunately however, the 32bit glibc has a bogus mmap() implementation
> that hard codes 4k page size.
> 
> With the patch below applied to glibc, I can successfully run 32bit user
> space on Seattle with 64k PAGE_SIZE though. So I guess we'll need to fix
> up glibc next.
> 
> Do you know of anyone who's fluent enough in 32bit ARM assembly to
> convert the hard coded assumptions in there to instead use a variable
> that takes the actual host page size into account?

I believe this is a kernel bug, and the kernel API for 32-bit emulation
should always take the pgoff argument in 4KB units instead of PAGE_SIZE
units, see the implementation of sys_mmap2 in
arch/powerpc/kernel/sys_ppc32.c.

All user space programs that call mmap2 still need to make sure that
their arguments are PAGE_SIZE aligned, but the libc need not care
about this here.

	Arnd
