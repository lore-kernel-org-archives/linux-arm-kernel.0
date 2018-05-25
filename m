From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Fri, 25 May 2018 17:51:36 +0300
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
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
Message-ID: <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Peter,

On 04/11/2018 06:34 PM, Nicolas Ferre wrote:
> I'll try to move forward with your detailed explanation and with my 
> contacts within the "product" team internally.

We have talked with the hardware team, looks like there is an error in
the description of the Master to Slave Access matrix. CPU accesses DDR2
port0 through AXI matrix and not AHB. There is no conflict between CPU
and LCDC DMA when accessing DDR2 ports. This explains why using CPU
helps.

The slave numbers from "Table 14-3 Master to Slave Access" are wrong.
The 7th row  should be removed and all the other rows from below it,
shifted up with one level (DDR2 Port 1 is Slave no 7, DDR2 port 2 is
Slave no 8, ... , APB1 is slave no 11).

We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
(7th slave).

Also, some information about your configuration is useful. Can you
please tell us what NAND DMA configuration did you use?  Are you using
NAND storage for the videos that you are playing on the LCD screen?

Thanks,
ta
