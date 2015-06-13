From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sat, 13 Jun 2015 13:13:00 +0200
Subject: [BUG] usb/at91: usb hub does not work
In-Reply-To: <20150613130956.53316080@bbrezillon>
References: <Pine.LNX.4.44L0.1506110952460.1465-100000@iolanthe.rowland.org>
 <557AA6AC.1090308@aksignal.cz> <20150613130956.53316080@bbrezillon>
Message-ID: <20150613131300.18e6247a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 13 Jun 2015 13:09:56 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hi Jiri,
> 
> On Fri, 12 Jun 2015 11:30:20 +0200
> Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:
> 
> > 
> > 
> > On 11.6.2015 15:53, Alan Stern wrote:
> > > On Thu, 11 Jun 2015, Ji?? Prchal wrote:
> > >
> > >> Hi all,
> > >> I discovered some bug when I change kernel from 3.18.13 to 3.18.14. I have board with usb hub CY7C65632 on it.
> > >> In .13 it works fine but in .14 it repeats this message:
> > >> [   19.170000] usb 2-3: new full-speed USB device number 56 using at91_ohci
> > >> and devices connected to usb through hub doesn't appear at all.
> > >
> > >> Any idea?
> > >
> > > Try using git bisect to find the commit which caused this problem to
> > > start.
> > 
> > This is result:
> > Bisecting: 0 revisions left to test after this (roughly 0 steps)
> > [ae74ea64ccdb8b99ee2618b58020263d5b1d9b22] clk: at91: usb: propagate rate modification to the parent clk
> 
> 
> Actually when bisecting you found a bug that has been fixed before
> 3.18.14 was released (see this commit [1]).
> This being said, the prototype mismatch fix does not seem to fix all
> the mismatches (seems the ->determine_rate() has been changed in 3.19
> too, and the prototype mismatch patch was a backport of a 3.19 fix).
> 
> Anyway, you'll find below a patch supposed to fix the remaining bug.

I forgot to disable the line wrapper in my email client, here is the
same patch without the wrapped lines:

-- >8 --

>From 7392429d074f43ef61d41e33db63f0f5d804bdd4 Mon Sep 17 00:00:00 2001
Subject: [PATCH] clk: at91: fix determine_rate prototype (again)

Commit ae74ea64ccdb8b99ee2618b58020263d5b1d9b22 was a backport of a bug
fix applied in 4.0, but in the meantime the ->determine_rate() prototype
has changed, thus introduction a prototype mismatch bug in pre-4.0
kernels. This prototype mismatch was supposed to be fixed by commit
76723e7ed589998384a080e29204df4659c67cf2, which fix the bug on 3.19 kernels,
but the ->determine_rate() has also changed between 3.18 and 3.19.
Hopefully this patch will definitely fix the prototype mismatch for 3.18.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/clk/at91/clk-usb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index 0283a57..d0d335d 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -59,7 +59,7 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 					      unsigned long rate,
 					      unsigned long *best_parent_rate,
-					      struct clk_hw **best_parent_hw)
+					      struct clk **best_parent_clk)
 {
 	struct clk *parent = NULL;
 	long best_rate = -EINVAL;
@@ -91,7 +91,7 @@ static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
 				best_rate = tmp_rate;
 				best_diff = tmp_diff;
 				*best_parent_rate = tmp_parent_rate;
-				*best_parent_hw = __clk_get_hw(parent);
+				*best_parent_clk = parent;
 			}
 
 			if (!best_diff || tmp_rate < rate)
-- 
1.9.1
