From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 5 Apr 2011 13:12:57 +0200
Subject: [PATCH] ARM: type casts update_sched_clock cyc_to_sched_clock
	cyc_to_fixed_sched_clock
In-Reply-To: <20110405090100.GC4699@n2100.arm.linux.org.uk>
References: <1301989401-11984-1-git-send-email-j.weitzel@phytec.de>
	<20110405075622.GB4699@n2100.arm.linux.org.uk>
	<20110405083144.GN13963@pengutronix.de>
	<20110405090100.GC4699@n2100.arm.linux.org.uk>
Message-ID: <20110405111257.GR13963@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2011 at 10:01:00AM +0100, Russell King - ARM Linux wrote:
> On Tue, Apr 05, 2011 at 10:31:44AM +0200, Uwe Kleine-K?nig wrote:
> > On Tue, Apr 05, 2011 at 08:56:22AM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Apr 05, 2011 at 09:43:21AM +0200, Jan Weitzel wrote:
> > > > parameter "u32 mask" type cast befor inversion
> > s/befor/before/
> > 
> > > Nak.  I want a 32-bit all ones quantity.
> > > 
> > > unsigned long long vali = (unsigned short)~0;
> > > unsigned long long vall = ~(unsigned short)0;
> > > 
> > BTW, the definiton of vall is equivalent to 
> > 
> > 	unsigned long long valu = ~(unsigned int)0;
> > 
> > because ~ converts the unsigned short to unsigned int.
> 
> No.  The value gets promoted to int not unsigned int.
> 
> > > compiles to:
> > > 
> > > vali:
> > >         .word   65535
> > >         .word   0
> > > 
> > > vall:
> > >         .word   -1
> > >         .word   -1
> > I really wonder about that. If I take a value of 0xffffffff (i.e. a 32
> > bit wide int == ~0U) and assign that to an 64-bit unsigned long long I'd
> > expect it to get the value 0x00000000ffffffffULL, not
> > 0xffffffffffffffffULL. What's wrong?
> 
> See above.  int not unsigned int.  And it makes a difference:
> 
> unsigned long long vals = ~(int)0;
> unsigned long long valu = ~(unsigned int)0;
> 
> vals:
>         .word   -1
>         .word   -1
> valu:
>         .word   -1
>         .word   0
> 
ah, ok, makes sense and actually is consistent with my book.
(After knowing what I search I found it. The rules are:

 - A signed type of rank less than int
   -> int
 - An unsigned type of rank less than int,
   all of whose values can be represented in type int
   -> int
 - An unsigned type of rank less than int,
   all of whose values cannot be represented in type int
   -> unsigned int
).

So the maximal correct variant is (u32)(int)~0U or alternatively
(u32)(-1), right?

Thanks for your answer, best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
