From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jul 2013 14:46:59 +0100
Subject: linux startup
In-Reply-To: <CANEcUBWUFA=nmoCOUbLPa=vfbfcaqaC=FStG_4hgk1oHR+mgYg@mail.gmail.com>
References: <CANEcUBWUFA=nmoCOUbLPa=vfbfcaqaC=FStG_4hgk1oHR+mgYg@mail.gmail.com>
Message-ID: <20130722134659.GM24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 09:30:44PM +0800, zhaobin xv wrote:
> Hi
> I recently read lernel source .
> I have a question:In
> folder:linux/arch/arm/boot/compressed/head.S(linux2.6.22.6):
> 
> 
> start:
>         .type    start,#function
>         .rept    8
>         mov    r0, r0
>         .endr
> 
>         b    1f
>         .word    0x016f2818        @ Magic numbers to help the loader
>         .word    start            @ absolute load/run zImage address
>         .word    _edata            @ zImage end address
> 1:        mov    r7, r1            @ save architecture ID
>         mov    r8, r2            @ save atags pointer
> 
> 
> I don't kown why the ?mov r0 r0 ? repeated  emergence 8 times.

(a) boot loaders used to call the kernel at an offset of 32 bytes into
the image, but now call at the start of the image.
(b) the magic numbers are placed at a fixed position.

So we need to fill the first 8 words with something.  They could have
all been branches to '1f' instead of that instruction.  It makes little
difference.
