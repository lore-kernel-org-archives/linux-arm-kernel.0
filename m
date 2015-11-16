From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 12:40:35 +0100
Subject: [PATCH v6 13/17] arm64:ilp32: add sys_ilp32.c and a separate
 table (in entry.S) to use it
In-Reply-To: <alpine.DEB.2.10.1511161109130.25844@digraph.polyomino.org.uk>
References: <1446507046-24604-1-git-send-email-ynorov@caviumnetworks.com>
 <4814795.z9jdqoW8IP@wuerfel>
 <alpine.DEB.2.10.1511161109130.25844@digraph.polyomino.org.uk>
Message-ID: <4389139.prTLIyjV9Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 November 2015 11:12:08 Joseph Myers wrote:
> On Mon, 16 Nov 2015, Arnd Bergmann wrote:
> 
> > Let's not get into the tv_nsec discussion today, that is not thankfully
> > not relevant for arm64 any more at this point. The system call ABI for
> > arm64/ilp32 is now the same as for any other 32-bit architecture using
> > the generic ABI, the question we're trying to solve here is only whether it
> > is ok for new 32-bit glibc ports to only offer a 64-bit off_t as the kernel
> > currently does (using __kernel_loff_t) or if we still need to support the
> > _FILE_OFFSET_BITS=32 case.
> > 
> > If I got you right, we can use 64-bit off_t now, so we just need someone
> > to figure out how to make that the default in glibc for new architectures
> > while keeping the existing 32-bit architectures unchanged.
> 
> It would be an entirely new combination.  Presumably such a port would 
> want the "function X is an alias of function Y" aspects of wordsize-64 
> directories (where that relates to off_t, struct stat etc. as opposed to 
> long and long long), and the "registers are 64-bit so 64-bit operations 
> are efficient" aspects, but not all the "64-bit syscall interface" 
> aspects, so someone would need to review wordsize-64 sysdeps files and 
> figure out what is or is not relevant to this port.

There are two separate aspects here:

a) leave out the support for all __off_t based syscalls (__ftruncate,
   __lseek, __lxstat, __pread, __preadv, __pwrite, __pwritev, __truncate,
   __xstat) as they are no longer needed, and change the handling of
   _FILE_OFFSET_BITS so that we default to 64 and error out for anything
   else.
   This needs to be done for all new 32-bit architectures if you think we
   should use a 64-bit off_t from now on, it's not arm64 specific.

b) For an arbitrary subset of these, introduce optimized versions that
   are architecture specific and take advantage of the fact that we can
   pass 64-bit register arguments on arm64-ilp32.
   This is only needed because we diverge from the generic ABI in order
   to avoid the silliness of splitting up a 64-bit argument and then
   re-assembling it in the kernel.
   This should not be needed in the generic ABI and could just live in
   sysdeps/unix/sysv/linux/aarch64/wordsize-32, just like we have
   special handling for each one in the arm64 in the kernel code for them.

	Arnd
