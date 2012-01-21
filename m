From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 21 Jan 2012 11:27:41 +0100
Subject: Adding support for DoC G3 on Motorola A780, some help needed.
In-Reply-To: <20120111014552.0dca6f3e34e2f24cf3a58f0f@studenti.unina.it>
 (Antonio Ospite's message of "Wed, 11 Jan 2012 01:45:52 +0100")
References: <20120111014552.0dca6f3e34e2f24cf3a58f0f@studenti.unina.it>
Message-ID: <87y5t1z6xu.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antonio Ospite <ospite@studenti.unina.it> writes:

> Hi Robert, LAK folks,
>
> I saw that a driver for the DoC G3 NAND chip has been added to linux-3.2
> (and write support is coming to 3.3, right?); some EZX phones like the
> Motorola A780 and E680 supported by OpenEZX[1] are using this chip
> AFAWK, but they also come with a NOR chip[2].
>
> Can you please give me some directions about adding support for the
> docg3 to the A780? The changes will look somewhat similar to the
> ones for the MIOA701[3], but we have the NOR too and I have some doubts.
>
> My questions are:
>   - How can I find out the resource to use? I can telnet to the
>     original firmware using linux-2.4.
The docg3 driver relies only on IOMEM resource. The chip itself has an adressing
space of 16 bits (ie. signals A15..A0). The normal setup with a docg3 is to tie
it to address 0, so that it can be used as the boot device.

That's what I would try first. If it doesn't work, it has to be one of the
static memory address space of your chip.

>   - What are the __raw_writel() calls in [3] for?
These are to setup the PXA memory controller, so that it knows that :
 - at address 0, there is a static chip, which is asynchronous static flash
 memory
 - the chip is slow (ie. the OE/WE/CS signals would be based on CLKMEM/4)
 - the chip has a 16 bits wide data bus

The full explanation of the important register is in [1].

>   - How are the partitions specified with the docg3 driver?
The docg3 is SAFTL partitionned (unless somebody overwrites that). There is
currently no support for SAFTL. All the knowledge I have is in :
 - http://belgarath.falguerolles.org/mioa701/mioa701.html
   => especially in docg3-saftl.html

Cheers.

--
Robert

[1]: Extract of the mioa701 IPL (under contruction)
	/*
	 * This is the configuration for nCS1/0 -> nothing / flash
	 * configuration for nCS1: nothing
	 * [31]    0    - RBUFF1: Slower Device
	 * [30:28] 111  - RR1: CS deselect to CS time: (7*2*MemClk + 1) = 20 ns
	 * [27:24] 1111 - RDN1: address to data valid in bursts: (30+1)*MemClk = 30 ns
	 * [23:20] 1111 - RDF1: for first access: (30+2)*MemClk = 130 ns
	 * [19]    0    - RBW1: 32 Bit bus width
	 * [18:16] 000  - RT1: burst RAM or FLASH
	 *
	 * configuration for nCS0 (DocG3 Flash floor 0):
	 * [15]    0    - RBUFF0: Slower Device
	 * [14:12] 010  - RRR0: CS deselect to CS time: 2*(2+1)*MemClk = 20 ns
	 * [11:08] 1101 - RDN0: Address to data valid in bursts: (20+1)*MemClk = xx ns
	 * [07:04] 1101 - RDF0: for first access: (20-1)*MemClk = xx ns
	 * [03]    1    - RBW0: 16 Bit bus width
	 * [02:00] 000  - RT0: asynchronous static FLASH
	 */
	MSC0 = 0x7ff02dd8;
