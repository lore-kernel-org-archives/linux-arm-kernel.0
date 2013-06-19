From: mark.retallack@siemens.com (Retallack, Mark)
Date: Wed, 19 Jun 2013 09:00:00 +0000
Subject: Atmel Serial driver PDC buffer handling issue
Message-ID: <3D029C603B477F4BAF0E9739E943D3FE087960@DEFTHW99EJ2MSX.ww902.siemens.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I hope this is the correct mailing list for this issue :)

We have found a small problem with the Atmel serial driver (drivers/tty/serial/atmel_serial.c) when using PDC. The problem showed itself on our system when it is heavily loaded and the softirq's are implemented as threads.

The DMA buffers (2 off) are dynamically allocated when the driver is initialized. The relative location of these buffers is down to the whims of the memory allocation software i.e. the buffers could be in contiguous memory or separated by a number of bytes.
What if the buffers are contiguous and the PDC managed to fill both buffers before the handling tasklet could run, the tasklet would be unable to identify this condition.

For example:
Assume DMA buffers A and B are both 0x200 bytes long and reside at addresses 0x100 and 0x300 respectively. Now also assume that the PDC has managed to fill both buffers starting with B then moving to A (at which point the PDC asserts the ENDRX and RXBUFF flags, resulting in the ENDRX interrupt). At this time the PDC has advanced the RPR to one byte beyond the end of buffer A i.e. address 0x200. 
When the tasklet runs, as far as it is concerned it is still processing buffer B. The first thing it does is to work out whether the PDC has completely filled buffer B, which it does by subtracting buffer B address from the RPR i.e. 0x200 - 0x200 = 0. So the tasklet believes that the buffer is empty rather than actually being full. In this event, the tasklet does not update RNPR and RNCR to inform the PDC that buffer B can now be used (side effect of which is that the ENDRX and RXBUFF flags remain set). When the tasklet reenables the ENDRX interrupt (when it exits) the UART immediately generates an interrupt (based on the ENDRX flag being set). The whole process then repeats while no further data is received.

I have attached a patch that fixes the issue. This is the first time I have submitted a patch, so please let me know if I did anything wrong. 


Thanks
Mark Retallack

Siemens AG
NWE RC-GB IC-MOL RCM ENG PD HWFW FW
Sopers Lane
BH17 7ER Poole, 
Tel: +44 1202 782189
Fax: +44 1202 782545
mailto:mark.retallack at siemens.com


-------------- next part --------------
A non-text attachment was scrubbed...
Name: atmel_serial_dma.patch
Type: application/octet-stream
Size: 3811 bytes
Desc: atmel_serial_dma.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/92952e79/attachment.obj>
