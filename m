From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 10 Dec 2012 19:59:35 +0100
Subject: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <50C626E4.1010808@wwwdotorg.org>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121207233317.GB4304@obsidianresearch.com>
 <50C62161.9080708@wwwdotorg.org> <20121210190552.74acbe5a@skate>
 <50C626E4.1010808@wwwdotorg.org>
Message-ID: <20121210195935.1b8a7797@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stephen Warren,

On Mon, 10 Dec 2012 11:16:04 -0700, Stephen Warren wrote:

> > On Marvell SoCs, this is even more flexible: you have 20 configurable
> > address decoding windows. For each of them, you can configure the base
> > address, size, and target device (i.e PCIe port x.y, NAND, or some
> > other devices). And since we have up to 10 PCIe interfaces, we really
> > don't want to over-allocate hundreds of MB of physical address space for
> > each device, since most of them need only a few dozens of KB.
> 
> OK, that all makes sense.
> 
> One question though: When you say "device" in the line above, I assume
> the device you're referring to is the PCIe host device, and not the
> individual PCIe devices themselves; with 20 address decoding windows and
> 10 PCIe ports, and those windows apparently being used for on-SoC
> devices too (e.g. you mention NAND above), I assume you'd want to limit
> the number of windows you use per PCIe bus/port to just 1, rather than 1
> per enumerated PCIe device?

Well, I am not a PCI or PCIe expert, so my terminology might be wrong.
Basically, on Armada XP, you have:

 PCIe 0.0 (can be x4, in which case PCIe 0.{1,2,3} can't be used, or x1)
 PCIe 0.1 x1
 PCIe 0.2 x1
 PCIe 0.3 x1
 PCIe 1.0 (can be x4, in which case PCIe 1.{1,2,3} can't be used, or x1)
 PCIe 1.1 x1
 PCIe 1.2 x1
 PCIe 1.3 x1
 PCIe 2.0 (x4/x1)
 PCIe 3.0 (x4/x1)

On the Armada XP evaluation board, I have one slot for each of those
interfaces (well, actually I don't have slots for the PCIe1.{0,1,2,3}),
so I can connect only one PCIe device (i.e a NIC card over PCIe, or a
SATA card over PCIe, or a USB controller over PCIe) per PCIe interface.

And the address decoding windows are associated to a PCIe interface
(through its x.y number). So for now, there is a one-to-one mapping
between a PCIe interface and a PCIe device, and therefore with an
address decoding window.

That said, I suppose that what you're thinking of are PCIe bridges, is
that correct? So those would allow to connect multiple PCIe devices on
a single PCIe interface (for example PCIe 3.0 listed above). In that
case, I suppose my address decoding window would have to have a size
greater than or equal to the sum of the size of all BARs of the PCIe
devices found on the downstream bus. Lior, could you confirm or infirm
my statement?

Does that answer your question?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
