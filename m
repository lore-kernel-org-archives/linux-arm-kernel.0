From: amit.kucheria@verdurent.com (Amit Kucheria)
Date: Fri, 28 May 2010 11:29:09 +0300
Subject: [PATCH 1/1] arm: mxc: utilise usecount field in clock operations
In-Reply-To: <4BD0D4F0.9090605@canonical.com>
References: <d501dcf8dbe98ed7f5aa9e7b34e68f0e1076ac84.1271968118.git.amit.kucheria@verdurent.com>
	<4BD0D4F0.9090605@canonical.com>
Message-ID: <20100528082909.GA3122@matterhorn.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 Apr 22, Tim Gardner wrote:
> On 04/22/2010 02:30 PM, Amit Kucheria wrote:
> >From: Amit Kucheria<amit.kucheria@canonical.com>
> >
> >This patch fixes the clock refcounting when reparenting is used.
> >
> >Sascha just pointed out a good explanation of refcounting here:
> >http://www.spinics.net/lists/arm-kernel/msg85879.html
> >
> >Signed-off-by: Amit Kucheria<amit.kucheria@canonical.com>
> >---
> >  arch/arm/plat-mxc/clock.c |   34 ++++++++++++++++++++++------------
> >  1 files changed, 22 insertions(+), 12 deletions(-)
> >
> >diff --git a/arch/arm/plat-mxc/clock.c b/arch/arm/plat-mxc/clock.c
> >index 323ff8c..14781cc 100644
> >--- a/arch/arm/plat-mxc/clock.c
> >+++ b/arch/arm/plat-mxc/clock.c
> >@@ -50,15 +50,16 @@ static DEFINE_MUTEX(clocks_mutex);
> >
> >  static void __clk_disable(struct clk *clk)
> >  {
> >-	if (clk == NULL || IS_ERR(clk))
> >+	WARN_ON(!clk->usecount);
> >+	if (clk == NULL || IS_ERR(clk) || !clk->usecount)
> >  		return;
> >
> 
> The clk==NULL check seem superfluous if WARN_ON(!clk->usecount) has
> already dereferenced clk (and possibly crashed). You might need two
> statements if its likely that clk could be NULL.
> 

Tim, You're right. 

Sascha, updated patch to fix that issue and correspond more closely to
Russell's explanation follows.

Cheers,
Amit
