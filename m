From: adam.cottrel@veea.com (Adam Cottrel)
Date: Fri, 12 Oct 2018 09:48:01 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <20181012090937.GA12289@arm.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
Message-ID: <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thank you for getting back to me.

> [+Robin and Cavium folks -- it's usually best to cc people as well as  mailing
> the list]
I will remember this for future. Thanks for the advice.

> > I am using the ATH10K on Linux 14.4 with an Arm Cavium processor.
> > During heavy loading, I am seeing that target initiated DMA requests
> > are being silently dropped under extreme IO memory pressure and it is
> > proving very difficult to isolate the root cause.
> 
> Is this ThunderX 1 or 2 or something else? Can you reproduce the issue with
> mainline?
I am using:-
        model = "Cavium ThunderX CN81XX board";
        compatible = "cavium,thunder-81xx";

Yes - the issue can be reproduced on the mainline, but here is a link to the code branch that I am using:-
https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/ath/ath10k

> > The ATH10K firmware uses the DMA API to set up phy_addr_t pointers
> > (32-bit) which are then copied to a shared ring buffer. The target
> > then initiates the memcpy operation (for target-to-host reads), but I
> > do not have any means of debugging the target directly, and so I am
> > looking for software hooks on the host that might help debug this complex
> problem.
> 
> How does the firmware use the DMA API, or are you referring to a driver? If
> the latter, could you point us to the code, please? Is it using the streaming
> API, or is this a coherent allocation?
The code is using the ARM64 DMA API. It cuts corners in places (!!) but for the most part, it follows the rules. In local tests, I have added memory barriers (e.g. dmb(SY)) and even put in low-level flush/invalidate calls (DC CIVAC) to try and eliminate cache-coherency type problems.

The receive fault can be observed in the Rx handler which can be found on line 528 of ce.c:-
https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/ath/ath10k/ce.c

The memory is allocated by the Rx post buffer function which is on line 760 of pci.c:-
https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/ath/ath10k/pci.c

To better observe the fault, I made the following change:-
 + On allocation, I use memset to clear the skb->data (pci.c::770)
 + On receive, I check that the data is not zero (ce.c::555)
 + If the data is not yet written, I exit the Rx IRQ handler and try again.

In tests, the code works as expected under normal operation, however once I start to simulate a heavy memory pressure situation then the Rx handler starts to fail. This failure (if allowed to continue) will eventually tear down the entire module and crash the target firmware because presumably they are seeing similar dropouts on the transmit path.

When the fault is happening, if I poll the target registers (e.g. write counters over MMIO) I can see that they are still sending us new messages. In other words, they have silently failed to send the data, or rather we have silently failed to accept the memory copy. I am not able to access the target firmware directly, but I have been reliably informed that the DMA memcpy operation is initiated by the target.

My memory pressure test uses a large dd copy to create a lot of dirty memory pages. This always creates the fault, however without any memory pressure the code runs beautifully...

> > Please can someone explain the low-level operation of DMA once it
> > becomes a target initiated memcpy function?
> 
> I think we need a better handle on the issue first.

I fully agree - please tell me what you want to know :-D

> > p.s. I have tested with and without the IOMMU, and I have eliminated
> > issues such as cache coherency being the root cause.
> 
> Right, not sure how the SMMU would help here.

Understood, and thanks for taking the time to reply, and I look forward to hearing your thoughts as I would like to fix this issue once and for all.

Best,
Adam
