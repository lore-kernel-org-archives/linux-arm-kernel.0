From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 16 Sep 2014 11:49:31 -0400
Subject: [PATCH] clk: mvebu: fix sscg node lookup
In-Reply-To: <1410880503-2322-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1410880503-2322-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140916154931.GE29803@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 05:15:03PM +0200, Thomas Petazzoni wrote:
> Commit 15917b16022427c53755abff4dc7051f3076dd7a ("clk: mvebu: Fix clk
> frequency value if SSCG is enabled") introduced some logic in the
> common mvebu clock code to adjust the clock frequency according to the
> configuration of the SSCG.
> 
> In order to do this, it looks up for a DT node called "sscg" and maps
> it before accessing the SSCG configuration register.
> 
> However, the lookup is currently done using:
> 
> 	 sscg_np = of_find_node_by_name(np, "sscg");
> 
> where "np" is a pointer to the DT node of the clock for which we are
> calculating the adjusted frequency. This means that if the "sscg" node
> is *after* the clock node in the Device Tree, it works fine (and
> that's the case for Armada 370).
> 
> However, if it turns out that the "sscg" node is *before* the clock
> node in the Device Tree, it won't work because the sscg node will not
> be found.
> 
> What we really want here is a search of the entire Device Tree, not
> only starting from the clock node, so instead of passing "np" as first
> argument of of_find_node_by_name(), we simply need to pass
> NULL. Passing a non-NULL argument is typically used in a loop, so that
> the search for the next matching node starts right after the node that
> was matched.
> 
> This makes the "np" argument to the kirkwood_fix_sscg_deviation()
> function unnecessary, which leads to further cleanups.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Fixes: 15917b1602242 ("clk: mvebu: Fix clk frequency value if SSCG is enabled")
> ---
> Jason, this is a fix that applies on your mvebu/drivers-clk branch.
> 
>  drivers/clk/mvebu/common.c | 6 +++---
>  drivers/clk/mvebu/common.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Applied to mvebu/drivers-clk with Gregory's Ack.

thx,

Jason.
