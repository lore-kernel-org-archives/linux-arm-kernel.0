From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jun 2011 17:32:10 +0100
Subject: TI-Davinci 6446 oops on interrupts
In-Reply-To: <alpine.LFD.2.02.1106061518480.13964@ionos>
References: <4DECCADE.6080100@selfish.org>
	<alpine.LFD.2.02.1106061518480.13964@ionos>
Message-ID: <20110606163210.GC7448@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 04:49:59PM +0200, Thomas Gleixner wrote:
> 0000014c <irq_gc_mask_clr_bit>:
>  14c:   e5903014        ldr     r3, [r0, #20]
>  150:   e590c000        ldr     ip, [r0]
>  154:   e5932004        ldr     r2, [r3, #4]
>  158:   e593100c        ldr     r1, [r3, #12]
>  15c:   e062200c        rsb     r2, r2, ip
>  160:   e3a0c001        mov     ip, #1
>  164:   e1c1221c        bic     r2, r1, ip, lsl r2
>  168:   e583200c        str     r2, [r3, #12]
>  16c:   e590000c        ldr     r0, [r0, #12]
>  170:   e5931000        ldr     r1, [r3]
>  174:   e5903064        ldr     r3, [r0, #100]  ; 0x64
>  178:   e7812003        str     r2, [r1, r3]
>  17c:   e12fff1e        bx      lr
> 
> So it's the "str r2, [r1, r3]" and obviously r1 is pointing into
> nirwana. r3 makes me wonder as well. We write 0x18 into ct->regs.mask
> because we add 0x04 to the base pointer. So where comes the 0x1c from?

Beware - I don't think you can build the file and work out what went
wrong in this manner.  Compilers like to change their register
allocation for even the slightest difference of compiler options
and preceding _unrelated_ code.

Unless we have the Code: line we don't know what the code being executed
was.  It's important that folk always report the entire oops dump, not
extracts from it that they _think_ may be relevant.
