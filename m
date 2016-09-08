From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 8 Sep 2016 22:50:19 +0200
Subject: [PATCH] i2c: rk3x: Restore clock settings at resume time
In-Reply-To: <1472505756-8302-1-git-send-email-dianders@chromium.org>
References: <1472505756-8302-1-git-send-email-dianders@chromium.org>
Message-ID: <20160908205018.GG3166@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 02:22:36PM -0700, Douglas Anderson wrote:
> Depending on a number of factors including:
> - Which exact Rockchip SoC we're working with
> - How deep we suspend
> - Which i2c port we're on
> 
> We might lose the state of the i2c registers at suspend time.
> Specifically we've found that on rk3399 the i2c ports that are not in
> the PMU power domain lose their state with the current suspend depth
> configured by ARM Tursted Firmware.
> 
> Note that there are very few actual i2c registers that aren't configured
> per transfer anyway so all we actually need to re-configure are the
> clock config registers.  We'll just add a call to rk3x_i2c_adapt_div()
> at resume time and be done with it.
> 
> NOTE: On rk3399 on ports whose power was lost, I put printouts in at
> resume time.  I saw things like:
>   before: con=0x00010300, div=0x00060006
>   after:  con=0x00010200, div=0x00180025
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Fixed the code checker warnings:

    SPARSE
drivers/i2c/busses/i2c-rk3x.c:1346:14: warning: duplicate const
    SMATCH
drivers/i2c/busses/i2c-rk3x.c:1346:14: warning: duplicate const

and applied to for-current, thanks!


Note my code checkers also say this (unrelated to your patch):

    SPARSE
drivers/i2c/busses/i2c-rk3x.c:888:17: warning: cast truncates bits from constant value (ffffffffff00 becomes ffffff00)

  CC      drivers/i2c/busses/i2c-rk3x.o
drivers/i2c/busses/i2c-rk3x.c: In function 'rk3x_i2c_v1_calc_timings':
drivers/i2c/busses/i2c-rk3x.c:745:41: warning: variable 'min_total_ns' set but not used [-Wunused-but-set-variable]

I haven't checked those, though...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/01c87369/attachment.sig>
