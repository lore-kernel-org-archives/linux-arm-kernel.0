From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 16:19:39 +0000
Subject: [PATCH 10/11] tty: amba-pl011: add support for 32-bit register
 access
In-Reply-To: <5638CB41.1000807@codeaurora.org>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
 <E1Ztcw4-0007Ct-PP@rmk-PC.arm.linux.org.uk>
 <5638CB41.1000807@codeaurora.org>
Message-ID: <20151103161939.GB8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 08:57:05AM -0600, Timur Tabi wrote:
> Russell King wrote:
> >-	return readw(uap->port.membase + pl011_reg_to_offset(uap, reg));
> >+	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
> >+
> >+	return uap->access_32b ? readl(addr) : readw(addr);
> 
> Ok, ignore my previous email.  I just noticed this.
> 
> This version is fine, except that it now performs a runtime check for every
> I/O access.  Isn't that too much overhead?  access_32b will always be either
> True or False for the life of the entire SOC.

It's a balance between a few more branches and killing six registers
(r0 - r3, ip, lr) on every register access due to a function call.
If GCC was a reasonable compiler, it could be done without incuring
any branches, merely by using conditional instructions, but GCC on
ARM really sucks - it wants to reload the base address, offset and
access_32b flag on every device access despite the struct being
marked const.  You'll get the same with your approach when adding
the register offsets, but it'll be worse - the compiler will have to
also reload the function pointer as well on every access.

So, my gut feeling is that my approach is better than the function
pointer call, especially with modern CPUs with branch prediction.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
