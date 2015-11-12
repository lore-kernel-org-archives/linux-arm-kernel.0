From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 10:22 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <mvmoaezy4os.fsf@hawking.suse.de>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <10433819.KzDuoxzSn7@wuerfel> <mvmoaezy4os.fsf@hawking.suse.de>
Message-ID: <4796230.MStNPjWNEu@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 09:58:43 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > I think either way is fine for the two examples. I think it's clear
> > that we want __NR_llseek as 62 and __NR_mmap2 as 222. Whether those
> > use the compat_sys_llseek/compat_sys_mmap2_wrapper or
> > sys_lseek/sys_mmap entry points is not overly important, we can use
> > whatever is more convenient to glibc: if we can kill off an
> > architecture specific wrapper function in glibc by adding one line
> > to the kernel, that seems worthwhile.
> 
> Currently most off_t-like syscalls need a new glibc wrapper since the
> existing ones are either for 32bit off_t+off64_t (with split off64_t
> syscall arguments) or pure 64bit off_t architectures.  Since ilp32 now
> (mostly) has 32bit off_t, but 64bit off_t-like syscalls neither of them
> fit.

What do you mean with 32-bit off_t? Do you mean that glibc emulates
a 32-bit off_t on top of the 64-bit __kernel_loff_t? That sounds a bit
backwards. I would expect that all new architectures that only have
__kernel_loff_t based syscalls but not __kernel_off_t based ones only
ever use a 64-bit off_t in libc.

	Arnd
