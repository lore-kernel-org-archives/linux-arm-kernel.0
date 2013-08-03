From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 3 Aug 2013 10:01:10 -0400 (EDT)
Subject: [PATCH v2 4/6] ARM: mm: LPAE: Correct virt_to_phys patching for
 64 bit physical addresses
In-Reply-To: <51FCFBE1.5090000@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <1375289086-5315-5-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022156120.14472@syhkavp.arg> <51FCFBE1.5090000@ti.com>
Message-ID: <alpine.LFD.2.03.1308030943320.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 3 Aug 2013, Sricharan R wrote:

> On Saturday 03 August 2013 08:58 AM, Nicolas Pitre wrote:
> > ... meaning that, instead of using 0x81 for the stub value on the mov 
> > instruction, it only has to be 0x83.  Bits 7 and 0 still act as anchors 
> > for the rotation field in the opcode, while bit 1 indicates which value 
> > to patch in.
>   I started with this kind of augmenting with the immediate operand
>   while starting V2. But the problem was, we do the runtime patching twice.

Ahhh... Bummer.

>   Once while booting from low address alias space and
>   other while switching to higher memory address. So in this
>   case, the augmented bits are lost after doing the patching for
>   the first time. So the augmented bits are not valid while trying
>   to patch for second time.
> 
>   This was the reason, i thought of using opcodes which
>   is always there.

In which case you only have to look for a mov.

Better yet: just look at the rotate field in the shifter operand.  If it 
is 0 then it is the __PV_BITS_8_0 case, if it is non zero then it is the 
__PV_BITS_31_24 case.


Nicolas
