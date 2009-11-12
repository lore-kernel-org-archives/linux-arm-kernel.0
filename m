From: h.feurstein@gmail.com (Hubert Feurstein)
Date: Thu, 12 Nov 2009 17:49:49 +0100
Subject: ARM: big performance waste in memcpy_{from,to}io
Message-ID: <200911121749.49676.h.feurstein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

I'm working with an Contec Micro9 board (ep93xx-based with two Spansion-NOR-
Flash chips in parallel => 32bit memory-buswidth) and was wondering why the
read-performance of the flash (through /dev/mtd*) is so quite poor. So I 
connected a logic analyser to the data- and address-bus and recognized that 
the accesses to the same flash-word-address happens four times. This means 
that the flash is read byte-by-byte, which is IMO a big waste of performance 
since it would be possible to read the full word (four bytes) at once. So I 
digged around in the mtd-driver and found the function "memcpy_fromio" which 
is called to read the flash data. I was really surprised when looked to the 
implementation, which is:

arch/arm/kernel/io.c:

/*
 * Copy data from IO memory space to "real" memory space.
 * This needs to be optimized.
 */
void _memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
{
	unsigned char *t = to;
	while (count) {
		count--;
		*t = readb(from);
		t++;
		from++;
	}
}

Ok, with this poor memcpy-implementation the poor flash-read-performance is
fully explainable. So I tried to fix this. I found the real "memcpy"
implementation which is written in assemler and seems to be quite optimized.
So I changed the the code to this:

Index: linux-2.6.31/arch/arm/include/asm/io.h
===================================================================
--- linux-2.6.31.orig/arch/arm/include/asm/io.h
+++ linux-2.6.31/arch/arm/include/asm/io.h
@@ -195,9 +195,9 @@ extern void _memset_io(volatile void __i
 #define writesw(p,d,l)		__raw_writesw(__mem_pci(p),d,l)
 #define writesl(p,d,l)		__raw_writesl(__mem_pci(p),d,l)

-#define memset_io(c,v,l)	_memset_io(__mem_pci(c),(v),(l))
-#define memcpy_fromio(a,c,l)	_memcpy_fromio((a),__mem_pci(c),(l))
-#define memcpy_toio(c,a,l)	_memcpy_toio(__mem_pci(c),(a),(l))
+#define memset_io(c,v,l)	memset(__mem_pci(c),(v),(l))
+#define memcpy_fromio(a,c,l)	memcpy((a),__mem_pci(c),(l))
+#define memcpy_toio(c,a,l)	memcpy(__mem_pci(c),(a),(l))

 #elif !defined(readb)

Because on the ARM architecture there is no difference between io-memspace
and the 'real' memspace so it should work. The following tests show the impact
of this change:

[root at micro9]\# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 00040000 00020000 "RedBoot"
mtd1: 01fa0000 00020000 "test"
mtd2: 0001f000 00020000 "FIS directory"
mtd3: 00001000 00020000 "RedBoot config"

This is the read-time with the original ARM implementation:

[root at micro9]\# time cat /dev/mtd1 > /dev/null
real    0m 7.27s
user    0m 0.00s
sys     0m 7.26s

and here is the read-time with my simple change:

[root at micro9]\# time cat /dev/mtd1 > /dev/null
real    0m 0.96s
user    0m 0.00s
sys     0m 0.95s

Wow, that is more than 7.6-times faster!

Because of the word-accesses to the bus, I can take advantage of the burst-
mode option of the SMC (static memory controller) of the ep93xx which
increased the performance by 35% (0.96s was already measured with burst-mode
enabled). With the byte-accesses of the original implementation the burst-mode
seem to have no influence at all.

I've seen that such "simple and slow" memcpy_{to,from)io implementations exist
in many other architectures. So maybe this is a big potential to improve 
overall io-performance, since a lot of drivers use these memcpy_{to,from)io 
functions.

For testing I used kernel version 2.6.31.

Are there any drawbacks when using the good-and-fast "memcpy" ? On my Micro9-
board everything is running fine so far.

Best Regards,
Hubert

---
Hubert Feurstein
Software-Engineer

Contec Steuerungstechnik & Automation GmbH
Wildbichler Stra?e 2e
6341 Ebbs
Austria
www.contec.at
