From: w@1wt.eu (Willy Tarreau)
Date: Tue, 25 Mar 2014 22:03:04 +0100
Subject: Intel I350 mini-PCIe card (igb) on Mirabox (mvebu / Armada 370)
In-Reply-To: <20140325212010.17711434@skate>
References: <CAAfodu1eC6=mKwfowW6bmTtf_DcOL_oNQg77kSz+ykfHkMTN-w@mail.gmail.com>
 <20140325212010.17711434@skate>
Message-ID: <20140325210304.GD19862@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 25, 2014 at 09:20:10PM +0100, Thomas Petazzoni wrote:
> Willy Tarreau has also reported issues with igb cards on Marvell
> platforms using the pci-mvebu driver. I think in his case the card was
> detected even at boot time, but he had similar MSI-X issues later on.

To be precise on this, originally the card was not detected at all,
neither by the kernel nor by U-Boot. But one of your patches to
renumber the PCI end points made it appear and work well. Later,
the MSI-X issue surfaced after the following patch was merged :

   36dd1f3 PCI: mvebu: Disable prefetchable memory support in PCI-to-PCI bridge

Reverting it solves the issue but as we discussed, doing this is
just a workaround as the patch is fine. I tracked down the oops
to be caused by something related to the NIC failing to register
an MSI-X interrupt for both ports but one only, trying to rollback
to do MSI only for both ports and there failing on this part which
dereferences the pointer returned in *value that's zero while it
used to be -1 before the patch. That's all I know, I added maybe
200 printks all around but don't know the PCI code and did not have
enough time to track it down further nor to make a detailed bug
report. I don't even know whether it's what the NIC driver does,
what the PCI stack does or what the MVEBU PCI driver does which is
at fault, or even any combination of them.

In the mean time if you want to test your NIC, try reverting the
patch above, but keep in mind that without this patch, other NICs
were reported to fail in some conditions (realtek IIRC).

Regards,
Willy
