From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Aug 2013 17:22:01 +0200
Subject: [PATCH v3 2/5] clkdev: Fix race condition in clock lookup from
 device tree
In-Reply-To: <1377270227-1030-3-git-send-email-s.nawrocki@samsung.com>
References: <1377270227-1030-1-git-send-email-s.nawrocki@samsung.com>
 <1377270227-1030-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <52177E19.3080106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2013 05:03 PM, Sylwester Nawrocki wrote:
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

Oops, I missed to add:

Reviewed-by: Mike Turquette <mturquette@linaro.org>

> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
