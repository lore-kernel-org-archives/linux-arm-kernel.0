From: peda@axentia.se (Peter Rosin)
Date: Mon, 28 May 2018 00:11:07 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
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
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
Message-ID: <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-27 11:18, Peter Rosin wrote:
> On 2018-05-25 16:51, Tudor Ambarus wrote:
>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>> (7th slave).
> 
> Exactly how do I accomplish that?
> 
> I can see how I can move the LCD between slave DDR port 2 and 3 by
> selecting LCDC DMA master 8 or 9 (but according to the above it should
> not matter). The big question is how I control what slave the NAND flash
> is going to use? I find nothing in the datasheet, and the code is also
> non-transparent enough for me to figure it out by myself without
> throwing out this question first...

I added this:

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e686fe73159e..3b33c63d2ed4 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1991,6 +1991,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
 		nc->dmac = dma_request_channel(mask, NULL, NULL);
 		if (!nc->dmac)
 			dev_err(nc->dev, "Failed to request DMA channel\n");
+
+		dev_info(nc->dev, "using %s for DMA transfers\n",
+			 dma_chan_name(nc->dmac));
 	}
 
 	/* We do not retrieve the SMC syscon when parsing old DTs. */



and the output is

atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers

So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
or how to find out. I guess IF2 is not in use since that does not allow any
DDR2 port as slave...

>From the datasheet, DMAC0/IF0 uses DDR2 Port 2, and DMAC0/IF1 uses DDR2 Port 1.
But, by the looks of the register content in my other mail, it seems as if
DMA0/IF1 can also use DDR2 Port 3.

So, I think I want either

A) the NAND controller to use DMAC0/IF0 (i.e. DDR2 port 1, and possibly 3) and
   the LCDC to use master 9 (i.e. DDR2 Port 2)

or

B) the NAND controller to use DMAC1/IF1 (i.e. DDR2 port 2) and the LCDC to use
   master 8 (i.e. DDR2 Port 3)

But, again, how do I limit DMAC0 to either of IF0 or IF1 for NAND accesses?

Note that I have previously tried to move LCDC DMA from master 8 (the default)
to master 9, and it got better, but not good enough. I.e. the visual glitches
remained, but were a little bit harder to trigger. That makes me suspect DMAC0
uses both IF0 and IF1 for its DMAs, but that it prefers IF0.

Cheers,
Peter
