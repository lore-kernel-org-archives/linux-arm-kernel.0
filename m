From: peda@axentia.se (Peter Rosin)
Date: Sat, 26 May 2018 19:40:42 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
Message-ID: <d930349b-ed0a-507a-6ba6-00925f0a4136@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-25 16:51, Tudor Ambarus wrote:
> Hi, Peter,
> 
> On 04/11/2018 06:34 PM, Nicolas Ferre wrote:
>> I'll try to move forward with your detailed explanation and with my 
>> contacts within the "product" team internally.
> 
> We have talked with the hardware team, looks like there is an error in
> the description of the Master to Slave Access matrix. CPU accesses DDR2
> port0 through AXI matrix and not AHB. There is no conflict between CPU
> and LCDC DMA when accessing DDR2 ports. This explains why using CPU
> helps.
> 
> The slave numbers from "Table 14-3 Master to Slave Access" are wrong.
> The 7th row  should be removed and all the other rows from below it,
> shifted up with one level (DDR2 Port 1 is Slave no 7, DDR2 port 2 is
> Slave no 8, ... , APB1 is slave no 11).

Yes, the fact that row 7 (the 8th row, since there is a row 0, but I get
what you mean) should be removed was pretty much what I had guessed. But
what about the other strange things I found? To reiterate, this is my
PRxSy register content (zeroes shown as -):

PRxS0  33--3--3--3333--
PRxS1  33--3--3--3333--
PRxS2  33--------------
PRxS3  -3--------333---
PRxS4  33--------------
PRxS5  3---------------
PRxS6  33--33-33333333-
PRxS7  --3-3--3--------
PRxS8  -3---3--3--3----
PRxS9  --3-3--3-33-333-
PRxS10 3--3------------
PRxS11 3-----3---------
PRxS12 ----------------
PRxS13 ----------------
PRxS14 ----------------
PRxS15 ----------------

So, PRxS7 matches row 8 (DDR2 port 1) in the datasheet.
And PRxS8 matches row 9 (DDR2 port 2) in the datasheet.
But PRxS9 is not matching row 10 (DDR2 port 3)!
And PRxS10-11 match rows 11-12 (APB 0-1) in the datasheet.

But also look at PRxS3 (Internal ROM), there's a missing 3 in the
first slot (A5)! Maybe the priority of that one can't be changed
for some fundamental reason? But there is no hint to that effect
in the datasheet AFAICT...

> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
> (7th slave).

I think I tried to arrange for that last time around. Not sure though,
so I will try again next week...

> Also, some information about your configuration is useful. Can you
> please tell us what NAND DMA configuration did you use?  Are you using
> NAND storage for the videos that you are playing on the LCD screen?

Not sure what level of detail you are after?

We use W949D2CBJX5E LPDDR1 memories from Winbond. Years ago, I wrote some
LPDDR1 patches for at91bootstrap to driver/ddramc.c (which predate the
current upstream support) and to board/sama5d3xek/sama5d3xek.c (which doesn't
to this day support LPDDR1 upstream, but I guess it shouldn't and that we
should have a board of our own, so that part isn't really clean and also the
reason I never upstreamed it). Anyway, some other trivial glue was also
needed, but the meat are in those files. I just had a brief look at the
LPDDR1 support in the upstream ddramc.c file and our code is very similar.
But I did notice some differences and I will look into if that difference
is something that matters. I can show provide patches if you think they
are relevant?

We use this in the sam-ba .qml file when we flash the devices with sam-ba and
the nandflash applet (don't know if it's relevant, but it shows that we have
a 16-bit bus):

        device: SAMA5D3 {
		name: "sama5d3-linea"

		aliases: []

		description: "SAMA5D3 Linea"

		config {
			nandflash {
				ioset: 1
				busWidth: 16
				header: 0xc0902405
			}
		}
	}

*time passes*

Oh dear ... you said NAND *DMA* configuration. Nothing special that I know
of. So, the default? Anything specific I should check?

Further, we are not playing any video. The artifacts are visible on a
static screen on an otherwise "idle" system (i.e. just showing whatever
on the screen and accessing the DRAM with DMA is enough to trigger the
visual glitches).

Cheers,
Peter
