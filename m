From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Jan 2011 00:15:24 +0000
Subject: [RFC 5/5] ARM: P2V: extend to 16-bit translation offsets
In-Reply-To: <alpine.LFD.2.00.1101041628060.22191@xanadu.home>
References: <20110104202052.GE24935@n2100.arm.linux.org.uk>
	<E1PaDPu-00023p-QG@rmk-PC.arm.linux.org.uk>
	<alpine.LFD.2.00.1101041628060.22191@xanadu.home>
Message-ID: <20110105001524.GI24935@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 04, 2011 at 04:41:34PM -0500, Nicolas Pitre wrote:
> I'd suggest making the type argument into a mask instead, something 
> like:
> 
> 	__pv_stub(x, t, "add", 0xff000000);
> #ifdef CONFIG_ARM_PATCH_PHYS_VIRT_16BIT
> 	__pv_stub(t, t, "add", 0x00ff0000);
> #endif
> 
> Reasons for this are multiple:
> 
>  - This would simplifies the patching code as the rotation bitfield in 
>    the instruction would already be set appropriately for the desired 
>    value by the assembler.  Would only suffice to test one bit in that 
>    field to determine the required constant to patch in.
> 
>  - For the Thumb2 build, we want the assembler to select the appropriate 
>    encoding flavor for the add instruction from all the possibilities.  
>    Giving it a constant with all bits set nicely solves this issue.
> 
> If further distinctions are needed in the future then we can use the 6 
> middle bits to encode alternatives.

Lets go with 0x81000000 and 0x0081000000 for the first then.  We can
count up with the 6-bit value from there.
