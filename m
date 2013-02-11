From: ivan.djelic@parrot.com (Ivan Djelic)
Date: Mon, 11 Feb 2013 20:42:25 +0100
Subject: [PATCH] [RFC] arm: fix memset-related crashes caused by recent
 GCC (4.7.2) optimizations
In-Reply-To: <20130211184114.GP9801@mudshark.cambridge.arm.com>
References: <1359793988-6881-1-git-send-email-ivan.djelic@parrot.com>
 <20130211184114.GP9801@mudshark.cambridge.arm.com>
Message-ID: <20130211194225.GK29329@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 06:41:14PM +0000, Will Deacon wrote:
> On Sat, Feb 02, 2013 at 08:33:08AM +0000, Ivan Djelic wrote:
> > Recent GCC versions (e.g. GCC-4.7.2) perform optimizations based on
> > assumptions about the implementation of memset and similar functions.
> > The current ARM optimized memset code does not return the value of
> > its first argument, as is usually expected from standard implementations.
> 
> How does GCC do this? By strcmping the function name and assuming that
> memset is a libc implementation?
> 
> If so, maybe passing something like -ffreestanding would make sense to turn
> this behaviour off in the compiler (otherwise we should also vet the rest of
> the standard string functions).

In theory, yes; but there is actually a short list of libc functions that GCC
always requires from the environment, even when -ffreestanding is used: memcpy,
memmove, memset and memcmp (see [1] below).

Which also means that the same corruption problem potentially exists for current
ARM assembly implementations of memcpy and memmove...

--
Ivan


[1] http://gcc.gnu.org/onlinedocs/gcc/Standards.html

  GCC aims towards being usable as a conforming freestanding
  implementation, or as the compiler for a conforming hosted
  implementation. By default, it will act as the compiler for a hosted
  implementation, defining __STDC_HOSTED__ as 1 and presuming that when
  the names of ISO C functions are used, they have the semantics defined
  in the standard. To make it act as a conforming freestanding
  implementation for a freestanding environment, use the option
  -ffreestanding; it will then define __STDC_HOSTED__ to 0 and not make
  assumptions about the meanings of function names from the standard
  library, with exceptions noted below. To build an OS kernel, you may
  well still need to make your own arrangements for linking and
  startup. See Options Controlling C Dialect.
  
  GCC does not provide the library facilities required only of hosted
  implementations, nor yet all the facilities required by C99 of
  freestanding implementations; to use the facilities of a hosted
  environment, you will need to find them elsewhere (for example, in the
  GNU C library). See Standard Libraries.
  
  Most of the compiler support routines used by GCC are present in
  libgcc, but there are a few exceptions. GCC requires the freestanding
  environment provide memcpy, memmove, memset and memcmp. Finally, if
  __builtin_trap is used, and the target does not implement the trap
  pattern, then GCC will emit a call to abort.
