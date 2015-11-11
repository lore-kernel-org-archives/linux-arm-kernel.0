From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 00:23:43 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <87k2pojfsy.fsf@igel.home>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <20577001.4Nl3YnQ8k2@wuerfel> <87k2pojfsy.fsf@igel.home>
Message-ID: <10433819.KzDuoxzSn7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 November 2015 00:07:41 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > On Wednesday 11 November 2015 18:54:00 Andreas Schwab wrote:
> >> Yury Norov <ynorov@caviumnetworks.com> writes:
> >> 
> >> > +#define sys_clock_gettime       compat_sys_clock_gettime
> >> > +#define sys_clock_settime       compat_sys_clock_settime
> >> 
> >> You also need to redirect sys_clock_nanosleep.
> >
> > Note that based on my comment, that table would be turned around, and
> > only the syscalls get overridden that do not have the normal
> > compat mode behavior (mostly the ones that pass a 64-bit register).
> 
> Is it intented that _all_ off_t-like syscalls are implemented by the
> 64bit variants?  Currently, this isn't fully implemented (lseek is
> implemented by sys_llseek and mmap by an mmap2 wrapper).

I think either way is fine for the two examples. I think it's clear
that we want __NR_llseek as 62 and __NR_mmap2 as 222. Whether those
use the compat_sys_llseek/compat_sys_mmap2_wrapper or
sys_lseek/sys_mmap entry points is not overly important, we can use
whatever is more convenient to glibc: if we can kill off an
architecture specific wrapper function in glibc by adding one line
to the kernel, that seems worthwhile.

It's a bit confusing, because user space off_t matches the kernel's
off_t, loff_t, but not the __kernel_off_t from the uapi headers.

	Arnd
