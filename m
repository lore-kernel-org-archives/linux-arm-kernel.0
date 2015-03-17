From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 17 Mar 2015 15:01:07 -0400 (EDT)
Subject: [PATCH 1/5] USB: ehci-atmel: rework clk handling
In-Reply-To: <1426608950-31555-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <Pine.LNX.4.44L0.1503171459310.1061-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Mar 2015, Boris Brezillon wrote:

> The EHCI IP only needs the UTMI/UPLL (uclk) and the peripheral (iclk)
> clocks to work properly. Remove the useless system clock (fclk).
> 
> Avoid calling set_rate on the fixed rate UTMI/IPLL clock and remove
> useless IS_ENABLED(CONFIG_COMMON_CLK) tests (all at91 platforms have been
> moved to the CCF).
> 
> This patch also fixes a bug introduced by 3440ef1 (ARM: at91/dt: fix USB
> high-speed clock to select UTMI), which was leaving the usb clock
> uninitialized and preventing the OHCI driver from setting the usb clock
> rate to 48MHz.
> This bug was caused by several things:
> 1/ usb clock drivers set the CLK_SET_RATE_GATE flag, which means the rate
>    cannot be changed once the clock is prepared
> 2/ The EHCI driver was retrieving and preparing/enabling the uhpck
>    clock which was in turn preparing its parent clock (the usb clock),
>    thus preventing any rate change because of 1/
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
