From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 11:20:41 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20171102112041.GW9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 11:06:54AM +0000, Chris Brandt wrote:
> On Wednesday, November 01, 2017 1, Nicolas Pitre wrote:
> > > > This patch worked for me.
> > > > I get my carriage returns again.
> > >
> > > Sorry, but no.  This is crap.
> > >
> > > The kernelci.org test resulting from the tree I pushed out this evening
> > > with both of the patches in is very unhappy:
> > >
> > >      42  arch/arm/kernel/debug.S:98: Error: immediate expression
> > requires a # prefix -- `mov r1,10'
> > >      42  arch/arm/kernel/debug.S:94: Error: immediate expression
> > requires a # prefix -- `mov r1,13'
> > >
> > > I can't believe that anyone actually build-tested this patch as it
> > > stands - maybe, Chris, you just think you did but you ended up
> > > testing something else?  Or maybe your binutils is broken because
> > > it now accepts constants without the preceding '#' ?
> > 
> > Well... I don't know what happened with Chris' testing either.
> 
> 
> So, just to show I'm not crazy...
> 
> 
> # Yes, patch was applied:
> $ grep "mov        r1" arch/arm/kernel/debug.S
> 		mov	r1, #8
> 		mov	r1, #4
> 		mov	r1, #2
> 		mov	r1, #0
> 		mov	r1, '\r'    <<<<<<<<<<
> 		mov	r1, '\n'    <<<<<<<<<<
> 		mov	r1, r0
> 		mov	r1, r0
> 
> # Yes it builds:
> $ touch arch/arm/kernel/debug.S
> $ make -j8 O=.out uImage LOADADDR=0x08008000
> make[1]: Entering directory '/home/renesas/tools/upstream/renesas-drivers/.out'
>   CHK     include/config/kernel.release
>   GEN     ./Makefile
>   CHK     include/generated/uapi/linux/version.h
>   CHK     scripts/mod/devicetable-offsets.h
>   UPD     include/config/kernel.release
>   Using .. as source for kernel
>   CHK     include/generated/utsrelease.h
>   UPD     include/generated/utsrelease.h
>   CHK     include/generated/timeconst.h
>   CHK     include/generated/bounds.h
>   CHK     include/generated/asm-offsets.h
>   CALL    ../scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   CC      init/version.o
>   AS      arch/arm/kernel/debug.o       <<<<<<<<<<
> 
> 
> # Have a look at the output:
> $ arm-linux-gnueabihf-objdump -SdCg .out/arch/arm/kernel/debug.o > /tmp/debug.lst
> $ cat /tmp/debug.lst
> 
> ------------------------------------------------------------
>                 mov     r1, '\r'           <<<<<<<<<<
>   70:   f04f 010d       mov.w   r1, #13    <<<<<<<<<<
>                 waituart r2, r3
>   74:   8a1a            ldrh    r2, [r3, #16]
>   76:   f012 0f20       tst.w   r2, #32
>   7a:   d0fb            beq.n   74 <printascii+0x2c>
>                 senduart r1, r3
>   7c:   7319            strb    r1, [r3, #12]
>   7e:   8a19            ldrh    r1, [r3, #16]
>   80:   f021 0140       bic.w   r1, r1, #64     ; 0x40
>   84:   8219            strh    r1, [r3, #16]
>                 busyuart r2, r3
>   86:   8a1a            ldrh    r2, [r3, #16]
>   88:   f012 0f40       tst.w   r2, #64 ; 0x40
>   8c:   d0fb            beq.n   86 <printascii+0x3e>
>                 mov     r1, '\n'         <<<<<<<<<<
>   8e:   f04f 010a       mov.w   r1, #10  <<<<<<<<<<
> ------------------------------------------------------------
> 
> 
> So, the compiler realized what you wanted to do even if there wasn't a
> # in front of the constant.
> 
> 
> $ arm-linux-gnueabihf-gcc --version
> arm-linux-gnueabihf-gcc (Linaro GCC 5.4-2017.01) 5.4.1 20161213
> Copyright (C) 2015 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

The compiler is only involved for the C pre-processor front-end.  It's
not involved in parsing the resulting assembly - as far as gcc is
concerned, it could be forth in the post-processed file.

GCC will then pass the post-processed output to binutils 'as' to do the
actual assembly, and that's what should complain.

Most people's assemblers will object to the second instruction:

        mov     r0, #'\r'
        mov     r1, '\r'

$ arm-linux-as -o /dev/null t.s
t.s: Assembler messages:
t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'

The reason being that the ARM instruction set has, for a few decades
now, required the # for constants.

There are two possibilities:
1) Your binutils version is buggy, in that it now accepts constants in
   ARM assembly without a preceding # and binutils needs to be fixed.
2) The change in binutils is a gratuitous change - which is a really
   stupidly dumb thing to do because it means that we'll end up in this
   exact situation and it breaks the established norm that has been
   present for a long time.

Either way, the fact is that many binutils versions out there will not
accept the syntax that Nicolas used, and therefore the patch is broken
as far as the kernel is concerned.

So, as far as ARM assembly in the Linux kernel goes, all constants must
be preceded by # whether or not binutils requires it - no exceptions.
Please always test assembly changes with a binutils version that is not
gratuitously broken!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
