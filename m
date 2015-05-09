From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 May 2015 10:32:37 +0100
Subject: Bulid regression with VDSO enabled
In-Reply-To: <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
References: <391d6fc127b78ef4cbc5443557f0665a@agner.ch>
 <554CD5F8.10901@mentor.com>
 <983cc33a8e5704f4281a7d30bbc9d1d2@agner.ch>
Message-ID: <20150509093237.GN2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 06:08:11PM +0200, Stefan Agner wrote:
> However, so far LD=${CROSS_COMPILE}ld.bfc seems to work for other build
> objects, at least those do not have this note. For instance time.o does
> not return anything:
> 
> $ readelf -n arch/arm/kernel/time.o
> 
> So it seems to be a vdso.so.raw specific problem not using the specified
> linker...?

Remember that most of the kernel source is about building the kernel,
where we explicitly call the linker directly.

This is about building a user visible object, and we go through the
compiler front end for that.

My only worry is if we were to pick up (eg) libgcc.so* as a dependency,
but that's highly unlikely to go unnoticed if it were to happen, as my
cross-toolchain doesn't have libgcc.so available. ;)

Given that there's gold out there which doesn't work for the VDSO, I
think the solution Nathan has come up with in his reply to your email
is the best resolution to this.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
