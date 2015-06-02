From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Tue, 2 Jun 2015 06:21:20 +0200
Subject: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
In-Reply-To: <20150601205217.GD30984@atomide.com>
References: <20150528073740.GD16509@pali> <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com>
 <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
 <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
 <20150529155030.GO30984@atomide.com>
 <CAALWOA-X-Jb_2NODrPNnDgaLuYFDuxjPLHYwqRjaPz2PrqhJkA@mail.gmail.com>
 <20150601175806.GZ30984@atomide.com>
 <CAALWOA8swU+wRrg8NnFDoKMEEsfKAE=u7ZiQE3X5BvRKLOjNmg@mail.gmail.com>
 <20150601205217.GD30984@atomide.com>
Message-ID: <CAALWOA-sT_NfL6-ZFLF3=UXyeO482XTzNmzUVmr2Y=0A3xpaGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2015 at 22:52, Tony Lindgren <tony@atomide.com> wrote:
> OK that must be the case I've seen then. Probably that happens
> when a device is not clocked.

It happens for any interconnect error reported as a result of
instruction fetch, but that is itself not a very common occurrence and
obviously doesn't apply to device memory.

Another case where the L3 error irq may be taken first is if the bus
error is asynchronous, but I don't think this combo can be produced on
a dm81xx or am335x, but that's mainly due to the strictly in-order
Cortex-A8 making almost every abort synchronous. I'd expect async
aborts are more common on an A9.

> Hmm well it should be just MT_DEVICE for anything Linux ioremaps..

Yikes, so both /dev/mem and uio are behaving unlike any device driver:
both use remap_pfn_range() after running the vm_page_prot though
pgprot_noncached() to set the memory type to L_PTE_MT_UNCACHED, which
counterintuitively turns out to mean strongly-ordered. o.O  Especially
uio is acting inappropriate here imho.

But this is problematic... these ranges are already mapped by the
kernel, and ARM explicitly forbids mapping the same physical range
twice with different memory attributes (and it's not the only
architecture to do so). Hmmz...

Anyhow, drifting a bit off-topic here. I'm going to some more reading
and thinking about this.
