From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Oct 2015 13:43:30 +0100
Subject: PING: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit virt
 machine
In-Reply-To: <20151007112913.GI21513@n2100.arm.linux.org.uk>
References: <017801d100dc$77fe3a90$67faafb0$@samsung.com>
 <20151007102313.GG21513@n2100.arm.linux.org.uk>
 <01d701d100ef$a5510870$eff31950$@samsung.com>
 <20151007112913.GI21513@n2100.arm.linux.org.uk>
Message-ID: <56151372.8090306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/15 12:29, Russell King - ARM Linux wrote:
> On Wed, Oct 07, 2015 at 02:02:23PM +0300, Pavel Fedin wrote:
>>  2/2 from this series has been ACKed and picked up by Marc Zynger. He
>> told me that 1/2 is your area of competence.
> 
> ... which is kind of funny, because all of ARM Ltd's platforms that
> have PCIe on the board, and thus might have MSI, the PCIe is non-
> functional.  So, until SolidRun sent me an Armada 388 platform a few
> weeks back, I had zero MSI platforms, and zero MSI knowledge.
> 
> Just because code falls into a particular area of the tree does not
> mean that the person who's looking after that area knows everything
> inside out - especially when it comes to architecture maintanence
> and the code in that subtree covers virtually every technology out
> there, and the maintainer is kept functional hardware-starved [*].
> 
> Now, the Armada 388 doesn't use the GIC for MSI, but uses its own
> interrupt controller.  I haven't yet worked out which bits of the
> kernel are being used to provide this functionality yet, but I know
> it works.  What I don't want to do is to merge your patch and then
> have my one and only MSI platform break because of it, so what I'm
> looking for is an assurance that this has had some exposure on
> non-GIC MSI platforms, or has been reviewed with this in mind.
> 
> We're having far too many regressions of the kind of "let's get X
> working on platform Y which then causes platform Z to break".
> 
> 
> * - I'm not saying that I want more hardware; I've been out of physical
> space for new hardware for some time, and the few extra platforms I've
> received recently are having to be stacked on top of each other - which
> isn't good when they're bare boards.  It would be nice, however, if the
> hardware I did have was fully functional!
> 

The generic MSI domain (which is what asm-generic/msi.h is about -
nothing GIC specific about it) is entirely isolated from the rest of the
MSI infrastructure used on 32bit ARM, and is very unlikely to introduce
any regression.

If there is any, I will fix it, as I am (slowly) converting existing MSI
controllers to the new infrastructure. As for GICv2m on 32bit, this is
purely a virtualization-specific thing. No need for actual HW, as a
recent version of QEMU should do the trick (I don't think anyone has
built a 32bit system with GICv2m).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
