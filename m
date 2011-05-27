From: ak@linux.intel.com (Andi Kleen)
Date: Fri, 27 May 2011 09:53:06 -0700
Subject: [PATCH] ARM: Do not allow unaligned accesses when
	CONFIG_ALIGNMENT_TRAP
In-Reply-To: <1306490709.26257.4.camel@e102144-lin.cambridge.arm.com>
References: <20110523111648.10474.78396.stgit@e102109-lin.cambridge.arm.com>	
	<20110523132124.GI17672@n2100.arm.linux.org.uk>	
	<1306229953.19557.14.camel@e102109-lin.cambridge.arm.com>	
	<yw1xipt0p4i9.fsf@unicorn.mansr.com>	
	<BANLkTi=xLE9gP5YOdr9dR0DfsY1Ymzxu+w@mail.gmail.com>	
	<20110524171331.GA2941@arm.com>	
	<20110525111405.GA12010@e102109-lin.cambridge.arm.com>	
	<20110525124348.GA2340@arm.com>
	<yw1xaaeanbxe.fsf@unicorn.mansr.com>	
	<BANLkTim2TOZgB-3Vkv5RcK572Qr07s3=CA@mail.gmail.com>	
	<1306429854.26735.9.camel@e102144-lin.cambridge.arm.com>	
	<alpine.LFD.2.00.1105261650330.3207@xanadu.home>	
	<4DDEC1C0.20807@linux.intel.com>
	<1306490709.26257.4.camel@e102144-lin.cambridge.arm.com>
Message-ID: <4DDFD6F2.1040304@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Do you have any concrete examples of -fconserve-stack giving an overall
> win that isn't in the noise? The fact that the GCC documentation
> explicitly states that enabling the option can lead to `making the
> program slower' does make me question why we're enabling it in the first
> place.

Because the kernel has a limited stack. We had a few cases in the past where
inlining blew it, especially in large ioctl switch() functions which inlined
lots of others.

On modern gccs it's better because it is smarter about sharing stack 
slots in large
functions. This was also worked around with manual noinlines.

But it's still far safer to tell gcc to conserve stack.

I consider the ARM gcc behaviour just a bug. The thing was really only 
intended
for the inliner (I asked for it originally)

-Andi
