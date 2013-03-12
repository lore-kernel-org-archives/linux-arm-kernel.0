From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 12 Mar 2013 20:56:59 +0100
Subject: IS_ERR_VALUE()
In-Reply-To: <20130312141604.GV4977@n2100.arm.linux.org.uk>
References: <20130312141604.GV4977@n2100.arm.linux.org.uk>
Message-ID: <20130312195659.GR15375@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Mar 12, 2013 at 02:16:04PM +0000, Russell King - ARM Linux wrote:
> I am removing almost all references to the above macro from arch/arm.
> Many of them are wrong.  Some of them are buggy.
> 
> For instance:
> 
> int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> {
>         int div;
>         div = gpmc_calc_divider(t->sync_clk);
>         if (div < 0)
>                 return div;
> static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
> {
> ...
>         return gpmc_cs_set_timings(cs, t);
> 
> .....
>         ret = gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
>         if (IS_ERR_VALUE(ret))
>                 return ret;

Well, gpmc_calc_divider returns -1 on failure, so I agree that it's
wrong to use IS_ERR_VALUE on it.
 
> So, gpmc_cs_set_timings() thinks any negative return value is an error,
> but where we check that in higher levels, only a limited range are
> errors... seriously?  Come on guys, get with the program.  Get your
> error checking in order.
 
Still I don't get what is really wrong in your examples (but I didn't
check all). If a function returning an int is supposed to return 0 on
success and -ESOMEERROR on failure it doesn't matter much if I do (ret <
0) or IS_ERR_VALUE(ret). (Even if ret is signed, the check (x) >=
(unsigned long)-MAX_ERRNO in IS_ERR_VALUE does the right thing.)

There is only a semantical difference between the two checks for
(unsigned)ret being between MAX_INT+1 and (unsigned)-MAX_ERRNO. But a
value in this range isn't allowed for such a function. So you could also
just check using "if (ret)". All but the previous sentence also apply to
functions returning an int >=0 on success and -ESOMEERROR on failure.

So unless I missed something---and if I do, please tell me---your patch
is not about correctness, but "only" about style and consistency?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
