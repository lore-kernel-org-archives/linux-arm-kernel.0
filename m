From: w@1wt.eu (Willy Tarreau)
Date: Tue, 8 Apr 2014 21:15:14 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140408180828.GC32490@obsidianresearch.com>
References: <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate> <20140408171417.GB27776@obsidianresearch.com>
 <20140408175324.GH11052@1wt.eu> <20140408180828.GC32490@obsidianresearch.com>
Message-ID: <20140408191514.GJ11052@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 12:08:28PM -0600, Jason Gunthorpe wrote:
> > So if I understand it right, for example when my first NIC registers
> > e0000000-e02fffff, then we'll truncate it down to e0000000-e01fffff,
> > won't that cause any issue, for example if the NIC needs to access
> > data beyond that limit ?
> 
> The mbus windows are assigned to the bridge, not to the NIC bars:
> 
> 00:0a.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:7846] (rev 02) (prog-if 00 [Normal decode])
>         Memory behind bridge: e0000000-e17fffff
> 
> So the above is not OK, 17fffff is not a power of two. The patch
> causes the mbus to WARN_ON and then round down so that the hardware is
> at least in a defined configuration.
>
> > BTW I can try your patch with the myricom NIC which started to work
> > when rounding up, I'll quickly see if that fixes the issue as well,
> > but I'm now a little bit confused.
> 
> This patch won't fix anything, it just fixes the mbus driver to always
> program the hardware with valid values, even if the upper layer
> requests something invalid.

OK that's what I understood, but I mean why rounding down instead of up
in order to correctly cover the window the device expects ? And we all
found that rounding up fixed our respective devices (3 igb NICs, one
myri10ge NIC, one SATA controller I believe).

By rounding up you'd have had 1ffffff instead, which at least covers the
window the device expects.

It's just this specific point of the reason for rounding down versus up
that concerns me.

Thanks,
Willy
