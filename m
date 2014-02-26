From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 26 Feb 2014 22:29:26 +0000
Subject: [PATCH] Documentation: clk: Add locking documentation
In-Reply-To: <1393451575-23758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1393451575-23758-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20140226222925.GE21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 10:52:55PM +0100, Laurent Pinchart wrote:
> Briefly documentation the common clock framework locking scheme from a
> clock driver point of view.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  Documentation/clk.txt | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/clk.txt b/Documentation/clk.txt
> index 699ef2a..4bd6fd7 100644
> --- a/Documentation/clk.txt
> +++ b/Documentation/clk.txt
> @@ -255,3 +255,29 @@ are sorted out.
>  
>  To bypass this disabling, include "clk_ignore_unused" in the bootargs to the
>  kernel.
> +
> +	Part 7 - Locking
> +
> +The common clock framework uses two global locks. One of them (the enable
> +lock) is held across calls to the .enable, .disable and .is_enabled
> +operations, while the other (the prepare lock) is held across calls to all other
> +operations. This effectively divides operations in two groups from a locking
> +perspective.

It would be a good idea to mention the types of these locks - the fact
that the enable lock is a spinlock, and the prepare lock is a mutex.
That's a very important distinction as there's limitations on the
contexts that the prepare-lock can be called from.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
