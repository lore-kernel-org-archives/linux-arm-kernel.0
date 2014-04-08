From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 8 Apr 2014 13:21:41 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408191514.GJ11052@1wt.eu>
References: <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu>
 <20140408180828.GC32490@obsidianresearch.com>
 <20140408191514.GJ11052@1wt.eu>
Message-ID: <20140408192141.GH32490@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 09:15:14PM +0200, Willy Tarreau wrote:

> OK that's what I understood, but I mean why rounding down instead of up
> in order to correctly cover the window the device expects ? And we all
> found that rounding up fixed our respective devices (3 igb NICs, one
> myri10ge NIC, one SATA controller I believe).
> 
> By rounding up you'd have had 1ffffff instead, which at least covers the
> window the device expects.

It is also an error to configure the mbus to have overlaping windows
and the code checks for overlaps with the base/size given. If we round
up then it might create an overlap.

You guys were OK with the round up in the PCI code only because your
systems have a single used PEX so the rounding didn't create an
overlaping situation..

The generic code should either round down, or compeltely bail, as
Thomas suggested.

Fundementally we shouldn't get to the WARN_ON, so what happens after
is just an attempt to salvage something from the situation.

Jason
