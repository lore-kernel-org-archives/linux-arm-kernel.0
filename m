From: adam.cottrel@veea.com (Adam Cottrel)
Date: Tue, 16 Oct 2018 16:52:08 +0000
Subject: DMA remote memcpy requests
In-Reply-To: <DM6PR07MB4923F3328079199090D6D2CA9EFE0@DM6PR07MB4923.namprd07.prod.outlook.com>
References: <DM6PR04MB405938028EC04FBD07F3D96AF2E10@DM6PR04MB4059.namprd04.prod.outlook.com>
 <20181012090937.GA12289@arm.com>
 <DM6PR04MB4059742D494D96FC11674A50F2E20@DM6PR04MB4059.namprd04.prod.outlook.com>
 <b56bf98f-5055-fb85-7807-e45d495369f3@arm.com>,
 <DM6PR04MB405918E803AF4FCC34B12083F2FD0@DM6PR04MB4059.namprd04.prod.outlook.com>
 <DM6PR07MB4923F3328079199090D6D2CA9EFE0@DM6PR07MB4923.namprd07.prod.outlook.com>
Message-ID: <DM6PR04MB40591E6193F3B77698B09552F2FE0@DM6PR04MB4059.namprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sunil,

That is a great suggestion. Can someone advise on how to turn off the SMMU for testing purposes?

Best,
Adam

From: Goutham, Sunil <Sunil.Goutham@cavium.com> 
Sent: 16 October 2018 17:51
To: Adam Cottrel <adam.cottrel@veea.com>; Robin Murphy <robin.murphy@arm.com>; Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org; rric at kernel.org; Jan Glauber <Jan.Glauber@cavium.com>; Nair, Jayachandran <Jayachandran.Nair@cavium.com>; Goutham, Sunil <Sunil.Goutham@cavium.com>
Subject: Re: DMA remote memcpy requests

Hi Adam,

Is it possible for you to disable SMMU and do the same test ?
It might help in narrowing down whether transaction is lost at PCIeRC itself or
SMMU translation.

Thanks,
Sunil.


Sent from my Samsung Galaxy smartphone.


-------- Original message --------
From: Adam Cottrel <mailto:adam.cottrel@veea.com> 
Date: 15/10/2018 20:04 (GMT+05:30) 
To: Robin Murphy <mailto:robin.murphy@arm.com>, Will Deacon <mailto:will.deacon@arm.com> 
Cc: mailto:linux-arm-kernel at lists.infradead.org, mailto:rric at kernel.org, Jan Glauber <mailto:Jan.Glauber@cavium.com>, "Nair, Jayachandran" <mailto:Jayachandran.Nair@cavium.com>, "Goutham, Sunil" <mailto:Sunil.Goutham@cavium.com> 
Subject: RE: DMA remote memcpy requests 

External Email

Dear Robin/Jan/Will,

Any thoughts on what I can do to further diagnose the root cause?

Best,
Adam

> -----Original Message-----
> From: Robin Murphy <mailto:robin.murphy@arm.com>
> Sent: 12 October 2018 11:47
> To: Adam Cottrel <mailto:adam.cottrel@veea.com>; Will Deacon
> <mailto:will.deacon@arm.com>
> Cc: mailto:linux-arm-kernel at lists.infradead.org; mailto:rric at kernel.org;
> mailto:jglauber at cavium.com; mailto:jnair at caviumnetworks.com; mailto:sgoutham at cavium.com
> Subject: Re: DMA remote memcpy requests
>
> On 12/10/18 10:48, Adam Cottrel wrote:
> > Hi Will,
> >
> > Thank you for getting back to me.
> >
> >> [+Robin and Cavium folks -- it's usually best to cc people as well as
> >> mailing the list]
> > I will remember this for future. Thanks for the advice.
> >
> >>> I am using the ATH10K on Linux 14.4 with an Arm Cavium processor.
> >>> During heavy loading, I am seeing that target initiated DMA requests
> >>> are being silently dropped under extreme IO memory pressure and it
> >>> is proving very difficult to isolate the root cause.
> >>
> >> Is this ThunderX 1 or 2 or something else? Can you reproduce the
> >> issue with mainline?
> > I am using:-
> >????????? model = "Cavium ThunderX CN81XX board";
> >????????? compatible = "cavium,thunder-81xx";
> >
> > Yes - the issue can be reproduced on the mainline, but here is a link
> > to the code branch that I am using:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k
> >
> >>> The ATH10K firmware uses the DMA API to set up phy_addr_t pointers
> >>> (32-bit) which are then copied to a shared ring buffer. The target
>
> That's the first alarm bell - phys_addr_t is still going to be 64-bit on any arm64
> platform. If the device is expecting 32-bit addresses but somehow doesn't
> have its DMA mask set appropriately, then if you have more than 3GB or so
> of RAM there's the potential for addresses to get truncated such that the
> DMA *does* happen, but to the wrong place.
>
> However, with SMMU translation enabled (i.e. not just passthrough), then
> I'd expect that same situation to cause more or less all DMA to fail, so if
> you've successfully tested that setup it must be something much more
> subtle :/
>
> >>> then initiates the memcpy operation (for target-to-host reads), but
> >>> I do not have any means of debugging the target directly, and so I
> >>> am looking for software hooks on the host that might help debug this
> >>> complex
> >> problem.
> >>
> >> How does the firmware use the DMA API, or are you referring to a
> >> driver? If the latter, could you point us to the code, please? Is it
> >> using the streaming API, or is this a coherent allocation?
> > The code is using the ARM64 DMA API. It cuts corners in places (!!) but for
> the most part, it follows the rules. In local tests, I have added memory
> barriers (e.g. dmb(SY)) and even put in low-level flush/invalidate calls (DC
> CIVAC) to try and eliminate cache-coherency type problems.
> >
> > The receive fault can be observed in the Rx handler which can be found
> > on line 528 of ce.c:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k/ce.c
> >
> > The memory is allocated by the Rx post buffer function which is on
> > line 760 of pci.c:-
> > https://elixir.bootlin.com/linux/v4.14.4/source/drivers/net/wireless/a
> > th/ath10k/pci.c
> >
> > To better observe the fault, I made the following change:-
> >?? + On allocation, I use memset to clear the skb->data (pci.c::770)
> >?? + On receive, I check that the data is not zero (ce.c::555)
> >?? + If the data is not yet written, I exit the Rx IRQ handler and try again.
> >
> > In tests, the code works as expected under normal operation, however
> once I start to simulate a heavy memory pressure situation then the Rx
> handler starts to fail. This failure (if allowed to continue) will eventually tear
> down the entire module and crash the target firmware because presumably
> they are seeing similar dropouts on the transmit path.
> >
> > When the fault is happening, if I poll the target registers (e.g. write
> counters over MMIO) I can see that they are still sending us new messages.
> In other words, they have silently failed to send the data, or rather we have
> silently failed to accept the memory copy. I am not able to access the target
> firmware directly, but I have been reliably informed that the DMA memcpy
> operation is initiated by the target.
> >
> > My memory pressure test uses a large dd copy to create a lot of dirty
> memory pages. This always creates the fault, however without any memory
> pressure the code runs beautifully...
>
> Are you able to characterise whether it's actually the memory pressure itself
> that changes the behaviour (e.g. difficulty in allocating new SKBs), or is it just
> that there's suddenly a lot more work going on in general? Those aren't
> exactly the most powerful CPU cores, and with only
> 2 or 4 of them it doesn't seem impossible that the system could simply get
> loaded to the point where it can't keep up and starts dropping things on the
> floor.
>
> Robin.
>
> >>> Please can someone explain the low-level operation of DMA once it
> >>> becomes a target initiated memcpy function?
> >>
> >> I think we need a better handle on the issue first.
> >
> > I fully agree - please tell me what you want to know :-D
> >
> >>> p.s. I have tested with and without the IOMMU, and I have eliminated
> >>> issues such as cache coherency being the root cause.
> >>
> >> Right, not sure how the SMMU would help here.
> >
> > Understood, and thanks for taking the time to reply, and I look forward to
> hearing your thoughts as I would like to fix this issue once and for all.
> >
> > Best,
> > Adam
> >
