From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 27 Mar 2014 20:04:05 -0600
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
References: <CAAfodu3RmoN9MYNahwv2kLz5=GvZvK6G9fJorsyVgU8C0J-NEg@mail.gmail.com>
 <20140325222404.GC14718@obsidianresearch.com>
 <20140325223510.GD14718@obsidianresearch.com>
 <CAAfodu3HuzBCAc3r=PPufjrFhEKUQK2b_WRow=GJuC6hSqiuKw@mail.gmail.com>
 <20140326201243.GA1536@obsidianresearch.com>
 <CAAfodu0xZ0V8ikJMT1Z+0JSLeD+nezWAcGNF2_ryvad5tsVDWA@mail.gmail.com>
 <20140326214259.GA12330@obsidianresearch.com>
 <alpine.DEB.2.10.1403270025160.1545@vroombuntu>
 <20140327044054.GA22681@obsidianresearch.com>
 <alpine.DEB.2.10.1403280056250.4521@vroombuntu>
Message-ID: <20140328020405.GA1159@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 01:03:55AM +0000, Neil Greatorex wrote:

> With the help you've given, I think I've identified what the problem
> is. It is basically what Thomas suggested the problem was (that he'd
> seen with the Armada 38x). The call to mvebu_pcie_set_local_dev_nr
> causes the PCIe link to reset. In my tests with this Intel card, it
> takes ~25ms for the link to go down, and then another ~13ms for it
> to come back up.

Wow, fascinating - not only does the link go down, but it takes 25ms,
and it seemed based on the patch I sent you, that the first config op
triggers this reset immediately..

If I have time I'll look in the spec, maybe the devnumber is encoded
in low level flow control packets or something that makes sense of
this..

What does your kernel boot log look like? Does the USB PEX link behave
the same?? Presumably it happens faster?

A different option would be to force the link down, then change the
dev number, then bring it back up. At least that way the process is
under the control of the driver and we are not waiting for the
mysterious 25 ms. Or maybe change the dev number, then trigger a
link reset...

> I have put together a patch below that I would be interested to get
> your opinions on and also for you to test against any cards you may
> have. I only have the one mini PCIe card so it's not a great test!

Unfortunately my systems here never boot with the PEX up so I cannot
easily verify..

One suggestion about the patch I have is to move everything you added
into the mvebu_pcie_set_local_dev_nr function and bail if the
devnumber is already correct. That way the bootloader could set it
properly and avoid this.

Regards,
Jason
