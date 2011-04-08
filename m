From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 8 Apr 2011 16:44:02 -0400 (EDT)
Subject: [PATCH 2/2] ARM: fix personality flag propagation across an exec
In-Reply-To: <20110408201541.GC5573@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1104072251390.28032@xanadu.home>
	<20110408072931.GB27450@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104080856000.28032@xanadu.home>
	<20110408191035.GA5573@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1104081536390.28032@xanadu.home>
	<20110408201541.GC5573@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1104081642330.28032@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Apr 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 08, 2011 at 03:50:21PM -0400, Nicolas Pitre wrote:
> 
> > Or is the actual personality type not supposed to be inherited?
> 
> Many architectures explicitly set a personality type on exec, so that
> seems to be the thing to do.  We want it set to a PER_LINUX flavour
> as the ELF executables we run tend to be Linux executables.
> 
> Also, the ARM kernel doesn't really support anything but PER_LINUX
> ELF executables, so it'd be rather meaningless to set it to anything
> else here.
> 
> So:
> 
> 	unsigned int personality = current->personality & ~PER_MASK;
> 
> 	/*
> 	 * We only support Linux ELF executables, so always set the
> 	 * personality to LINUX.
> 	 */
> 	personality |= PER_LINUX;
> 
> 	/* APCS-26 is only valid for OABI executables */
> 	if ((eflags & EF_ARM_EABI_MASK) == EF_ARM_EABI_UNKNOWN &&
> 	    (eflags & EF_ARM_APCS_26))
> 		personality &= ~ADDR_LIMIT_32BIT;
> 	else
> 		personality |= ADDR_LIMIT_32BIT;
> 
> 	set_personality(personality);
> 
> is probably what we want.

ACK.  Are you committing this directly, or do you still want me to send 
you a patch?


Nicolas
