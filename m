From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 13:11:01 +0100
Subject: [PATCH v2] Documentation: clk: Add locking documentation
In-Reply-To: <1393591256-6932-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393591256-6932-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1427024.Y6pT20dv1F@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Friday 28 February 2014 13:40:56 Laurent Pinchart wrote:
> Briefly documentation the common clock framework locking scheme from a
> clock driver point of view.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Ping ? Is this version better (and acceptable) ?

> ---
>  Documentation/clk.txt | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index 699ef2a..c9c399a 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -255,3 +255,37 @@ are sorted out.
> 
>  To bypass this disabling, include "clk_ignore_unused" in the bootargs to
> the kernel.
> +
> +	Part 7 - Locking
> +
> +The common clock framework uses two global locks, the prepare lock and the
> +enable lock.
> +
> +The enable lock is a spinlock and is held across calls to the .enable,
> +.disable and .is_enabled operations. Those operations are thus not allowed
> to +sleep, and calls to the clk_enable(), clk_disable() and
> clk_is_enabled() API +functions are allowed in atomic context.
> +
> +The prepare lock is a mutex and is held across calls to all other
> operations. +All those operations are allowed to sleep, and calls to the
> corresponding API +functions are not allowed in atomic context.
> +
> +This effectively divides operations in two groups from a locking
> perspective. +
> +Drivers don't need to manually protect resources shared between the
> operations +of one group, regardless of whether those resources are shared
> by multiple +clocks or not. However, access to resources that are shared
> between operations +of the two groups needs to be protected by the drivers.
> An example of such a +resource would be a register that controls both the
> clock rate and the clock +enable/disable state.
> +
> +The clock framework is reentrant, in that a driver is allowed to call clock
> +framework functions from within its implementation of clock operations.
> This +can for instance cause a .set_rate operation of one clock being
> called from +within the .set_rate operation of another clock. This case
> must be considered +in the driver implementations, but the code flow is
> usually controlled by the +driver in that case.
> +
> +Note that locking must also be considered when code outside of the common
> +clock framework needs to access resources used by the clock operations.
> This +is considered out of scope of this document.

-- 
Regards,

Laurent Pinchart
