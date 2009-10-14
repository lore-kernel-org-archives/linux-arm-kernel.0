From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 14 Oct 2009 20:14:19 +0100
Subject: [PATCH 07/16] i2c-designware: Set a clock name to DesignWare
	I2C clock source
In-Reply-To: <4AD5514B.4090504@necel.com>
References: <4AD3E974.8080200@necel.com> <4AD3EB09.8050304@necel.com>
	<20091013224123.GB13398@fluff.org.uk> <4AD5514B.4090504@necel.com>
Message-ID: <20091014191419.GB28948@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 01:19:23PM +0900, Shinya Kuribayashi wrote:
> # As you can imagine, my local clk implementation is based on
>  "clk_id" name matching, which looks simple for me.

... but totally wrong, and will eventually bite you.  Please use clkdev
and use the device names for the primary matching.  clkdev is what I see
as the de-facto implementation that should eventually become totally
arch independent (it is today, but lives in arch/arm for no real reason
other than my lazyness.)

> * And clk_get() is expected to pick up a clock source with:
>
> 1) dev_id + clk_id ... strict matching condition (default)
> 2) dev_id only ... fuzzy extension1 (clk_id can be regarded as wildcard)
> 3) clk_id only ... fuzzy extension2 (dev_id can be regarded as wildcard)
>
>  2) and 3) might be sort of ARM's clkdev extensions
>  (I think it's useful), but that's not my point.
>  I'll leave that alone for now.
>
>  My point is that clk framework basically requires case 1).

Incorrect.  There is no requirement for strict matching.  Think about
the situation where you have multiple different devices, and the SoC
designer has decided to tie all those clock signals to one clock source,
and this is the only clock in the system.

You might decide that your clk_get() implementation can just return that
single clock irrespective of the parameters passed.  That's a totally
legal clk API implementation.

Also, I refer you to the description of clk_get():

 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock comsumer ID
 *
 * Returns a struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.  The implementation
 * uses @dev and @id to determine the clock consumer, and thereby
 * the clock producer.  (IOW, @id may be identical strings, but
 * clk_get may return different clock producers depending on @dev.)

Note the comment about identical IDs returning different producers.

> * Then the driver is expected to supply necessary information to
>  clk_get(), regardless of clk_get() implementation, or should I say,
>  the driver should always supply both "dev_id" and "clk_id" whether
>  they are used or not.

Nope.  On several devices which only consume one clock signal, we
explicitly pass a NULL ID to absolutely prevent people going down
the road of matching only by "clk id" - it's been shown to be the
wrong approach, and leads people right down the path of passing
clock strings and pointers into drivers.

That's precisely what the clk API was designed to prevent - and
becomes all together unnecessary when the clk API is implemented
as I designed it - to match primerily by device ID.

> I intended only to fix the driver in the right direction, so would
> like to avoid discussion on clk framework implementation here.

I would strongly advise you to ensure that your implementation conforms
to the intentions of the clk API as I outline above to avoid problems
in the future.
