From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 15 Jan 2018 12:17:46 +0300
Subject: [PATCH 2/3] arm64: dts: renesas: eagle: Remove renesas,
 no-ether-link property
In-Reply-To: <20180115084125.8112-3-horms+renesas@verge.net.au>
References: <20180115084125.8112-1-horms+renesas@verge.net.au>
 <20180115084125.8112-3-horms+renesas@verge.net.au>
Message-ID: <7cda829c-cb72-ef12-90fe-80f9dbb9200e@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 1/15/2018 11:41 AM, Simon Horman wrote:

> Regarding Salvator-X and ULCB boards, Bogdan Mirea says:

    Intended to reply to the original patches but due to high load haven't 
ever finished that email...

>      The present change is a bug fix for AVB link iteratively up/down.
> 
>      Steps to reproduce:
>      - start AVB TX stream (Using aplay via MSE),
>      - disconnect+reconnect the eth cable,
>      - after a reconnection the eth connection goes iteratively up/down
>        without user interaction,
>      - this may heal after some seconds or even stay for minutes.
> 
>      As the documentation specifies, the "renesas,no-ether-link" option
>      should be used when a board does not provide a proper AVB_LINK signal.
>      There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
>      and ULCB starter kits since the AVB_LINK is correctly handled by HW.
> 
>      Choosing to keep or remove the "renesas,no-ether-link" option will
>      have impact on the code flow in the following ways:
>      - keeping this option enabled may lead to unexpected behavior since
>        the RX & TX are enabled/disabled directly from adjust_link function
>        without any HW interrogation,

    What does he mean by that? The adjust_link() is surely called as a result 
of interrogating the PHY...

>      - removing this option, the RX & TX will only be enabled/disabled after
>        HW interrogation. The HW check is made through the LMON pin in PSR

    s/pin/bit/.

>        register which specifies AVB_LINK signal value (0 - at low level;
>        1 - at high level).

    Things are not that simple with this signal. The main cause of the issues 
is that it's connected to a LED control output of the Micrel PHY and that one 
may have different meaning -- e.g., it can well be blinking when some traffic 
happens (and IIRC that's might be a problem with KSZ9031, usually used with 
AVB). I remember I have tried without this option but finally decided to leave 
it specified as my schematics reading skills failed me in this case... I need 
to test this patch.

>      In conclusion, the present change is also a safety improvement because
>      it removes the "renesas,no-ether-link" option leading to a proper way
>      of detecting the link state based on HW interrogation and not on
>      software heuristic.
> 
> On examination of the documentation for the Eagle board this change seems
> necessary as AVB_LINK is documented as being connected.
> 
> Fixes: 38525608952a ("arm64: dts: renesas: eagle: add EtherAVB support")
> Cc: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[...]

MBR, Sergei
