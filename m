From: horms@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 09:40:59 +0100
Subject: [PATCH v2 2/2] arm64: dts: renesas: ulcb: Remove
 renesas,no-ether-link property
In-Reply-To: <20171222083256.2jgts6mdmssr7y76@verge.net.au>
References: <1513869539-18803-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1513869539-18803-3-git-send-email-vladimir_zapolskiy@mentor.com>
 <20171222083256.2jgts6mdmssr7y76@verge.net.au>
Message-ID: <20171222084059.hpwxz5b7rivkbpwp@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 09:32:56AM +0100, Simon Horman wrote:
> On Thu, Dec 21, 2017 at 05:18:59PM +0200, Vladimir Zapolskiy wrote:
> > From: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> > 
> > The present change is a bug fix for AVB link iteratively up/down.
> > 
> > Steps to reproduce:
> > - start AVB TX stream (Using aplay via MSE),
> > - disconnect+reconnect the eth cable,
> > - after a reconnection the eth connection goes iteratively up/down
> >   without user interaction,
> > - this may heal after some seconds or even stay for minutes.
> > 
> > As the documentation specifies, the "renesas,no-ether-link" option
> > should be used when a board does not provide a proper AVB_LINK signal.
> > There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
> > and ULCB starter kits since the AVB_LINK is correctly handled by HW.
> > 
> > Choosing to keep or remove the "renesas,no-ether-link" option will
> > have impact on the code flow in the following ways:
> > - keeping this option enabled may lead to unexpected behavior since
> >   the RX & TX are enabled/disabled directly from adjust_link function
> >   without any HW interrogation,
> > - removing this option, the RX & TX will only be enabled/disabled after
> >   HW interrogation. The HW check is made through the LMON pin in PSR
> >   register which specifies AVB_LINK signal value (0 - at low level;
> >   1 - at high level).
> > 
> > In conclusion, the present change is also a safety improvement because
> > it removes the "renesas,no-ether-link" option leading to a proper way
> > of detecting the link state based on HW interrogation and not on
> > software heuristic.
> > 
> > Fixes: 253ed045a34d ("arm64: dts: renesas: Extract common ULCB board support")
> 
> The above shuffles the code around but does not introduce the problem
> as far as I can see. Instead I think we should use:
> 
> Fixes: 144bf6ccb13f ("arm64: dts: h3ulcb: enable EthernetAVB")
> Fixes: 883fae315a6a ("arm64: dts: m3ulcb: enable EthernetAVB")
> 
> > Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> > Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

I have applied this a fix for v4.15 with the updated Fixes tags above. 
