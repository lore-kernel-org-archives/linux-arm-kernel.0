From: w@1wt.eu (Willy Tarreau)
Date: Sat, 5 Apr 2014 19:32:20 +0200
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
References: <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
Message-ID: <20140405173220.GA29787@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Fri, Apr 04, 2014 at 02:19:44PM +0100, Neil Greatorex wrote:
> Thomas,
> 
> After managing to get the card detected on my mirabox, I have been looking 
> into getting the thing actually working. With the information from Willy 
> and my own investigations I knew there was some issue in the setting up of 
> the MSIs for the card. Through adding a copious amount of printk()s I was 
> able to determine that the initialisation for the igb driver allocates, 
> frees and re-allocates 3 MSIs for the card.

That sequence matches the memories I have about it indeed.

> I noticed that in doing this 
> there was a problem whereby any call to free an MSI was trying to free 
> MSI#0. I was able to track this down to the fact that the mapping for the 
> IRQ was being disposed before the MSI was actually freed. The below patch 
> fixes this problem.
> 
> With this patch, I can get one port on the card working. With both ports 
> enabled, I still get an OOPS, so some further work is needed.
> 
> I would appreciate it if you could test this patch and let me know if you 
> find any problems.

I don't know how to disable one port on my card (except by fiddling directly
with its eeprom but I don't want to do this anymore, there's a high risk of
bricking it). So I got the same panic as before with the two ports enabled.
However I tried to revert the prefetchable memory patch that makes the NIC
work for me and I noticed that your fix indeed improves things. After the
oops, I no longer get :

---[ end trace f6c1769398756b02 ]---
trying to free unused MSI#0
trying to free unused MSI#0
trying to free unused MSI#0
trying to free unused MSI#0
trying to free unused MSI#0
trying to free unused MSI#0

as I used to see with the revert alone. So yes I think it's a nice step forward!

Note that this was 3.13.9 on the XP-GP board (quad-core XP).

Feel free to add my Tested-by if you like.

Cheers,
Willy
