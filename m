From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 7 Apr 2014 14:48:17 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
References: <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
 <alpine.DEB.2.10.1404041408280.8617@vroombuntu>
 <20140406185833.GI29787@1wt.eu>
 <alpine.DEB.2.10.1404062253500.16719@vroombuntu>
 <20140407174106.GD9952@obsidianresearch.com>
 <CAAfodu0kbTspq2QQf0dh3U7LB-q+ECaX9FJ35fCc25UmgPJZSg@mail.gmail.com>
Message-ID: <20140407204817.GB20736@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 07, 2014 at 08:41:52PM +0100, Neil Greatorex wrote:
> > To be very clear, PCI BARs, should never overlap.
> 
> I realise that overlap was probably the wrong word. I meant that the
> resources for 01:00.0 and 01:00.1 are not contiguous but are mixed
> together. If you sort by address you get:
> 
> e0000000-e007ffff : 0000:01:00.0
> e0080000-e00fffff : 0000:01:00.0
> e0100000-e017ffff : 0000:01:00.1
> e0180000-e01fffff : 0000:01:00.1
> e0200000-e0203fff : 0000:01:00.0
> e0204000-e0223fff : 0000:01:00.0
> e0224000-e0243fff : 0000:01:00.0
> e0244000-e0247fff : 0000:01:00.1
> e0248000-e0267fff : 0000:01:00.1
> e0268000-e0287fff : 0000:01:00.1

Yes, that is fine. It is just a quirk of the allocator.
They are all within the downstream bridge window. 
 
> > HOWEVER, looking now very closely:
> >
> > 00:01.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
> >    Memory behind bridge: e0000000-e02fffff
> > 00:02.0 PCI bridge: Marvell Technology Group Ltd. Device 6710 (rev 01) (prog-if 00 [Normal decode])
> >    Memory behind bridge: e0300000-e03fffff
> >
> > This is certainly wrong, MBUS requires special alignment and sizing.
> > 0x300000 is not a size which is a power of two, and the next window
> > starts right after.

> Interesting. Does the PCI code provide a way to specify that the sizes
> much be a power of 2? I don't fully understand the implications but
> would it be possible to assign just one MBUS window for the whole of
> the PCIe memory instead?

I know this has come up before, but I don't recall where things
settled out.. mvebu_pcie_align_resource is the function to look at,
the size at that point needs to be rounded up to a power of two and
communicated back to the caller.

Alternately, I belive Thomas once discussed using multiple mbus
windows for these non-aligned requests.

> > Just to confirm, what does something like the below say for you guys?
> 
> See https://gist.github.com/ngreatorex/10025253 for the dmesg output.
> I have also included the contents of
> /sys/kernel/debug/mvebu-mbus/devices both before and after the
> modprobe / oops. As you can see I get a total of 3 WARNINGs - one at
> boot for the xHCI controller, and two when inserting igb.ko. Note that
> this time I did this with both ports enabled.

Yep, that is certainly the root problem - most likely for
everyone. This also explains why Will saw success when he reverted
that unrelated patch. That change altered the allocation pattern of
the BARs and it just so happened to make things fall out properly.

We should also fix mvebu_mbus_read_window, so debugfs reports the
actual HW function. Instead of this:
        *size = (ctrlreg | ~WIN_CTRL_SIZE_MASK) + 1;

Something with ffs is required, perhaps (untested):
        *size = 2 << ffs(~(ctrlreg | ~WIN_CTRL_SIZE_MASK));

Thomas: Do you think the WARN_ON should head into mainline?

Jason
