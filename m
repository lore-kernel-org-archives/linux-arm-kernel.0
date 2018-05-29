From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Tue, 29 May 2018 17:46:21 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <1affd186-7f78-8bb0-050e-da82143c2982@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon>
 <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <19d68279-072e-7646-6fdd-8649578229ea@microchip.com>
 <20180529164911.29820e07@bbrezillon>
 <e3c34fb7-4881-3f49-b43b-1b07a8ab865d@microchip.com>
 <20180529171555.19dd723f@bbrezillon>
 <1affd186-7f78-8bb0-050e-da82143c2982@microchip.com>
Message-ID: <20180529174621.50a9001a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 May 2018 18:21:40 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> On 29.05.2018 18:15, Boris Brezillon wrote:
> > On Tue, 29 May 2018 18:01:40 +0300
> > Eugen Hristev <eugen.hristev@microchip.com> wrote:
> >   
> >> [...]
> >>
> >>  
> >>>
> >>> I think you're missing something here. We use the DMA engine in memcpy
> >>> mode (SRAM -> DRAM), not in device mode (dev -> DRAM or DRAM -> dev).
> >>> So there's no dmas prop defined in the DT and there should not be.
> >>>
> >>> Regards,
> >>>
> >>> Boris
> >>>      
> >>
> >> Ok, so the memcpy SRAM <-> DRAM will hog the transfer between DRAM and
> >> LCD if my understanding is correct. That's the DMA that Peter wants to
> >> disable with his patch ?
> >>
> >> Then we can then try to force NFC SRAM DMA channels to use just DDR port
> >> 1 or 2 for memcpy ?  
> > 
> > You mean the dmaengine? According to "14.1.3 Master to Slave Access"
> > that's already the case.
> > 
> > Only DMAC0 can access the NFC SRAM and it's done through DMAC0:IF0,
> > then access to DDR is going through port DDR port 1 (DMAC0:IF1) or 2
> > (DMAC0:IF0).  
> 
> If we can make NFC use port 1 only, then HLCDC could have two ports as 
> master 8 & 9, maybe a better bandwidth.

Peter, can you try with the following patch?

--->8---
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index ef3f227ce3e6..2a48e870f292 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -124,8 +124,8 @@
 #define        ATC_SIF(i)              (0x3 & (i))     /* Src tx done via AHB-Lite Interface i */
 #define        ATC_DIF(i)              ((0x3 & (i)) <<  4)     /* Dst tx done via AHB-Lite Interface i */
                                  /* Specify AHB interfaces */
-#define AT_DMA_MEM_IF          0 /* interface 0 as memory interface */
-#define AT_DMA_PER_IF          1 /* interface 1 as peripheral interface */
+#define AT_DMA_MEM_IF          1 /* interface 0 as memory interface */
+#define AT_DMA_PER_IF          0 /* interface 1 as peripheral interface */
 
 #define        ATC_SRC_PIP             (0x1 <<  8)     /* Source Picture-in-Picture enabled */
 #define        ATC_DST_PIP             (0x1 << 12)     /* Destination Picture-in-Picture enabled */
