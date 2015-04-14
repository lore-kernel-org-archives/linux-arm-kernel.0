From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 14 Apr 2015 19:48:26 +0200
Subject: [PATCH] clk: at91: pll: fix input range validity check
In-Reply-To: <20150413043725.19585.5717@quantum>
References: <1427594023-9697-1-git-send-email-boris.brezillon@free-electrons.com>
 <20150413043725.19585.5717@quantum>
Message-ID: <20150414194826.1c43aff1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Sun, 12 Apr 2015 21:37:25 -0700
Michael Turquette <mturquette@linaro.org> wrote:

> Quoting Boris Brezillon (2015-03-28 18:53:43)
> > The PLL impose a certain input range to work correctly, but it appears that
> > this input range does not apply on the input clock (or parent clock) but
> > on the input clock after it has passed the PLL divisor.
> > Fix the implementation accordingly.
> > 
> > Cc: <stable@vger.kernel.org> # v3.14+
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Reported-by: Jonas Andersson <jonas@microbit.se>
> 
> Hi Boris,
> 
> OK, so this patch along with your two previous submissions kind of
> tackle some of items I mentioned earlier today[0].
> 
> Does this patch, combined with your two prior patches[1][2] resolve the
> issue you brought up in your "Propagating clock rate constraints"
> thread[3]?

Unfortunately it doesn't (though it does resolve one of my
issues, so I definitely need that patch :-)).

Take the following case:
1/ clock X takes clock Y as its parent (let's say clock X is a clock
divider)
2/ user U claims clock X and configure X's rate (X then propagates
rate change to Y) and assign a specific supported rate range to X
2/ user V claims clock Y and sets a specific rate

As of today, the constraint U has set on clock X is not propagated to
clock Y, which means user V might configure a rate that is not
fulfilling users V constraint, and the clk infrastructure won't
complain (actually it won't detect it).

Here's what I would expect: if a (MIN -> MAX) constraint is set on clock
X the (MIN * XDIV -> MAX * XDIV) constraint should be propagated to
clock Y.

Am I wrong ?

Best Regards,


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
