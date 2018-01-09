From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 9 Jan 2018 07:36:11 +0000
Subject: [PATCH v2 1/4] dmaengine: xilinx_dma: populate dma caps properly
In-Reply-To: <20180109050449.GO18649@localhost>
References: <1514961731-1916-1-git-send-email-appanad@xilinx.com>
 <1514961731-1916-2-git-send-email-appanad@xilinx.com>
 <20180108103845.GE18649@localhost>
 <CY1PR02MB1692EB7A4E66BA30A8E0DB45DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180108170655.GJ18649@localhost>
 <CY1PR02MB16922B2D20C958D8214F7A23DC130@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180109044858.GN18649@localhost>
 <CY1PR02MB1692292DE4B4F346B92BD4EBDC100@CY1PR02MB1692.namprd02.prod.outlook.com>
 <20180109050449.GO18649@localhost>
Message-ID: <CY1PR02MB1692ED5378E474DB42A9CD7ADC100@CY1PR02MB1692.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	Thanks for the review... 

>On Tue, Jan 09, 2018 at 04:48:10AM +0000, Appana Durga Kedareswara Rao
>wrote:
>> Hi,
>>
>> >On Mon, Jan 08, 2018 at 05:25:01PM +0000, Appana Durga Kedareswara
>> >Rao
>> >wrote:
>> >> Hi,
>> >>
>> >> <Snip>
>> >> >> >> +	xdev->common.dst_addr_widths = BIT(addr_width / 8);
>> >> >> >> +	xdev->common.src_addr_widths = BIT(addr_width / 8);
>> >> >> >
>> >> >> >Do you not support trf of 1byte, 2 bytes, or 4 bytes wide transfers?
>> >> >> >What is value of addr_width here typically? Usually controllers
>> >> >> >can support different widths and this is a surprise that you
>> >> >> >support only one value
>> >> >>
>> >> >> Controller supports address width of 32 and 64.
>> >> >
>> >> >Then this should have both 32 and 64 values here
>> >>
>> >> Address width is configurable parameter at the h/w level.
>> >> Since this IP is a soft IP user can create a design with either
>> >> 32-bit or 64-bit address configuration.
>> >
>> >and not both right?
>>
>> Yes not both at the same time...
>> Axi dma controller can be configured for either 32-bit or 64-bit address...
>
>So my suspicion was correct.  I would suggest you to read up on the
>documentation again. The src/dst_addr_widths has _nothing_ to do with 32/64
>bit addresses used.
>
>It is the capability of the dma controller to do transfers with data width as 8bits,
>16 bits, so on. iKey is "data width" and not address type.
>This typically translates to DMA FIFO configuration of the controller!

Thanks for the detailed explanation... 
I have gone through the spec again controller does supports 1 byte, 2 byte, 4 byte up to 128 byte transfers.
In order to do variable length transfers user needs to drive a valid value to the tkeep strobe signal at the h/w level.
And user needs to configure the below parameters c_m_axis_mm2s_tdata_width or c_m_axis_s2mm_tdata_width
With desired configuration at the h/w level.
Controller supports data width of 8, 16, 32, 64, 128, 256, 512 and 1,024 bits 
(i.e. c_m_axis_mm2s_tdata_width/ c_m_axis_s2mm_tdata_width parameters range)

At the s/w level currently we are getting c_m_axis_mm2s_tdata_width/ c_m_axis_s2mm_tdata_width
Configuration as xlnx,datawidth property in the device-tree.

So proper values for the src/dst_addr width fields should be, datawidth property in bytes.
Please correct me if I am wrong... 

Changes looks like below...
Here width is in bytes based on the h/w configuration... 

--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2411,6 +2411,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
                chan->direction = DMA_MEM_TO_DEV;
                chan->id = chan_id;
                chan->tdest = chan_id;
+               xdev->common.directions = BIT(DMA_MEM_TO_DEV);
+               xdev->common.src_addr_widths = BIT(width);
 
                chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
                if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2428,6 +2430,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
                chan->direction = DMA_DEV_TO_MEM;
                chan->id = chan_id;
                chan->tdest = chan_id - xdev->nr_channels;
+               xdev->common.directions |= BIT(DMA_DEV_TO_MEM);
+               xdev->common.dst_addr_widths = BIT(width);
 
                chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
                if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {


Regards,
Kedar.

>
>--
>~Vinod
