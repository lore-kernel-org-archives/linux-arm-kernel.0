From: neil@fatboyfat.co.uk (Neil Greatorex)
Date: Tue, 8 Apr 2014 21:19:19 +0100 (BST)
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada
 370)
In-Reply-To: <20140408192141.GH32490@obsidianresearch.com>
References: <20140405193435.50d8dd81@skate>
 <54BB31A2B04145E8908E0183FAB6B61B@fatboyfat.co.uk>
 <alpine.DEB.2.10.1404061631130.4683@vroombuntu>
 <20140408171309.09bbf968@skate> <20140408174034.79df403e@skate>
 <20140408175545.1b4d55a5@skate>
 <20140408171417.GB27776@obsidianresearch.com> <20140408175324.GH11052@1wt.eu>
 <20140408180828.GC32490@obsidianresearch.com> <20140408191514.GJ11052@1wt.eu>
 <20140408192141.GH32490@obsidianresearch.com>
Message-ID: <alpine.DEB.2.10.1404082114550.1578@vroombuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Apr 2014, Jason Gunthorpe wrote:
> On Tue, Apr 08, 2014 at 09:15:14PM +0200, Willy Tarreau wrote:
>
>> OK that's what I understood, but I mean why rounding down instead of up
>> in order to correctly cover the window the device expects ? And we all
>> found that rounding up fixed our respective devices (3 igb NICs, one
>> myri10ge NIC, one SATA controller I believe).
>>
>> By rounding up you'd have had 1ffffff instead, which at least covers the
>> window the device expects.
>
> It is also an error to configure the mbus to have overlaping windows
> and the code checks for overlaps with the base/size given. If we round
> up then it might create an overlap.

If I use only the rounding up part of my patch and not the 4M alignment 
part then this is the exact scenario I get:

00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device 
[11ab:6710] (rev 01) (prog-if 00 [Normal decode])
 	Memory behind bridge: e0000000-e02fffff
 	Prefetchable memory behind bridge: 00000000-000fffff
00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device 
[11ab:6710] (rev 01) (prog-if 00 [Normal decode])
 	Memory behind bridge: e0300000-e03fffff
 	Prefetchable memory behind bridge: 00000000-000fffff

The window for bridge 00:01.0 gets rounded up to cover e0000000-e03fffff 
and the attempt to add the window for bridge 00:02.0 fails.

> You guys were OK with the round up in the PCI code only because your
> systems have a single used PEX so the rounding didn't create an
> overlaping situation..

In my case it worked because I changed the alignment to 4M to prevent the 
overlap.

> The generic code should either round down, or compeltely bail, as
> Thomas suggested.
>
> Fundementally we shouldn't get to the WARN_ON, so what happens after
> is just an attempt to salvage something from the situation.

Agreed.

Cheers,
Neil
