From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 00:13:59 +0000
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <8yabp3wfeax.fsf@huya.qualcomm.com>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
	<8yabp3wfeax.fsf@huya.qualcomm.com>
Message-ID: <20110105001359.GH24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 03:18:46PM -0800, David Brown wrote:
> On Tue, Jan 04 2011, Russell King - ARM Linux wrote:
> 
> > MSM's memory is aligned to 2MB, which is more than we can do with our
> > existing method as we're limited to the upper 8 bits.  Extend this by
> > using two instructions to 16 bits, automatically selected when MSM is
> > enabled.
> 
> I should also add that this series adds a warning to my build when
> CONFIG_ARM_PATCH_PHYS_VIRT is not defined:
> 
>   arch/arm/kernel/module.c:279: error: 'find_mod_section' defined but not used

Hmm, probably best to mark this with __maybe_unused.

Also note that I messed up the 16-23 bit shift value in this patch - it
needs:

-	orr	r0, r0, #0x400  @ mask in rotate right 8 bits
+	orr	r0, r0, #0x800  @ mask in rotate right 16 bits
