From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 28 Jan 2013 12:19:14 -0700
Subject: [RFC V2 PATCH 0/8] ARM: kirkwood: cleanup DT conversion
In-Reply-To: <20130128200332.2770093e@skate>
References: <cover.1359091286.git.jason@lakedaemon.net>
 <201301251115.47480.arnd@arndb.de>
 <20130125125214.GI1758@titan.lakedaemon.net>
 <CABJ1b_QaTBLgGASTs2yi435jR=LepN-iY97xTLXAu1hZw69Wuw@mail.gmail.com>
 <20130125183407.GC7393@obsidianresearch.com>
 <20130128104008.GA5170@localhost>
 <20130128180716.GA9436@obsidianresearch.com>
 <20130128192445.6984e7dd@skate>
 <CALF0-+U5DVGAMZGw1nsBMe5cJ1=U1b19D+kunWtSYn3sUYiRDg@mail.gmail.com>
 <20130128200332.2770093e@skate>
Message-ID: <20130128191914.GA17722@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 08:03:32PM +0100, Thomas Petazzoni wrote:

> devices described in the DT, nothing different. In their ->probe()
> function, those driver call some mvebu_setup_addr_decoding_window()
> function, which is part of an API provided by the address mapping
> driver.

I think that would be a layering mess to update these possibly shared
drivers to conditionally call some mvebu specific function in some
case, with some SOC specific set of parameters.. The MBUS driver
should take care of that, just like the PCI framework takes care of
address allocation.
 
> The address at which we configure the various address decoding windows
> is an operating system specific decision, it is not a description of
> the hardware. Therefore, it shouldn't be encoded in the DT, because the
> DT describes the hardware, not the Linux-specific decisions on how the
> hardware should be used.

DT models PCI BARs/Bridge windows as well, which are functionally
identical to the MBUS decode windows. There *is* a piece of address
decoder hardware, and the DT binding for that kind of hardware is a
bus with ranges. So it is completely appropriate to model that in DT.

The OF convention for bridge buses is to put the boot loader assigned
address in the DT (under the assumption that the boot loader sets
things up properly) so it is reasonable to include those addresses in
DT as well..

If, someday, the MBUS driver wants to dynamically allocate every MBUS
region, then that is fine, it can ignore/override the addresses from
the DT, just like the PCI stuff does for BARs/etc, but for today
without dynamic assignment it makes alot of sense to just use the DT
values directly.

Jason
