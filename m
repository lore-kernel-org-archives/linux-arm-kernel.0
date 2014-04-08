From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 22:43:11 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408192141.GH32490@obsidianresearch.com>
References: <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate> <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu> <20140408180828.GC32490@obsidianresearch.com>
 <20140408191514.GJ11052@1wt.eu> <20140408192141.GH32490@obsidianresearch.com>
Message-ID: <20140408204311.GK11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Apr 08, 2014 at 01:21:41PM -0600, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2014 at 09:15:14PM +0200, Willy Tarreau wrote:
> 
> > OK that's what I understood, but I mean why rounding down instead of up
> > in order to correctly cover the window the device expects ? And we all
> > found that rounding up fixed our respective devices (3 igb NICs, one
> > myri10ge NIC, one SATA controller I believe).
> > 
> > By rounding up you'd have had 1ffffff instead, which at least covers the
> > window the device expects.
> 
> It is also an error to configure the mbus to have overlaping windows
> and the code checks for overlaps with the base/size given. If we round
> up then it might create an overlap.

OK, Thomas just explained this to me over the phone, it makes sense now.
In fact, I think that a mix between your patch to create multiple windows
and something Thomas wanted to do (ie allocate larger and inform the PCI
core) would be a good solution by preferring to round up small windows
(low waste) and create multiple windows where the waste is too large
(eg: address space divided by the max number of windows).

Thank you for your explanation.

Willy
