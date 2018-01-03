From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Jan 2018 11:26:43 +0100
Subject: [PATCH v2 1/2] arm64: dts: renesas: salvator-x: Remove
 renesas,no-ether-link property
In-Reply-To: <20180102093823.o6km656xdef7jnwf@verge.net.au>
References: <1513869539-18803-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <1513869539-18803-2-git-send-email-vladimir_zapolskiy@mentor.com>
 <20171222083203.h5a65uitv7yok5fz@verge.net.au>
 <20171222084048.ssyi53yj34hzejct@verge.net.au>
 <a002072f-dbe4-0b6a-a19f-08dd1ed3a8d2@mentor.com>
 <20180102093823.o6km656xdef7jnwf@verge.net.au>
Message-ID: <20180103102643.rejwzkim7wzhz22z@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 10:38:24AM +0100, Simon Horman wrote:
> Hi Vladimir,
> 
> Happy New Year!
> 
> On Fri, Dec 22, 2017 at 12:22:09PM +0200, Vladimir Zapolskiy wrote:
> > Hi Simon,
> > 
> > On 12/22/2017 10:40 AM, Simon Horman wrote:
> > > On Fri, Dec 22, 2017 at 09:32:03AM +0100, Simon Horman wrote:
> > >> On Thu, Dec 21, 2017 at 05:18:58PM +0200, Vladimir Zapolskiy wrote:
> > >>> From: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> > >>>
> > >>> The present change is a bug fix for AVB link iteratively up/down.
> > >>>
> > >>> Steps to reproduce:
> > >>> - start AVB TX stream (Using aplay via MSE),
> > >>> - disconnect+reconnect the eth cable,
> > >>> - after a reconnection the eth connection goes iteratively up/down
> > >>>   without user interaction,
> > >>> - this may heal after some seconds or even stay for minutes.
> > >>>
> > >>> As the documentation specifies, the "renesas,no-ether-link" option
> > >>> should be used when a board does not provide a proper AVB_LINK signal.
> > >>> There is no need for this option enabled on RCAR H3/M3 Salvator-X/XS
> > >>> and ULCB starter kits since the AVB_LINK is correctly handled by HW.
> > >>>
> > >>> Choosing to keep or remove the "renesas,no-ether-link" option will
> > >>> have impact on the code flow in the following ways:
> > >>> - keeping this option enabled may lead to unexpected behavior since
> > >>>   the RX & TX are enabled/disabled directly from adjust_link function
> > >>>   without any HW interrogation,
> > >>> - removing this option, the RX & TX will only be enabled/disabled after
> > >>>   HW interrogation. The HW check is made through the LMON pin in PSR
> > >>>   register which specifies AVB_LINK signal value (0 - at low level;
> > >>>   1 - at high level).
> > >>>
> > >>> In conclusion, the present change is also a safety improvement because
> > >>> it removes the "renesas,no-ether-link" option leading to a proper way
> > >>> of detecting the link state based on HW interrogation and not on
> > >>> software heuristic.
> > >>>
> > >>> Fixes: d25e8ff0d5aa ("arm64: dts: renesas: Extract common Salvator-X board support")
> > >>
> > >> The above shuffles the code around but does not introduce the problem
> > >> as far as I can see. Instead I think we should use:
> > >>
> > >> Fixes: dc36965a8905 ("arm64: dts: r8a7796: salvator-x: Enable EthernetAVB")
> > >> Fixes: 6fa501c549aa ("arm64: dts: r8a7795: enable EthernetAVB on Salvator-X")
> > >>
> > >>> Signed-off-by: Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
> > >>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> > > 
> > > I have applied this a fix for v4.15 with the updated Fixes tags above.
> > > 
> > 
> > thank you, I was unsure if you expected to get changes which can be used
> > as a base without patch application conflicts (my done choice) or changes,
> > which originally intorduced the bug, but formally require slightly
> > different fixes due to code changes in the middle. If it would be needed,
> > hopefully linux-stable maintainers can resolve the trivial conflicts.
> > 
> > Also you may find this information from the cover letter useful,
> > someone may want to check the relevant board schematics and send
> > similar fixes (if applicable after schematics review and testing):
> > 
> >   Note that DTS files for V3M Starter Kit, Draak and Eagle boards
> >   contain the same property, the files are untouched due to unavailable
> >   schematics to verify if the fix applies to these boards as well.
> 
> Thanks. I took a quick look and my findings so far are:
> 
> * Eagle: This approach seems applicable as AVB_LINK appears to be hooked up
> * V3M Starter Kit: This approach seems applicable as AVB0_LINK appears to be
>   hooked up
> * Draak: I don't seem to be able to locate documentation at this time

I have now obtained Draak documentation. It seems that this approach is
applicable to that board too as AVB0_LINK appears to be hooked up.

> Are you interested in creating follow-up patches?
