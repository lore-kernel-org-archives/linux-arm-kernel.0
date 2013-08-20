From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Aug 2013 22:52:21 +0100
Subject: [PATCH v2 4/4] clkdev: Fix race condition in clock lookup from
 device tree
In-Reply-To: <1377020063-30213-5-git-send-email-s.nawrocki@samsung.com>
References: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
 <1377020063-30213-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130820215221.GH17845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 07:34:23PM +0200, Sylwester Nawrocki wrote:
> There is currently a race condition in the device tree part of clk_get()
> function, since the pointer returned from of_clk_get_by_name() may become
> invalid before __clk_get() call. I.e. due to the clock provider driver
> remove() callback being called in between of_clk_get_by_name() and
> __clk_get().
> 
> Fix this by doing both the look up and __clk_get() operations with the
> clock providers list mutex held. This ensures that the clock pointer
> returned from __of_clk_get_from_provider() call and passed to __clk_get()
> is valid, as long as the clock supplier module first removes its clock
> provider instance and then does clk_unregister() on the corresponding
> clocks.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>

Thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
