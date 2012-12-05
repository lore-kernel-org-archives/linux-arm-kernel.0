From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Dec 2012 23:58:36 +0000
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
 <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
Message-ID: <20121205235836.GR14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 11:18:47PM +0100, Marko Kati? wrote:
> > You're going to have to boot -rc7, mount debugfs and read
> > /sys/kernel/debug/gpio to find out what is claiming those GPIOs that
> > the MAX device wants to use.  There is only _one_ other device for PXA
> > for Sharp devices which is hard-coded to the same GPIO numbers and that's
> > the Scoop 2 device - but that's not registered for the !machine_is_akita()
> > case.
> >
> > Everything you've reported points to machine_is_akita() being false, which
> > it won't be given your Machine: line above.
> >
> > So.. I don't know, and no one can explain the behaviour you're seeing.
> 
> No. I messed up. Dmesg log i posted earlier was from 3.7.0-rc7 with
> 424e5994e63326a42012f003f1174f3c363c7b62 reverted. Russell,
> your theory was correct, vanilla 3.7.0-rc7 on an akita, with the .config
> i posted earlier, will boot with machine id == borzoi. So
> machine_is_akita () is false and max7310
> won't be registered.

Great, thanks for confirming my theory.

> This also explains why i get clobbered gpio lines
> when i tried to explicitly register just the
> max7310. Since the kernel boots with machine id == borzoi, it wil also
> register the second scoop device
> before max7310 init and max7310 probe will fail.
> 
> Now, why does it register as borzoi? Well, i looked at my .config
> (same one i posted earlier) and i noticed
> this:
> 
> CONFIG_MACH_AKITA=y
> CONFIG_MACH_SPITZ=y
> CONFIG_MACH_BORZOI=y
> 
> Akita and spitz should be defined, spitz gets defined automatically if
> you define akita. There's no reason for
> CONFIG_MACH_BORZOI=y, i probably forgot to deselect it. So i disable
> CONFIG_MACH_BORZOI, recompile and try to
> boot vanilla 3.7.0-rc7. Now it hangs right after "Uncompressing
> Linux... done, booting the kernel." Naturally,
> reverting 424e5994e63326a42012f003f1174f3c363c7b62 makes everything work normal.

That'll be because its still passing the BORZOI ID into the kernel which
now isn't recognising it.

The code which distinguishes between Borzoi and Akita is this:

/* Check for a second SCOOP chip - if found we have Borzoi */
        ldr     r1, .SCOOP2ADDR
==cacheline boundary without patch (0x120)=====
        ldr     r7, .BORZOIID  
        mov     r6, #0x0140
        strh    r6, [r1]
==cacheline boundary with patch (0x160)======
        ldrh    r6, [r1]
        cmp     r6, #0x0140
        beq     .SHARPEND                       @ We have Borzoi
        
/* Must be Akita */
        ldr     r7, .AKITAID
        b       .SHARPEND                       @ We have Borzoi

and I've marked where the cache line boundary ends up with the patch
in place... except of course that the caches are off here, so the
placement of the code should be irrelevant.  It also would have the
reverse results from those that you're experiencing.

My guess is that because the Scoop2 device is not present, the strh
access places 0x140 onto the data bus.  By the time the ldrh is
executed, it reads the data bus, and because nothing drives it, it
reads back the value last present on the bus, which happens to be
0x140 - and this allows us to think we have the Scoop2 device.

In theory, because the caches are off (including the instruction
cache) the CPU should fetch ldrh between the strh write and the
ldrh access to the same address.

Having said all that, I'm not impressed by the above code; to write to
a memory region which may or may not have a device, and immediately
read it back is a recipe for exactly this kind of stuff happening.  If
anyone has looked at any real device detection code, they'll know that
this sequence is typical:

	ldr	r0, =address
	mov	r1, #probe_data
	eor	r2, r1, #~0
	str	r1, [r0, #reg1]
	str	r2, [r0, #reg2]
	ldr	r3, [r0, #reg1]
	ldr	r0, [r0, #reg2]
	teq	r1, r3
	teqeq	r2, r0
	beq	found

This sequence _purposely_ writes the opposite value between the first
store and the read-back of it to perturb the bus in case it's floating,
to prevent exactly these kinds of false positives.  The second check is
additional belt and braces to make the check even more secure.

Can we do that with Scoop2?  I've no idea, I don't know what the weird
0x40 offset is that's being probed by this code.  We need whoever wrote
this code, but I suspect they've long since moved on and aren't
interested in it.

The alternative is we can rip out all this autodetection code and go
in the exact opposite direction to arm-soc and force Sharp kernels
to be built for the exact machine that they're to be run on.  Not
particularly desirable, but I don't have any other answers to this
without more information about the hardware.
