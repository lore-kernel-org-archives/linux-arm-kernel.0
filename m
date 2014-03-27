From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 26 Mar 2014 22:40:54 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
References: <20140325202249.GA10378@obsidianresearch.com>
 <20140325213638.5aba54b6@skate>
 <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
Message-ID: <20140327044054.GA22681@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 27, 2014 at 12:29:32AM +0000, Neil Greatorex wrote:

> I then added an extra dev_info to print the ICR just after you read
> it in the loop, and get this:
> 
> [    0.137047] pci_bus 0000:01: scanning bus
> [    0.161098] mvebu-pcie pcie-controller.3: ICR is 808200
> [    0.162104] mvebu-pcie pcie-controller.3: ICR is 808201
> [    0.162191] pci_bus 0000:01: fixups for bus
 
> So it seems that the first time we have NFErrDet and PexLinkFail,
> and on the second time through the loop we have NFErrDet,
> PexLinkFail and TxReqInDIDownErr, so it then errors out of the loop.

Interesting, so that confirms that the PexLinkFail is real. So
something is triggering the link reset, either the Marvell PEX core is
doing it (but not telling us why) or the NIC is doing it (and that
would probably be non-compliant).

Looks like you need the sleep, but I'm not really sure how you'd
implement it in a generic way, and I'm puzzled why the time from the
bootloader starting the PEX to the kernel starting isn't sufficient
(is it really short?).

Maybe it is a similar problem to what Thomas figured out needed a
sleep, it would be interesting to see if the ICR has similar
information on Thomas's case too...

Try moving the 1 second sleep around:
 - In the boot loader after starting the PEX, but before loading the
   kernel
 - In the kernel, at the mvebu board setup function
 - In the kernel at the start of the mvebu pci driver probe
 - At various places in the mvebu pci driver between start of probe
   and the after the device id is iset

Basically - binary search to find where adding the sleep works, to try
and detmine exactly what code is starting the time clock.

Jason
