From: balakrishnan@e-consystems.com (balakrishnan)
Date: Mon, 07 Jun 2010 11:59:51 +0530
Subject: pxa300 - DDRAM base value
In-Reply-To: <201006061834.50297.marek.vasut@gmail.com>
References: <1275371058.7001.35.camel@balakrishnan-desktop>
	<201006051919.17738.marek.vasut@gmail.com>
	<AANLkTil5TWYILcdp872as8S8LMqQWhPYWLt7cxs2lUm5@mail.gmail.com>
	<201006061834.50297.marek.vasut@gmail.com>
Message-ID: <1275892191.3501.17.camel@balakrishnan-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-06-06 at 18:34 +0200, Marek Vasut wrote:

> Dne Ne 6. ?ervna 2010 10:17:00 Eric Miao napsal(a):
> > On Sun, Jun 6, 2010 at 1:19 AM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > > Dne ?t 1. ?ervna 2010 07:44:18 balakrishnan napsal(a):
> > >> I am working on pxa300 based development board and using Linux 2.6.34.
> > >> This Linux kernel already has support for following boards
> > >> 1. zylonite_pxa300
> > >> 2. cm-x300
> > >> 3. colibri-pxa300
> > >> 4. littleton
> > >> 
> > >> My doubt is that pxa300 based boards are using "0xa0000000"  as DDRAM
> > >> base and PHYS_OFFSET is also defined in
> > >> "arch/arm/mach-pxa/include/mach/memory.h" as 0xa0000000.
> > >> But in our board  DDR is mapped in 0x80000000. Does it make any
> > >> problem?. Because after mmu is turned ON, my board is hanging.
> > >> 
> > >> "zreladdr-y   := 0x80008000" is defined in
> > >> "arch/arm/mach-pxa/Makefile.boot" file .
> > >> my machine_desc is as follows
> > >> .phys_io        = 0x40000000,
> > >> .io_pg_offst    = (io_p2v(0x40000000) >> 18) & 0xfffc,
> > >> .boot_params    = 0x80000100,
> > > 
> > > Try editing both arch/arm/mach-pxa/Makefile.boot and
> > > arch/arm/mach/pxa/include/mach/memory.h
> > > 
> > >> With Thanks
> > >> J.Balakrishnan
> > > 
> > > The 0x80000000 should be aliased to 0xa0000000, but looking into the PXA
> > > docs, it is only on pxa320. Eric, any ideas on this ?
> > 
> > Should be working on pxa300/310 as well. If it doesn't, check you
> > bootloader to make sure the mapping is OK, and memory doesn't exceed
> > (0xa000_0000 - 0x8000_0000).
> 
> It worked last time I used the pxa310 littleton board, but I can't check on the 
> pxa300 zylonite board just yet.
> 
> Could you give us your bootloader details ?

hi, 
      Now, I can able to boot after editing following files
arch/arm/mach-pxa/Makefile.boot and
arch/arm/mach/pxa/include/mach/memory.h (0x80000000 changed to
0xa0000000). My doubt is 
1.why 0x80000000 (DDR phy address) is aliased to 0xa0000000 in pxa
architecture?
2.In my development board two DDRAMs mapped at 0x80000000-0x88000000 and
0xc0000000-0xc8000000, how can I inform to kernel about this different
bank and size?.

My Boot loader details,
------------------------------
=>bdi
arch_number = 0x00000B04
env_t       = 0x00000000
boot_params = 0x80000100
DRAM bank   = 0x00000000
-> start    = 0x80000000
-> size     = 0x08000000
DRAM bank   = 0x00000001
-> start    = 0xC0000000
-> size     = 0x08000000
ethaddr     = 08:00:3e:26:0a:5b
ip_addr     = 192.168.0.21
baudrate    = 115200 bps
=>ver
U-Boot 2010.03 (Jun 01 2010 - 14:27:43)


With Thanks
J.Balakrishnan
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100607/539edde2/attachment.html>
