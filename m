From: holger.brunck@keymile.com (Holger Brunck)
Date: Wed, 07 Dec 2011 16:59:07 +0100
Subject: [PATCH] arm/orion: use set_bit and clear_bit in gpio
 implementation
In-Reply-To: <alpine.LFD.2.02.1112071031470.2907@xanadu.home>
References: <1323268483-25612-1-git-send-email-holger.brunck@keymile.com>
 <alpine.LFD.2.02.1112071031470.2907@xanadu.home>
Message-ID: <4EDF8D4B.3020806@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/07/2011 04:46 PM, Nicolas Pitre wrote:
> On Wed, 7 Dec 2011, Holger Brunck wrote:
> 
>> set_bit and clear_bit are already atomic operations. So use this
>> functions to set or unset gpio configurations. This makes the
>> additional spinlock unneeded.
>>
>> Signed-off-by: Stefan Bigler <stefan.bigler@keymile.com>
>> Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
>> cc: Lennert Buytenhek <kernel@wantstofly.org>
>> cc: Nicolas Pitre <nico@fluxnic.net>
>> cc: Russell King <linux@arm.linux.org.uk>
>> cc: Thomas Gleixner <tglx@linutronix.de>
> 
> NAK.
> 
> Although this ends up equivalent in practice at the moment, the IO space 
> accessed through readl() and writel() is conceptually a different thing 
> than normal memory where the atomic set/clear bit functions are used.  
> There is no guarantee that the value passed to readl()/writel() will 
> always match the virtual address where the access is performed.
> 
> Furthermore, there is no guarantee made by the atomic bit manipulation 
> routines about the actual access to memory.  At one point those used to 
> be implemented with byte accesses not word accesses, and there is 
> nothing preventing the implementation from changing in similar ways in 
> the future that might have unwanted effects with IO memory.
> 
> And if using an ARMv6+ core as found in the Marvell Dove or MV78xx0 SOCs 
> which this patch also affects then the atomic bitops are implemented in 
> terms of the load/store exclusive instructions which are architecturally 
> not defined when applied to IO space.
> 

Ok, thanks for the explanation.

Best regards
Holger Brunck
