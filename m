From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Apr 2011 10:31:44 +0200
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
In-Reply-To: <20110405075622.GB4699@n2100.arm.linux.org.uk>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
	<20110405075622.GB4699@n2100.arm.linux.org.uk>
Message-ID: <20110405083144.GN13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > parameter "u32 mask" type cast befor inversion
s/befor/before/

> Nak.  I want a 32-bit all ones quantity.
> 
> unsigned long long vali = (unsigned short)~0;
> unsigned long long vall = ~(unsigned short)0;
> 
BTW, the definiton of vall is equivalent to 

	unsigned long long valu = ~(unsigned int)0;

because ~ converts the unsigned short to unsigned int.

> compiles to:
> 
> vali:
>         .word   65535
>         .word   0
> 
> vall:
>         .word   -1
>         .word   -1
I really wonder about that. If I take a value of 0xffffffff (i.e. a 32
bit wide int == ~0U) and assign that to an 64-bit unsigned long long I'd
expect it to get the value 0x00000000ffffffffULL, not
0xffffffffffffffffULL. What's wrong?

> So moving the ~ to be evaluated after the cast has the effect of making
> the cast pointless, and produces wrong values.  (u32)~0 does the 32-bit
My C-Book tells that using ~ on a signed it produces implementation
defined behaviour. That's what I pointed out to Jan and I guess that's
the reason why he created the patch.

> cast _after_ the inversion which ensures that its always truncated to
> a 32-bit value.
> 
> As the function is declared as taking a u32, the cast isn't needed.  If
> the function gets changed to take a u64, the casts will need to be
> re-added.  So, (u32)~0 makes the fact that we want a 32-bit all-ones
> mask explicit.
Actually this only results in a 32-bit all-ones value if int is at least
32 bits long, so technically using ~(u32)0 is better. (Obviously this is
given on ARM and I guess even on all platforms that Linux runs on.)

Best regards
Uwe

PS: this mail is not about trolling.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
