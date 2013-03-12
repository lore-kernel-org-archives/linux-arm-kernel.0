From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Mar 2013 13:40:32 +0000
Subject: [RFC 1/1] clk: Add notifier support in
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
References: <1363091861-21534-1-git-send-email-bilhuang@nvidia.com>
Message-ID: <20130312134032.GU4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 05:37:41AM -0700, Bill Huang wrote:
> Add the below four notifier events so drivers which are interested in
> knowing the clock status can act accordingly. This is extremely useful
> in some of the DVFS (Dynamic Voltage Frequency Scaling) design.
> 
> PRE_CLK_ENABLE
> POST_CLK_ENABLE
> PRE_CLK_DISABLE
> POST_CLK_DISABLE
> 
> Signed-off-by: Bill Huang <bilhuang@nvidia.com>

NAK.  *Sigh* NO, this is the wrong level to be doing stuff like this.

The *ONLY* thing that clk_prepare_enable() and clk_prepare_disable() should
*EVER* be doing is calling clk_prepare(), clk_enable(), clk_disable() and
clk_unprepare().  Those two functions are *merely* helpers for drivers
who don't wish to make the individual calls.

Drivers are still completely free to call the individual functions, at
which point your proposal breaks horribly - and they _do_ call the
individual functions.
