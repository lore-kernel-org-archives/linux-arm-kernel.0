From: horms@verge.net.au (Simon Horman)
Date: Thu, 21 Dec 2017 12:28:30 +0100
Subject: [PATCH 0/2] arm64: dts: renesas: Remove renesas,no-ether-link
 property
In-Reply-To: <1513776132-22700-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1513776132-22700-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <20171221112830.4ehdp237zsddfvrv@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 03:22:10PM +0200, Vladimir Zapolskiy wrote:
> The present change is a bug fix for AVB link iteratively up/down.

If this is a bug please consider including Fixes tags in the patches.

> Steps to reproduce:
> - start AVB TX stream (Using aplay via MSE),
> - disconnect+reconnect the eth cable,
> - after a reconnection the eth connection goes iteratively up/down
>   without user interaction,
> - this may heal after some seconds or even stay for minutes.
> 
> As the documentation specifies, the "renesas,no-ether-link" option
> should be used when a board does not provide a proper AVB_LINK signal.
> There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
> and ULCB starter kits since the AVB_LINK is correctly handled by HW.
> 
> Choosing to keep or remove the "renesas,no-ether-link" option will
> have impact on the code flow in the following ways:
> - keeping this option enabled may lead to unexpected behavior since
>   the RX & TX are enabled/disabled directly from adjust_link function
>   without any HW interrogation,
> - removing this option, the RX & TX will only be enabled/disabled after
>   HW interrogation. The HW check is made through the LMON pin in PSR
>   register which specifies AVB_LINK signal value (0 - at low level;
>   1 - at high level).
> 
> In conclusion, the change is also a safety improvement because it
> removes the "renesas,no-ether-link" option leading to a proper way
> of detecting the link state based on HW interrogation and not on
> software heuristic.
> 
> Note that DTS files for V3M Starter Kit, Draak and Eagle boards
> contain the same property, the files are untouched due to unavailable
> schematics to verify if the fix applies to these boards as well.
> 
> Bogdan Mirea (2):
>   arm64: dts: renesas: salvator-x: Remove renesas,no-ether-link property
>   arm64: dts: renesas: ulcb: Remove renesas,no-ether-link property
> 
>  arch/arm64/boot/dts/renesas/salvator-common.dtsi | 1 -
>  arch/arm64/boot/dts/renesas/ulcb.dtsi            | 1 -
>  2 files changed, 2 deletions(-)
> 
> -- 
> 2.8.1
> 
