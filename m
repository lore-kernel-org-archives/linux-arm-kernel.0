From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Nov 2014 14:41:53 +0000
Subject: [PATCH] ARM: kbuild: Fix forced rebuild after 'make dtbs'
In-Reply-To: <CACRpkdZJoWbQeuZ4ZXGbQr0+SNG_9ZA+cQkAA0C2F9rnZDYtyQ@mail.gmail.com>
References: <CACRpkdYmJWy1_vs0tWRA7SvkQnvbXXKqf7pHpH5b5tZ6vR+KJg@mail.gmail.com>
 <1414961549-31666-1-git-send-email-jason@lakedaemon.net>
 <5474F78F.2060906@suse.cz>
 <20141125235150.GH3836@n2100.arm.linux.org.uk>
 <20141126005710.GE22670@titan.lakedaemon.net>
 <CACRpkdZJoWbQeuZ4ZXGbQr0+SNG_9ZA+cQkAA0C2F9rnZDYtyQ@mail.gmail.com>
Message-ID: <20141126144153.GK3836@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 02:57:42PM +0100, Linus Walleij wrote:
> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> KBUILD_OUTPUT=build-u300 u300_defconfig
> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> KBUILD_OUTPUT=build-u300 zImage CONFIG_DEBUG_SECTION_MISMATCH=y
> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> KBUILD_OUTPUT=build-u300 dtbs
> make -f Makefile -j5 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> KBUILD_OUTPUT=build-u300 zImage CONFIG_DEBUG_SECTION_MISMATCH=y
> 
> -> Rebuilds everything.
> 
> This doesn't occur before the offending commit. So it only happens
> when specifying extra environment variables on the command line.

I suspect if you also provide the CONFIG_DEBUG_SECTION_MISMATCH=y on the
dtbs line, everything will work properly.

The problem is that dtbs line executes a prepare, which I guess rebuilds
the bounds stuff.  So, the dtbs target results in it being rebuilt without
the section mismatch, and then you re-execute a make with it, causing
the bounds stuff to be rebuilt again.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
