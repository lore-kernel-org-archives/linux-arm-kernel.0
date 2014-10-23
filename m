From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Oct 2014 15:14:15 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <3595731.DoMBPMAkQj@wuerfel>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <20141022223845.GE27405@n2100.arm.linux.org.uk>
 <3595731.DoMBPMAkQj@wuerfel>
Message-ID: <20141023141415.GJ27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 03:57:44PM +0200, Arnd Bergmann wrote:
> On Wednesday 22 October 2014 23:38:45 Russell King - ARM Linux wrote:
> > So, size_t is typedef'd as "unsigned int" - and indeed, the compiler thinks
> > that size_t is "unsigned int".  But it doesn't seem to like the use of the
> > 'z' flag in the printf format string with size_t.
> > 
> > Any ideas what's going on here?  Does gcc 4.9 stddef.h define size_t
> > differently?
> 
> This may be a related issue to the first one. Maybe the linux toolchain uses
> a different type from the generic toolchain. 

Please re-read.

Olof's 4.9 toolchain is the one which spat out these errors.

Olof's 4.9 toolchain defines __SIZE_TYPE__ to "unsigned int".  I asked
Olof to verify this via:

$ echo __SIZE_TYPE__ | arm-linux-gcc -E -o - -xc -

which Olof said produces "unsigned int".

Userspace typedefs size_t to __SIZE_TYPE__ which is "unsigned int".  Ergo,
in userspace, size_t is typedef'd from "unsigned int".

The kernel typedefs __kernel_size_t to "unsigned int", which is then
used to typedef the kernel size_t to __kernel_size_t.  Ergo, size_t in
the kernel is "unsigned int".

In the kernel, passing a variable with type size_t to a format with
"%zu", results in Olof's 4.9 toolchain complaining that the format
takes a size_t type, but GCC claims the variable passed was of type
"unsigned int" not "size_t".

Why?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
