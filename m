From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Mar 2016 23:39:48 +0200
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <alpine.DEB.2.10.1603292051150.15654@digraph.polyomino.org.uk>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <3398301.sy99ksJOyc@wuerfel>
 <alpine.DEB.2.10.1603292051150.15654@digraph.polyomino.org.uk>
Message-ID: <5332965.FKfI1zIepV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 March 2016 21:00:56 Joseph Myers wrote:
> On Tue, 29 Mar 2016, Arnd Bergmann wrote:
> 
> > > I think so (along with using wordsize-64 sysdeps directories as far as 
> > > possible, like x32 does).  But design questions for a glibc port really 
> > > belong on libc-alpha to get any sort of community consensus.
> > 
> > I thought the wordsize-64 stuff was for the x86 mode where they
> > define __kernel_long_t as 64-bit. We don't really want to do that in
> > the kernel for new 32-bit architectures, that would make the kernel
> > ABI different from all the existing architectures.
> 
> In general the wordsize-64 directories cover various relations of the form 
> "function X is an alias for function Y", which derive from "type X is 
> ABI-compatible with type Y".  (Unfortunately, the precise set isn't 
> well-defined, resulting in problems for cases that want a subset of those 
> relations - e.g. MIPS n64 where struct stat and struct stat64 are 
> different, and so sysdeps/unix/sysv/linux/wordsize-64 isn't used.)

For all new 32-bit architectures like this, the kernel should at least
behave in a consistent way, but it's somewhere inbetween wordsize-32 and
wordsize-64 for 32-bit architectures, because off_t and ino_t are mapped
to the 64-bit __kernel_loff_t and __kernel_ino_t, while time_t, clock_t
and size_t are mapped to 32 bit types.

> The person doing the port will need to do a detailed review of the exact 
> effects of the wordsize-64 directories in current glibc, and which of 
> those effects are appropriate for this port, to determine what is 
> appropriate, and to include that analysis with the port submission.

I think the analysis will have to be about two separate things:

* Whether new 32-bit architectures in general should use wordsize-32
  or wordsize-64 or something else, based on what you write above.
  I would still guess that we are better off adapting wordsize-32
  to the current kernel ABI for 32-bit architectures while leaving
  wordsize-64 to real 64-bit architectures and x86/x32.

* How we deal with the special case of this architecture having
  nonstandard calling conventions for a couple of syscalls that
  take 64-bit arguments in a single register rather than two registers
  as every other 32-bit architecture does.

	Arnd
