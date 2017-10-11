From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Oct 2017 23:58:06 +0100
Subject: [PATCH 00/11] KASan for arm
In-Reply-To: <4b7b2b3c-cba9-d8ab-72a7-119bd5fae65d@redhat.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <26660524-3b0a-c634-e8ce-4ba7e10c055d@gmail.com>
 <bb809843-4fb8-0827-170e-26efde0eb37f@gmail.com>
 <44c86924-930b-3eff-55b8-b02c9060ebe3@gmail.com>
 <4b7b2b3c-cba9-d8ab-72a7-119bd5fae65d@redhat.com>
Message-ID: <20171011225805.GY20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 03:10:56PM -0700, Laura Abbott wrote:
> On 10/11/2017 02:36 PM, Florian Fainelli wrote:
> >>   CC      arch/arm/boot/compressed/string.o
> >> arch/arm/boot/compressed/decompress.c:51:0: warning: "memmove" redefined
> >>  #define memmove memmove
> >>
> >> In file included from arch/arm/boot/compressed/decompress.c:7:0:
> >> ./arch/arm/include/asm/string.h:67:0: note: this is the location of the
> >> previous definition
> >>  #define memmove(dst, src, len) __memmove(dst, src, len)
> >>
> >> arch/arm/boot/compressed/decompress.c:52:0: warning: "memcpy" redefined
> >>  #define memcpy memcpy
> >>
> >> In file included from arch/arm/boot/compressed/decompress.c:7:0:
> >> ./arch/arm/include/asm/string.h:66:0: note: this is the location of the
> >> previous definition
> >>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
> >>
> > 
> > Was not able yet to track down why __memset is not being resolved, but
> > since I don't need them, disabled CONFIG_ATAGS and
> > CONFIG_ARM_ATAG_DTB_COMPAT and this allowed me to get a build working.
> > 
> > This brought me all the way to a prompt and please find attached the
> > results of insmod test_kasan.ko for CONFIG_ARM_LPAE=y and
> > CONFIG_ARM_LPAE=n. Your patches actually spotted a genuine use after
> > free in one of our drivers (spi-bcm-qspi) so with this:
> > 
> > Tested-by: Florian Fainelli <f.fainelli@gmail.com>
> > 
> > Great job thanks!
> > 
> 
> The memset failure comes from the fact that the decompressor has
> its own string functions and there is an #undefine memset in there.
> The git history doesn't make it clear where this comes from but
> if I remove it the kernel at least compiles for me with the
> multi_v7_defconfig.

The decompressor does not link with the standard C library, so it
needs to provide implementations of standard C library functionality
where required.  That means, if we have any memset() users, we need
to provide the memset() function.

The undef is there to avoid the optimisation we have in asm/string.h
for __memzero, because we don't want to use __memzero in the
decompressor.

Whether memset() is required depends on which compression method is
being used - LZO and LZ4 appear to make direct references to it, but
the inflate (gzip) decompressor code does not.

What this means is that all supported kernel compression options need
to be tested.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
