From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 6 Nov 2013 19:03:08 +0100
Subject: address translation for PCIe-to-localbus bridge
In-Reply-To: <20131106173649.GA25515@obsidianresearch.com>
References: <527A1983.6020603@keymile.com>
 <20131106173649.GA25515@obsidianresearch.com>
Message-ID: <20131106190308.01f7a4a9@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

(Adding a bunch of mvebu people in Cc)

On Wed, 6 Nov 2013 10:36:49 -0700, Jason Gunthorpe wrote:

> Thomas: There is one buglet here that I haven't had time to do
> anything about. Notice the DT is listing the PEX memory window in its
> ranges. I've done this for two reasons
>  - The bootloader sets this address range up, so it is correct to
>    include in the DT

The fact that the bootloader sets this MBus window is more-or-less
irrelevant because when the mvebu-mbus driver is initialized, it
completely clears *all* existing MBus windows:

   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mvebu-mbus.c#n722

Therefore, when the kernel starts, what the bootloader may have set up
in terms of MBus windows is irrelevant.

>  - The address translation machinery requires it, otherwise we can't
>    translate addreses of the non-PCI sub devices (eg gpio3)

Right.

> The latter is a kernel issue. As we discussed when mbus was first put
> together something needs to make the ranges consistent with the actual
> mapping so that address translation works. IIRC people objected to
> actually changing the ranges at runtime, so the alternate mechanism of
> hooking the address translation seems necessary?

I indeed remember some objections, but I'm not sure what they were
precisely. Maybe we didn't had a precise use case back at the time, to
really make people objecting realize what the problem was?

On the other hand, I think the of_*() API is quite limited when it
comes to updating the DT. If I remember correctly, you can update some
nodes, but you can never reclaim the memory that was used for the
previous value of the node. So any change to the in-memory DT
representation is basically a memory leak for the entire lifetime of
the system (of course, I might be wrong on this, I haven't dived into
all the hardcore details of DT manipulation in the kernel).

I'm not sure what would be the alternate mechanism to hook into the
address translation. of_translate_one(), where all the translation
through ranges takes place is really tied to the DT only, adding
another mechanism to hook some custom address translation in there
seems a bit weird, no?

> Unfortunately if you add the ranges then the mbus driver throws a
> warning that it is trying to overwrite existing windows, but otherwise
> things work OK.

Yes, because at boot time the mvebu-mbus driver will set up windows for
the statically defined ranges (the one you've written explicitly in the
DT), and then later one when the PCIe driver will initialize, it will
enumerate devices, realize that it needs a PCIe memory window, and ask
the mvebu-mbus driver to create, which will fail because an overlapping
window already exists.

However, it just works by pure luck: nothing guarantees you that the
PCIe 0 memory window will start at 0xe0000000. Of course, since you
have only one PCIe interface enabled, you have a guarantee from one
boot to another. But in the general case, if you have several PCIe
interfaces, on which you may plug/unplug different devices, you have no
guarantee a priori as to what will be the base address of the PCIe
memory window for a given PCIe interface.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
