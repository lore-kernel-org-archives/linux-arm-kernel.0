From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Aug 2011 18:56:38 +0100
Subject: v6 software reset fails on 1176
In-Reply-To: <20110823174736.GG10062@e102144-lin.cambridge.arm.com>
References: <20110823163247.GM2796@pulham.picochip.com>
	<20110823170955.GF10062@e102144-lin.cambridge.arm.com>
	<20110823173410.GA2263@gallagher>
	<20110823174736.GG10062@e102144-lin.cambridge.arm.com>
Message-ID: <20110823175638.GB2263@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 06:47:36PM +0100, Will Deacon wrote:
> You need to make sure you call cpu_reset by jumping to its *physical*
> address. If that happens to alias with the virtual address of the kernel, it
> won't currently work but I have a solution to this in my kexec branch.
> 
> You can do something like:
> 
> 	typedef void (*phys_reset_t)(unsigned long);
> 
> 	phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
> 	phys_reset(0xffff0000);

OK, that makes perfect sense!  I'll give it a go on my hardware tomorrow 
when I'm back in the office.

All of the other mainline users of cpu_reset() just call it directly, so 
I guess they need to do the same thing?

Jamie
