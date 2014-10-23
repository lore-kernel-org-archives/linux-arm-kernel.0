From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Oct 2014 17:33:52 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <20141023141415.GJ27405@n2100.arm.linux.org.uk>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <3595731.DoMBPMAkQj@wuerfel> <20141023141415.GJ27405@n2100.arm.linux.org.uk>
Message-ID: <5876859.V209eoUfHk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 October 2014 15:14:15 Russell King - ARM Linux wrote:
> On Thu, Oct 23, 2014 at 03:57:44PM +0200, Arnd Bergmann wrote:
> > On Wednesday 22 October 2014 23:38:45 Russell King - ARM Linux wrote:
> > > So, size_t is typedef'd as "unsigned int" - and indeed, the compiler thinks
> > > that size_t is "unsigned int".  But it doesn't seem to like the use of the
> > > 'z' flag in the printf format string with size_t.
> > > 
> > > Any ideas what's going on here?  Does gcc 4.9 stddef.h define size_t
> > > differently?
> > 
> > This may be a related issue to the first one. Maybe the linux toolchain uses
> > a different type from the generic toolchain. 
> 
> Please re-read.
> 
> Olof's 4.9 toolchain is the one which spat out these errors.
> 
> Olof's 4.9 toolchain defines __SIZE_TYPE__ to "unsigned int".  I asked
> Olof to verify this via:
> 
> $ echo __SIZE_TYPE__ | arm-linux-gcc -E -o - -xc -
> 
> which Olof said produces "unsigned int".
> 
> Userspace typedefs size_t to __SIZE_TYPE__ which is "unsigned int".  Ergo,
> in userspace, size_t is typedef'd from "unsigned int".
> 
> The kernel typedefs __kernel_size_t to "unsigned int", which is then
> used to typedef the kernel size_t to __kernel_size_t.  Ergo, size_t in
> the kernel is "unsigned int".
> 
> In the kernel, passing a variable with type size_t to a format with
> "%zu", results in Olof's 4.9 toolchain complaining that the format
> takes a size_t type, but GCC claims the variable passed was of type
> "unsigned int" not "size_t".

I was thinking of the case where gcc's internal code for printf format
checking doesn't match the definition of size_t. It's possible that this
is different from the type that is defined in stddef.h.

FWIW, the stddef.h that comes with my gcc-4.9 contains

#define __SIZE_TYPE__ long unsigned int

but the command

$ echo __SIZE_TYPE__ | arm-linux-gcc -E -o - -xc -

also returns "unsigned int" when running through the compiler that
comes with this header.

I haven't found the code in gcc that performs the type check for
printf, but I've found a comment about that code intentionally
resolving the type (printing 'unsigned int') when the typedef
does not match the expected type.

	Arnd
