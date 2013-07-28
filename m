From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 28 Jul 2013 19:56:32 +0000 (UTC)
Subject: [PATCH] ARM: v6: avoid read_cpuid_ext() on ARM1136r0 in
 cache_ops_need_broadcast()
In-Reply-To: <20130728115220.GE21614@n2100.arm.linux.org.uk>
References: <51EE2AA7.5060503@ti.com>
 <alpine.DEB.2.02.1307230705000.27017@utopia.booyaka.com>
 <51EE474D.5070804@ti.com> <20130724135617.GI11072@mudshark.cambridge.arm.com>
 <51EFE1DD.8070801@ti.com> <20130724142059.GJ11072@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307270405470.4546@utopia.booyaka.com>
 <20130727122221.GB6618@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1307280538460.8385@utopia.booyaka.com>
 <20130728111038.GA9374@mudshark.cambridge.arm.com>
 <20130728115220.GE21614@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.02.1307281947190.23852@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 28 Jul 2013, Russell King - ARM Linux wrote:

> We don't want to make the asm() itself volatile, because that means the 
> asm() statement can't be optimised away.
> 
> Adding a memory clobber to that asm seems to place it more appropriately,
> but again, that's not particularly desirable.
> 
> Another solution would be to make both tlb_ops_need_broadcast and
> cache_ops_need_broadcast both be a flag test, but that introduces a
> memory load in all those paths no matter if we're running on SMP_ON_UP
> or not.

I considered adding a HWCAP_* bit under the theory that elf_hwcap may 
already be cache-resident.  But thought that the loss of the flag space 
and possible memory access vs. the additional mrc wasn't worth it.

Anyway, if either of you have a preference between these three, I'd be 
happy to update the patch.  Or feel free to take it over from here if 
either of you prefer.


- Paul
