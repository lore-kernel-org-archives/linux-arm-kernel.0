From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 23:48:16 +0000
Subject: Integrator PCI base dilemma
In-Reply-To: <CACRpkdY_qj7VBKBSCsK3mnx=V5DURY-g1fHGVwDBz2WUheB=Nw@mail.gmail.com>
References: <CACRpkdaOjFhWR21w5x_rR_60ffQF3Ym_MQd2svNyzm0guwOUoQ@mail.gmail.com>
 <201303211302.19058.arnd@arndb.de>
 <20130321234004.GV4977@n2100.arm.linux.org.uk>
 <201303220948.28092.arnd@arndb.de>
 <20130322103740.GW4977@n2100.arm.linux.org.uk>
 <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com>
 <20130322211339.7A5F82014CE@gemini.denx.de>
 <CACRpkdY_qj7VBKBSCsK3mnx=V5DURY-g1fHGVwDBz2WUheB=Nw@mail.gmail.com>
Message-ID: <20130322234815.GK4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 11:35:54PM +0100, Linus Walleij wrote:
> On Fri, Mar 22, 2013 at 10:13 PM, Wolfgang Denk <wd@denx.de> wrote:
> > Dear Linus Walleij,
> >
> > In message <CACRpkdb5Q+EtM0GGaLFNUj1A12zVrcyUxzRvfEOpcH4-pVuasA@mail.gmail.com> you wrote:
> >>
> >> I'm on U-boot for this thing, I wonder if that can do x86
> >> emulation to initialize VGA card. I guess I'm about to learn.
> >
> > Guess what the code in  drivers/bios_emulator  might be good for...
> 
> Thanks Wolfgang!
> 
> I hacked around a bit and actually got it to compile for ARM.
> 
> Now I just need to write an S3 driver or find an ATI Radeon
> card since that seems to be supported already.

Okay, what follows is based on my latest version of the Footbridge
"bios" boot loader - which is tested to run the VGA BIOS on several
VGA cards, and the ATA RAID BIOS on an IT8212 card - including the
config stuff on that ATA RAID BIOS card.

You shouldn't need an "S3" driver.  The way I do it on Footbridge, and
the way I made the Integrator Milo do it was to basically setup the PCI
bus, find if there was a VGA card there, load the VGA BIOS into the
x86 emulation address 0xc0000 - where it would be loaded on a PC.

Beware though - the S3 BIOS will try to access the i8253 timer which
needs to be emulated, address 0x61 which can be simply discarded, maybe
the PCI config IO addresses 0xcf8..0xcff (which need to generate real
PCI config cycles), read from IO port 0x80 (which can simply return 0).

It will also want to access PCI IO addresses in addition to the normal
VGA IO address range of 0x3b0..0x3e0:
 0x8180-0x8200 (Streams processor), 0xff00-0xff44 (LPB bus),
 0x100, 0x[489abe][268ae]e8

And it will want PCI memory addresses 0xa0000-0xbffff to be accessible
at that x86 emulation offset.

As I said previously, different VGA BIOS prod different bits of PC
hardware in random ways, so I don't guarantee that the above will work
for your S3 BIOS.  Mine is a S3 Trio64 V2 card:

00:09.0 VGA compatible controller: S3 Inc. 86c775/86c785 [Trio 64V2/DX or /GX] (rev 16) (prog-if 00 [VGA])
which has IDs 5333:8901.
