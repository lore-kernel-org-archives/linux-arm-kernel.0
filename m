From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Apr 2012 10:03:25 +0100
Subject: [PATCH] ARM: SAMSUNG: Should check for IS_ERR(clk) instead of NULL
In-Reply-To: <4F8FCC00.10807@samsung.com>
References: <1334722134-14545-1-git-send-email-jhbird.choi@samsung.com>
 <4F8F586C.3020401@samsung.com> <4F8FCC00.10807@samsung.com>
Message-ID: <20120419090325.GC24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 10:25:36AM +0200, Sylwester Nawrocki wrote:
> On 04/19/2012 02:12 AM, Kukjin Kim wrote:
> >> --- a/arch/arm/plat-samsung/include/plat/watchdog-reset.h
> >> +++ b/arch/arm/plat-samsung/include/plat/watchdog-reset.h
> >> @@ -25,7 +25,7 @@ static inline void arch_wdt_reset(void)
> >>
> >>   	__raw_writel(0, S3C2410_WTCON);	  /* disable watchdog, to be safe  */
> >>
> >> -	if (s3c2410_wdtclk)
> >> +	if (!IS_ERR(s3c2410_wdtclk))
> > 
> > Yeah, right. BTW don't we need to check NULL here?
> 
> It might make sense to check for NULL as well, but only if it happens
> that a clock entry is ever added to clkdev with null struct clk_lookup:clk
> member.

Not quite the correct answer.  The correct answer is:

Drivers have no business interpreting anything but IS_ERR() values from
clk_get() as errors.  Everything else they _MUST_ assume is valid for
the rest of the clk API.

The clue: struct clk is an opaque cookie as far as drivers are concerned.
The only interpretation drivers are allowed to make is that IS_ERR()
values indicate an error.  Everything else is potentially valid.
