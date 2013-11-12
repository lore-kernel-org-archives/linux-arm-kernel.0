From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 12 Nov 2013 14:57:39 +0000
Subject: [Xen-devel] Physical memory start contraints in the Linux
 kernel (Was: Re:	Xen osstest on Calxeda midway progress (Was: Re:
 [xen-unstable test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <52824090.8040203@linaro.org>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
 <201311121437.55826.arnd@arndb.de> <52823C9E.2010007@linaro.org>
 <20131112144128.GL16735@n2100.arm.linux.org.uk>
 <52824090.8040203@linaro.org>
Message-ID: <1384268259.10204.29.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-12 at 14:52 +0000, Julien Grall wrote:
> 
> On 11/12/2013 02:41 PM, Russell King - ARM Linux wrote:
> > On Tue, Nov 12, 2013 at 02:35:10PM +0000, Julien Grall wrote:
> >> During some debugging on the Arndale and Midway, I found another
> >> constraint with CONFIG_ARM_PATCH_PHYS_VIRT.
> >> I have noticed that all the kernel physical addresses must be lower than
> >> the corresponding virtual addresses. So the delta offset compute in
> >> __fixup_pv_table (arch/arm/kernel/head.S) must always be negative.
> >> If this assertion is not validated, when the kernel will browse the
> >> memory bank (sanity_check_info in arch/arm/mm/mmu.c), __phys(...) will
> >> compute a wrong address and will result to consider all memory bank as
> >> highmem.
> >>
> >> After digging in the code, it seems it's due to some optimization during
> >> opcode fixup in __fixup_a_pvtable. Is it a wanted constraint?
> >
> > Are you talking about the code in v3.12 or the code in -next ?
> 
> I was talking about 3.12. I have just checked -next and my issue seems 
> to be fixed by the commit f52bb722547f43caeaecbcc62db9f3c3b80ead9b.
> I should have checked earlier, thanks.

Should we revert your Xen side fix^Wworkaround then:

commit 6c21cb36e263de2db8716b477157a5b6cd531e1e
Author: Julien Grall <julien.grall@linaro.org>
Date:   Tue Oct 22 11:51:48 2013 +0100

    xen/arm: Allocate memory for dom0 from the bottom with the 1:1 Workaround
    
    On Linux, the option CONFIG_ARM_PATCH_PHYS_VIRT (by default enabled) allow
    the Kernel to be loaded anywhere (or nearly) by patching the translation
    pv<->virt at boot time.
    
    The current solution in Linux assuming that the delta physical address -
    virtual address is always negative. A positive delta will destroy all the
    optimisation to modify only a part of the translation instruction (add/sub
    
    By default, Xen is allocating memory from the top of memory and then
    goes down. To avoid booting issue with Linux, we must allocate memory
    from the bottom (ie starting from 0).
    
    Signed-off-by: Julien Grall <julien.grall@linaro.org>
    Acked-by: Ian Campbell <ian.campbell@citrix.com>

The plus side of reverting it is that we can help find any future issues
with Linux. The down side of reverting it is that we can help find any
future issues with Linux...

Ian.
