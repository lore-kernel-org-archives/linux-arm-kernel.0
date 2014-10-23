From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Oct 2014 17:12:20 +0100
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <5876859.V209eoUfHk@wuerfel>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <3595731.DoMBPMAkQj@wuerfel>
 <20141023141415.GJ27405@n2100.arm.linux.org.uk>
 <5876859.V209eoUfHk@wuerfel>
Message-ID: <20141023161220.GK27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 23, 2014 at 05:33:52PM +0200, Arnd Bergmann wrote:
> I was thinking of the case where gcc's internal code for printf format
> checking doesn't match the definition of size_t. It's possible that this
> is different from the type that is defined in stddef.h.
> 
> FWIW, the stddef.h that comes with my gcc-4.9 contains
> 
> #define __SIZE_TYPE__ long unsigned int
> 
> but the command
> 
> $ echo __SIZE_TYPE__ | arm-linux-gcc -E -o - -xc -
> 
> also returns "unsigned int" when running through the compiler that
> comes with this header.

Right, because the command version of __SIZE_TYPE__ is picking up the
value which gcc itself defines.  The #define in stddef.h is only used
if the compiler doesn't already define __SIZE_TYPE__ (as it's surrounded
with #ifndef __SIZE_TYPE__.)

> I haven't found the code in gcc that performs the type check for
> printf, but I've found a comment about that code intentionally
> resolving the type (printing 'unsigned int') when the typedef
> does not match the expected type.

If I had a copy of the GCC 4.9 source locally, I'd dig into it too and
try to work out what's going on.  My gut feeling is that it's a bug in
GCC rather than something which the kernel is doing wrong.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
