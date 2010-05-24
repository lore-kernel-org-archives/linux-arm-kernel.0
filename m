From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 24 May 2010 15:05:27 +0200
Subject: [PATCH 01/20] mtd: pxa3xx_nand: refuse the flash definition get
	from platform
In-Reply-To: <AANLkTiniYaEI2lywcfYmfSyPjCeNxD9xPJ2pGxI3IbEb@mail.gmail.com>
References: <AANLkTinVBXhT77Zd-LNpufgJAl7WZdic0oxDFwvNkvJg@mail.gmail.com>
	<201005241411.31825.marek.vasut@gmail.com>
	<AANLkTiniYaEI2lywcfYmfSyPjCeNxD9xPJ2pGxI3IbEb@mail.gmail.com>
Message-ID: <201005241505.27545.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 24. kv?tna 2010 14:31:39 Lei Wen napsal(a):
> Hi Marek,
> 
> On Mon, May 24, 2010 at 8:11 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > Dne Po 24. kv?tna 2010 13:53:46 Lei Wen napsal(a):
> >> Hi Mike,
> >> 
> >> On Mon, May 24, 2010 at 7:00 PM, Mike Rapoport <mike@compulab.co.il> wrote:
> >> > Hi Lei,
> >> > 
> >> > Lei Wen wrote:
> >> >> Hi Mike,
> >> >> 
> >> >> This patch set is applied to mtd-2.6 git. We submit the patch with a
> >> >> package in attachment already.
> >> >> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/79818
> >> > 
> >> > After applying the patch set I've reviewed the entire pxa3xx-nand as a
> >> > whole and there are several major points I don't like:
> >> > 1) Two chip selects support is not robust enough. You allocate a lot
> >> > of resources for both chip selects, although not necessarily both
> >> > have NAND chip connected
> >> 
> >> I agree. I prepare to submit another patch set to fix it. Let more
> >> resource go to pxa3xx_nand structure instead of pxa3xx_nand_info.
> >> 
> >> > 2) I don't like hadrcoding of NAND parameters into the driver. You
> >> > remove *deprecetad* CONFIG_MTD_NAND_PXA3xx_BUILTIN configuration
> >> > option and instead you enforce use of built-in definitions. The
> >> > driver in its current state is robust enough to allow platforms to
> >> > define optimized NAND timings either in the bootloader or in the
> >> > kernel. If you don't like that multiple platforms define the same
> >> > flash chip create an enumeration of built-in types and let platforms
> >> > to use this enumeration to select the NAND chip. But, anyway, there
> >> > should be a fallback mode that will support NAND chips that are not
> >> > defined in the driver, probably with suboptimal timings.
> >> 
> >> Original driver also use hardcoding. And in bootloader, this timing
> >> parameter is also hard coding.
> > 
> > Not necessarily. If you use uboot on pxa3xx, it passes the
> > bootrom-detected timing to the kernel.
> > 
> >> We cannot deduce a parameter set only from the nand id, that is why we
> >> need a table to preset it.
> >> If one nand chip is not listed in that table, the chip id would still
> >> be printed out, so that we can do something for that.
> >> If we encourage people to continue on this, we would not able to
> >> really "driver" that nand.
> >> 
> >> As I said, different nand chip may have different requirement. And in
> >> bootloader and kernel, may have different requirement
> >> of timing parameter.
> > 
> > In bootloader and kernel? Why would that be so?
> 
> The bootrom timing setting is not very satisfied. We have compared the
> most optimized timing setting and what the timing setting is set in
> bootrom. The read speed would be several times gap.(3x, or 4x).

That's expectable.

> For kernel is the place we want the most optimized performance, we may
> adjust the timing according to our need.

Yeah, that I'm aware of. But if that's the case, why don't you move the timing 
setup into the bootloader altogether and be done with it ? Kernel relies on the 
BootROM if the NAND chip definition is missing ... therefore if the platform set 
it up correctly in the bootloader, all this goo could go away from the driver. 
(And you can possibly only leave that 'platform can adjust NAND timing' part for 
worst cases).

Maybe I'm missing something, it's hard to review. If that's the case, just 
ignore what I said.

Cheers!
> 
> Thanks,
> Lei
> 
> >> > 3) The functions prepare_command_pool and alloc_nand_resource seem
> >> > overgrown too me. Consolidation of prepare_*_cmd into one huge
> >> > function does not seem right. And mixing between resource allocation
> >> > and mtd struct initialization does not seem right either.
> >> 
> >> The reason why I consolidate those prepare_*_cmd into one is for if
> >> separate into several functions, it would create many code
> >> duplication.
> >> And with one function, the code execution path would be always one
> >> way. This would greatly promote the code quality, for the same code
> >> path is run by many commands in the same time. If not by this, some
> >> errors may not be discovered in the first time...
> >> 
> >> Thanks,
> >> Lei
> >> 
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
