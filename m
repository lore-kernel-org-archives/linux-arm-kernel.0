From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 27 Apr 2012 09:40:55 +0530
Subject: announcing the clk-next branch
In-Reply-To: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
References: <CAJOA=zOGSh3et4nxE=JdojL4uDjgt8o+oiOU4pmbM=oU2U6prA@mail.gmail.com>
Message-ID: <4F9A1C4F.6020304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/25/2012 7:02 AM, Turquette, Mike wrote:
> If the branch is missing anything that I have ACK'd then please let me know.

Author: Viresh Kumar <viresh.kumar@st.com>
Date:   Wed Apr 11 11:34:35 2012 +0530

    clk: clk_set_rate() must fail if CLK_SET_RATE_GATE is set and clk is enabled
    
    This is well documented but isn't implemented. clk_set_rate() must check if
    flags have CLK_SET_RATE_GATE bit set and is enabled too.
    
    Untested patch.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 865d0dd..2bcce5a 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -898,6 +898,11 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
        if (rate == clk->rate)
                goto out;
 
+       if ((clk->flags & CLK_SET_RATE_GATE) && __clk_is_enabled(clk)) {
+               ret = -EBUSY;
+               goto out;
+       }
+


-- 
viresh
