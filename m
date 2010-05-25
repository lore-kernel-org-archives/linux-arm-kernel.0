From: stanley.miao@windriver.com (stanley.miao)
Date: Tue, 25 May 2010 18:05:52 +0800
Subject: [PATCH 3/6] davinci: edma: clear events in edma_start()
In-Reply-To: <871vd16wic.fsf@deeprootsystems.com>
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>	<1268841163-5868-4-git-send-email-khilman@deeprootsystems.com>	<4BFA6A22.1000006@windriver.com>
	<871vd16wic.fsf@deeprootsystems.com>
Message-ID: <4BFBA100.4020805@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> <snip>
>>>
>>>       
>> This patch causes that the sound can not work normally on OMAP_L138.
>>
>>     
>
> Can you describe "can not work normally"?  Does that mean simply does
> not work, or works with pops & clicks etc.?
>
> Just to clarify... how did you isolate it to this patch.
>
> If you revert just this patch on current davinci git, do you have
> working sound as you expect again?
>   
Below is the test result:

$/root> aplay audiodump.wav
Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo
aplay: pcm_write:1269: write error: Input/output error
$/root>

After revert it, the audio works fine.

Hi, Brian,

For the SPI issue, try this patch:
----------------------------------------
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -359,8 +359,10 @@ static void davinci_spi_dma_rx_callback(unsigned 
lch, u16 ch_status, void *data)
 
        if (ch_status == DMA_COMPLETE)
                edma_stop(davinci_spi_dma->dma_rx_channel);
-       else
+       else {
+               edma_stop(davinci_spi_dma->dma_rx_channel);
                edma_clean_channel(davinci_spi_dma->dma_rx_channel);
+       }
 
        complete(&davinci_spi_dma->dma_rx_completion);
        /* We must disable the DMA RX request */
@@ -380,8 +382,10 @@ static void davinci_spi_dma_tx_callback(unsigned 
lch, u16 ch_status, void *data)
 
        if (ch_status == DMA_COMPLETE)
                edma_stop(davinci_spi_dma->dma_tx_channel);
-       else
+       else {
+               edma_stop(davinci_spi_dma->dma_tx_channel);
                edma_clean_channel(davinci_spi_dma->dma_tx_channel);
+       }
 
        complete(&davinci_spi_dma->dma_tx_completion);
-------------------------------------------------

Stanley.

> Kevin
>
>   
