From: wd@denx.de (Wolfgang Denk)
Date: Tue, 15 Dec 2009 00:28:06 +0100
Subject: "ARM: MX3: fix CPU revision number detection" breaks QONG support
In-Reply-To: <20091214224109.20623gout4jbbdo5@webmail.epfl.ch>
References: <20091211143318.1D8B43F6CC@gemini.denx.de>
	<20091211234714.GT28375@buzzloop.caiaq.de>
	<20091214135722.CBCBF4C026@gemini.denx.de>
	<20091214150420.GE28375@buzzloop.caiaq.de>
	<20091214224109.20623gout4jbbdo5@webmail.epfl.ch>
Message-ID: <20091214232806.DC39A4C026@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Valentin,

In message <20091214224109.20623gout4jbbdo5@webmail.epfl.ch> you wrote:
> 
> >> In Linux, the kernel hangs here:
> >>
> >> 	/* read SREV register from IIM module */
> >> 	srev = __raw_readl(IO_ADDRESS(IIM_BASE_ADDR) + MXC_IIMSREV);
> >>
> >> In U-Boot, I can read this register just fine:
> >>
> >> 	=> md 5001c024 1
> >> 	5001c024: 00000028    (...

0x28 translates into "i.MX31", chip rev. 2.0/2.0.1, mask M91E

> I have looked more carefully at the bootloader code, and it does not  
> seem to configure anything for SPBA0. Furthermore, Redboot actually  
> reads this register at boot time to determine the CPU revision just as  
> Daniel with its patch.

True - U-Boot does not do anything for SPBA0.

> For the IO_ADDRESS stuff, it may be the problem. This macro is  

This is my guess, too.

> supposed to do the physical address -> virtual address translation. If  
> I have understood correctly (correct if wrong, I don't really know  
> when whe have to use it or not), it is used when the memory region was  
> not allocated and then mapped with request_mem_region and ioremap  
> calls. The 0xFC11C024 is the virtual address defined by the IO_ADDRESS  
> macro succession for the SPBA0 memory region. Now how was this defined  
> and may this fail on certain systems/configuration because other  
> memory definitions ?

The 0xfc100000 offset is from MX3x_SPBA0_BASE_ADDR_VIRT in
"arch/arm/plat-mxc/include/mach/mx3x.h". And indeed this is the key
question... See below...

> The iim clock is explicitely enabled in clock.c, just before the call  
> to mx31_read_cpu_rev(), and from what I had checked, the clock  
> effectively seemed enabled for me...

I have verified that clk_get(NULL, "iim") succeeds (immediately before
attempting to read MXC_IIMSREV).

>                                ... I have no clue about the register  
> definition since I have found no real documentation about it, but from  
> my point of view, this would more look like 8 bit registers as Andy  
> pointed out in an earlier mail.

See the reference manual, pages 13-1 (=479) 
(http://www.freescale.com/files/32bit/doc/ref_manual/MCIMX31RM.pdf):

        "The IIM is accessible using an 8-bit IP bus interface. An
        8-bit interface is used because it matches the natural width
        of the fuse arrays."

See especially Table 13-2. SILICON_REV Settings on page 13-4 (=482).

> Let's wait a few more days so that we maybe can find a solution, but  
> in case no solution is found when -rc1 is approaching, we maybe should  
> revert it.

I tried changing the __raw_readl() into a __raw_readb(), but this
doesn't change anything.


Now. After realizing that the SPBA0 mapping seems to be an issue I
found that all boards add a mapping for it in their own, private
map_io code. Qong did not - because we never accessed any SPBA0 stuff
so far. Add this, and the problem goes away.

But then, now that the "CPU revision number detection" commit makes
this mapping mandatory for all boards, this should be moved from board
specific to SoC specific code. Patch following.

[Note: I still think the __raw_readl() should be changed into a
__raw_readb(), even though this has no immediately visible effect.]


Valentin, thanks again for asking the right questions :-)



Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
Business is like a wheelbarrow. Nothing ever happens until you  start
pushing.
