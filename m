From: gradator@gradator.net (Sylvain Rochet)
Date: Tue, 22 Oct 2013 16:44:20 +0200
Subject: BUG: Atmel AT91 LCD Blanking hang (atmel_hlcdfb)
Message-ID: <20131022144420.GA12871@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Kernel used: linux-3.10.y stable Git branch (currently 3.10.17)
  + linux-3.10-at91 Git branch

# echo "4" > /sys/class/graphics/fb0/blank 
never ends

atmel_lcdfb_core.c, atmel_lcdfb_blank() calls atmel_hlcdfb.c, 
atmel_hlcdfb_stop() which waits for ATMEL_LCDC_BASEISR.LCDC_BASEISR_DMA 
to be set if ATMEL_LCDC_STOP_NOWAIT flag is not set.

But it never happens, thus atmel_hlcdfb_stop() is going to wait 
indefinitely. It never happens because ATMEL_LCDC_BASEISR status 
register is cleared upon reading and interrupt routine 
atmel_hlcdfb_interrupt() is also reading the same register. Any 
triggered interrupt will clear this DMA bit while atmel_hlcdfb_stop() is 
currently msleep()ing.

The issue does not seem obvious to fix for me, since it requires some 
synching between the interrupt handler and the userland request to 
blank. I am not proud of, but I currently fixed the issue by asserting 
the ATMEL_LCDC_STOP_NOWAIT flag to all atmel_hlcdfb_stop() calls. I 
attached the patch for reference purposes, but it is broken since it 
also change the atmel_lcdfb.c behavior, hardware I don't have and which 
probably doesn't need to be fixed.

Anyway, I am not a design guru, but reading a register which clears 
itself at reading at two or more locations should probably be something 
to avoid.

Regards,
Sylvain
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0000_atmel_lcdfb_core_no_wait_dma_while_blanking.patch
Type: text/x-diff
Size: 768 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/4d6fe2d6/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131022/4d6fe2d6/attachment.sig>
