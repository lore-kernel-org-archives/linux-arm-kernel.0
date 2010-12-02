From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Dec 2010 17:45:50 +0000
Subject: [PATCH] mmci: corrected calculation of clock div for ux500
In-Reply-To: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
References: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101202174550.GJ29347@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 02, 2010 at 05:51:18PM +0100, Linus Walleij wrote:
> From: Ulf Hansson <ulf.hansson@stericsson.com>
> 
> The Ux500 variant of this block has a different divider.
> The value used right now is too big and which means a loss
> in performance. This fix corrects it.

Err.

> +		} else if (variant->st_clkdiv) {
> +			clk = ((host->mclk + desired - 1) / desired) - 2;
> +			if (clk >= 256)
> +				clk = 255;
> +			host->cclk = host->mclk / (clk + 2);

This causes the divider to be selected for the 'nearest' frequency.
You are not allowed to _exceed_ the desired frequency - you must
always round down.

IOW, if 10MHz is requested and you can't do 10MHz, 10.5MHz will not
do - you must select a frequency below 10MHz.
