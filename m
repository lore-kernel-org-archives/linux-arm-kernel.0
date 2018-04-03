From: lambertarthur22@gmail.com (Arthur LAMBERT)
Date: Tue, 3 Apr 2018 16:15:28 +0200
Subject: issue with kexec/kdump on imx6ull
In-Reply-To: <20180329205413.GG16141@n2100.armlinux.org.uk>
References: <20180320100427.GA21933@arthur-bzh>
 <20180320104302.GG2743@n2100.armlinux.org.uk>
 <20180320150723.GH2743@n2100.armlinux.org.uk>
 <20180320171608.GB32282@arthur-bzh>
 <20180320191259.GI2743@n2100.armlinux.org.uk>
 <20180321132548.GA32618@arthur-bzh>
 <20180329205413.GG16141@n2100.armlinux.org.uk>
Message-ID: <20180403141528.GA5701@arthur-bzh>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> From the debug output of kexec, I think the problem has been located
> with these two lines:
> 
> kernel symbol _stext vaddr =         80100000
> segment[0].mem   = 0x88008000
> 
> It is standard with Linux kernels that they are loaded with a 32kB
> offset to allow room for data including the page tables below the
> kernel image.  kexec-tools knows about this offset.  It seems,
> however, that the kernel tree you're using omits this offset and
> builds the kernel to execute at a 1MB offset.
> 
> This difference is sufficient that the kernel will crash as a result.
> 
> All the offsets established to date in arch/arm/Makefile include
> this 32kB offset, except, it seems, for your case - which is
> presumably a vendor supplied (NXP?) or modified kernel tree.
> 
> That's the root of the problem, and I'm afraid I can't help you any
> further - please complain to the vendor about this.
> 
> I suspect that they wanted to load the kernel at 1MB to avoid data
> in the low 1MB of RAM, but have forgotten that both the decompressor
> and the kernel itself will scribble over the 16 to 32k of memory
> _below_ where it's loaded.
> 
> One way to fix this is to change the initialiser for extra_size in
> kexec-tools/kexec/arch/arm/kexec-zImage-arm.c to reflect this offset,
> but that will be at the expense of having to increase the crashdump
> memory to allow for this offset.  It also makes kexec incompatible
> with other kernels in the same way as stock kexec is incompatible
> with your kernel.
> 
> The other solution is to include the 32k offset into the 1MB offset
> in arch/arm/Makefile as per all the other textofs settings therein.

Not sure to fully understand you here. For me the offset is correct. 32kb.
I add some extra debug in kexec in the function with extra size and result is :

TUTU base addr : 0x88000000
TUTU extra size : 0x00008000
TUTU kernel base addr : 0x88008000

Base address is 0x88000000. extra size is 0x8000
So kernel base addr is 0x88008000. Offset is 32kB
as expected.

In my arch/arm/Makefile as expected :

# Text offset. This list is sorted numerically by address in order to
# provide a means to avoid/resolve conflicts in multi-arch kernels.
textofs-y := 0x00008000.
My kernel is compiled with good TEXT_OFFSET :
-DTEXT_OFFSET=0x00008000

the _stext vaddr is incorrect here ? It must be 0x88000000 instead of
80100000 ?
