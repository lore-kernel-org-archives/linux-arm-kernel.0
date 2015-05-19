From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 May 2015 23:07:21 +0100
Subject: [PATCH] ARM: v7 setup function should invalidate L1 cache
In-Reply-To: <2080993.BUNZpO9uLL@wuerfel>
References: <E1Yuk8W-0001tC-IK@rmk-PC.arm.linux.org.uk>
 <6452458.LAJUB33YSi@phil> <2080993.BUNZpO9uLL@wuerfel>
Message-ID: <20150519220721.GK2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 11:55:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 19 May 2015 23:44:58 Heiko Stuebner wrote:
> > 
> > Michael Niewoehner tested this on a rk3188 (Cortex-A9) and wrote in [0]
> > > Tested-by: Michael Niewoehner <mniewoeh@stud.hs-offenburg.de>
> > > 
> > > Tested on Radxa Rock Pro with RK3188.
> > > The kernel panics on reboot I had before and also a kernel BUG when running
> > > "memtester 1900M" went away and the rock seems to run stable now.
> > 
> 
> We should probably create a separate fix for that and add it to the stable
> kernels then. I would suggest something like the untested patch below,
> which takes advantage of the fact that we already have separate assignments
> for the start_secondary function pointer for A9 and A17.

Your patch is also continuing the pattern with this code...

> diff --git a/arch/arm/mach-rockchip/headsmp.S b/arch/arm/mach-rockchip/headsmp.S
> index 46c22dedf632..ae0077e8fe98 100644
> --- a/arch/arm/mach-rockchip/headsmp.S
> +++ b/arch/arm/mach-rockchip/headsmp.S
> @@ -16,9 +16,6 @@
>  #include <linux/init.h>
>  
>  ENTRY(rockchip_secondary_startup)
> -	mrc	p15, 0, r0, c0, c0, 0	@ read main ID register
> -	ldr	r1, =0x00000c09		@ Cortex-A9 primary part number
> -	teq	r0, r1
>  	beq	v7_invalidate_l1
>  	b	secondary_startup

If you look carefully at this, you'll notice that it's utter crap.
(Sorry, but it is.)  It has two problems:

1. It'll never match a Cortex-A9 CPU.  Cortex-A9 has a MIDR value of
   0x412fc09a, not 0x00000c09.  The bit position of the part number
   field isn't even right.

2. If it does match, then we branch to "v7_invalidate_l1" without setting
   the link register: we'll never return back here (we'll return to whatever
   random value the link register contains) and so we'll never make it to
   secondary_startup.  *Thankfully*, because of (1), this branch will
   never be taken - this is it's saving grace.

Your patch introduces a /third/ form of crapiness:

3. If the PSR happens to have Z=1, the "beq" instruction will be taken,
   thereby crashing the system because of (2).

The /simplest/ change which would fix this problem is to just change
proc-v7.S.  The remainder is effectively a cleanup removing redundant
code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
