From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 3 Dec 2010 22:45:23 +0000
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
In-Reply-To: <20101203203653.GB10245@n2100.arm.linux.org.uk>
References: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
	<20101202221909.GK29347@n2100.arm.linux.org.uk>
	<4CF94DDD.8000409@codeaurora.org>
	<20101203203653.GB10245@n2100.arm.linux.org.uk>
Message-ID: <20101203224523.GU12385@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 08:36:53PM +0000, Russell King - ARM Linux wrote:
> On Fri, Dec 03, 2010 at 12:06:53PM -0800, Saravana Kannan wrote:
> > The MSM8660 SoC uses the TrustZone technology and the Linux kernel  
> > executes in normal/non-secure domain. When the second core is brought  
> > out of reset, it starts executing a secure image which then jumps to  
> > "secondary_startup". So, before bringing the second core out of reset,  
> > we need to inform the secure domain code where secondary_startup is  
> > located in memory.
> >
> > We do the communication with the secure code by using buffers in memory.  
> >  The cache treats the NS (non secure) bit as an additional address bit  
> > when tagging memory. Hence, cache accesses are not coherent between the  
> > secure and non-secure domains. So, the secure side flushes it's cache  
> > after writing to the buffer. To properly read the response from the  
> > secure side, the kernel has to pick a buffer that isn't cacheable in the  
> > first place. We have similar issues in the reverse direction.
Is the secure world running with the MMU enabled (or is there enough onchip 
memory for page tables in the secure world)? If so, could you recreate the 
direct-mapping in the secure world with the same attributes and the nonsecure 
bit set in the page table descriptors?  The cache should be coherent between 
both worlds in this case.

Alternatively could you not pass the address to the monitor mode in a 
register?

Jamie
