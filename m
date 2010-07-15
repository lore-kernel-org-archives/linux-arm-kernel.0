From: david.yangshuai@gmail.com (David Yang)
Date: Thu, 15 Jul 2010 17:13:57 +0800
Subject: Problem with dma_alloc_coherent at linux-2.6.33-arm1 , with RealView
	platform,board PBX-A9 and armv7 instructions.
Message-ID: <AANLkTimtpIQaKVHidWP9fvOKGGiQRc0tne1kO5mO-Zzs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi ,everybody:

       I encountered this problem when porting my ethernet driver from
linux-2.6.28 to linux-2.6.33-arm1.

       In the linux-2.6.28, I used the dma_alloc_coherent to share the
informations between cpu and ethernet device.The program flow in the
function ndo_start_xmit:
               1,preparing the struct sk_buff->data for device internal DMA to
read,using the dma_map_single function.
               2,update the information in the memory which is allocated by
dma_alloc_coherent to tell the device DMA the data is readable.
               3,write the device register to inform the device DMA
to read the data.
               4,cpu captures the interrupt of reading completion
form the device.

       In the linux-2.6.28,the whole program flow soon complete in order.
       But when the driver was ported to the linux-2.6.33-arm1,the problem
came:
                I found when the cpu executed from step 1-3, the
device DMA alarm the
step 2 was not completed.As a result,the step 4 was not triggered.This
is different form linux-2.6.28.

               After some tests, I think the problem comes from the
dma_alloc_coherent.It looks like ,in the linux-2.6.33-arm1, when the
memory allocated by dma_alloc_coherent is written,the data entry into
the ddr much slower than the same process in linux-2.6.28.Therefore,when
cpu has executed the step 3, the step 2 has not yet completed.So the DMA
can't get the correct information ,and the step 4 will never be reached.

       I don't know the reason until now.I guess the memory allocated by the
dma_alloc_coherent may be cached....if not , why it is so slowly?

 Thanks!
