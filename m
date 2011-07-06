From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 16:25:46 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201107061641.05569.arnd@arndb.de>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107061442.05182.arnd@arndb.de>
	<20110706130940.GV8286@n2100.arm.linux.org.uk>
	<201107061641.05569.arnd@arndb.de>
Message-ID: <20110706152546.GE8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 04:41:05PM +0200, Arnd Bergmann wrote:
> On Wednesday 06 July 2011, Russell King - ARM Linux wrote:
> > And note that ioread/iowrite are unsupportable on some ARM platforms
> > with ISA because of weird addressing techniques (and that renders
> > PATA unsupportable on those platforms, while the old IDE stuff can
> > continue to work with CF cards.)
> 
> Different issue, but I'm sure that they are supportable.

Ha, you've no idea what kind of messed up ideas hardware people come up
with then.  Take this - this is real hardware which I've had Linux
running on continuously for the last 13 years.  Here is the /proc/ioports:

0000-000f : pcmcia_socket0
  0000-000f : pcmcia0.0
    0000-0007 : ide-cs
    000e-000e : ide-cs
0220-0238 : am79c961
  0220-0237 : eth0
0278-027f : reserved
02f8-02ff : serial
0300-030f : pcmcia_socket1
  0300-030f : pcmcia1.0
0378-037a : parport0
03bc-03be : reserved
03e0-03e1 : i82365
03f8-03ff : serial

ISA devices have either 8 data lines or 16 data lines.
1) If the device has 8 data lines, then it is accessible on physical
   addresses ISA_BASE + (ioport << 2).

2) If the device has 16 data lines, then:
   a) for an ISA device which transfers 8-bit accesses on the low byte
      lane, registers are accessible at ISA_BASE + ((ioport & ~1) << 1).
      For even ioports, use a byte access.  For odd ioports, use a word
      access.

   b) for an ISA Device which transfers even 8-bit accesses on the low
      byte lane and odd 8-bit accesses on the high byte lane, registers
      are accessible at ISA_BASE + ((ioport & ~1) << 1) + (ioport & 1).

(PCs sort this out via the IOCS16 signal, which is not connected in this
example.)

   c) for 16-bit accesses, these are always naturally aligned, so these
      registers are accessible at ISA_BASE + ((ioport & ~1) << 1).

So, let's look at some examples.  Serial ports (standard 16550A)@ISA
bus address 0x2f8 and 0x3f8.  So, the translation from ISA address to
bus offset is:
	0x2f8 => 0xbe0	0x3f8 => 0xfe0
	0x2f9 => 0xbe4	0x3f9 => 0xfe4
	0x2fa => 0xbe8	0x3fa => 0xfe8 etc.

The PCMCIA controller is a standard i82365 at the standard ISA address
of 0x3e0.  This has the following translation:
	0x3e0 => 0x7c0(b)
	0x3e1 => 0x7c0(w)

An inserted PCMCIA card may require:
	0x100 => 0x200(b)
	0x101 => 0x200(w) or 0x201(b)
	0x102 => 0x204(b)
	0x103 => 0x204(w) or 0x205(b)

So, if you do an ioport_map() to convert from the ISA address to a bus
specific address, and _then_ add the device specific offset, you end up
with information lost, and you no longer know how to manipulate the
cookie into the correct bus address and access type.

The alternative is you keep the returned ioport cookie the same as the
ISA address, and do all the conversion in ioread/iowrite - that's even
more horrible than how it's already doing because then you need to know
if its real MMIO or IO, and whether it's an 8 bit IO device, 16-bit
low byte lane IO device, or a 16-bit both byte lane IO device.  Plus
whether the MMIO is in the broken PCMCIA controller IO space (CPU
address bit 11 missing and CPU address bit 19 mapped to two bus
address bits...)
