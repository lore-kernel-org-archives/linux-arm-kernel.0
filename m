From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Nov 2017 13:13:51 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
References: <d3f42f35-8175-58f6-78b7-3331efe64da2@sigmadesigns.com>
 <20171101175325.2557ce85@alans-desktop>
 <4b707ce0-6067-ab36-e167-1acf348d26bf@free.fr>
 <CA+55aFxxH0HE9SfUoLVqsvDKO0PfeM+vSoDmbXQv85yJcPZoPQ@mail.gmail.com>
 <e03436d1-b140-3f29-59a6-3b1eb6bf9da4@free.fr>
 <11393e07-b042-180c-3bcd-484bf51eada6@sigmadesigns.com>
Message-ID: <20171115131351.GE31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 15, 2017 at 01:51:54PM +0100, Marc Gonzalez wrote:
> On 01/11/2017 20:38, Marc Gonzalez wrote:
> 
> > OK, I'll just send my patch, and then crawl back under my rock.
> 
> Linus,
> 
> As promised, the patch is provided below. And as promised, I will
> no longer bring this up on LKML.
> 
> FWIW, I have checked that the computed value matches the expected
> value for all HZ and delay_us, and for a few clock frequencies,
> using the following program:
> 
> $ cat delays.c
> #include <stdio.h>
> #define MEGA 1000000u
> typedef unsigned int uint;
> typedef unsigned long long u64;
> #define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> 
> static const uint HZ_tab[] = { 100, 250, 300, 1000 };
> 
> static void check_cycle_count(uint freq, uint HZ, uint delay_us)
> {
> 	uint UDELAY_MULT = (2147 * HZ) + (483648 * HZ / MEGA);
> 	uint lpj = DIV_ROUND_UP(freq, HZ);
> 	uint computed = ((u64)lpj * delay_us * UDELAY_MULT >> 31) + 1;
> 	uint expected = DIV_ROUND_UP((u64)delay_us * freq, MEGA);
> 
> 	if (computed != expected)
> 		printf("freq=%u HZ=%u delay_us=%u comp=%u exp=%u\n", freq, HZ, delay_us, computed, expected);
> }
> 
> int main(void)
> {
> 	uint idx, delay_us, freq;
> 
> 	for (freq = 3*MEGA; freq <= 100*MEGA; freq += 3*MEGA)
> 		for (idx = 0; idx < sizeof HZ_tab / sizeof *HZ_tab; ++idx)
> 			for (delay_us = 1; delay_us <= 2000; ++delay_us)
> 				check_cycle_count(freq, HZ_tab[idx], delay_us);
> 
> 	return 0;
> }
> 
> 
> 
> -- >8 --
> Subject: [PATCH] ARM: Tweak clock-based udelay implementation
> 
> In 9f8197980d87a ("delay: Add explanation of udelay() inaccuracy")
> Russell pointed out that loop-based delays may return early.
> 
> On the arm platform, delays may be either loop-based or clock-based.
> 
> This patch tweaks the clock-based implementation so that udelay(N)
> is guaranteed to spin at least N microseconds.

As I've already said, I don't want this, because it encourages people
to use too-small delays in driver code, and if we merge it then you
will look at your data sheet, decide it says "you need to wait 10us"
and write in your driver "udelay(10)" which will break on the loops
based delay.

udelay() needs to offer a consistent interface so that drivers know
what to expect no matter what the implementation is.  Making one
implementation conform to your ideas while leaving the other
implementations with other expectations is a recipe for bugs.

If you really want to do this, fix the loops_per_jiffy implementation
as well so that the consistency is maintained.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
