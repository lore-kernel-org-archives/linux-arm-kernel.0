From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 8 Nov 2011 11:40:50 +0000
Subject: [PATCH] fix compilation breakage in entry-armv.S
In-Reply-To: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
References: <Pine.LNX.4.64.1111081232140.10851@axis700.grange>
Message-ID: <20111108114050.GC12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 12:36:36PM +0100, Guennadi Liakhovetski wrote:
> Compilation of Linus' tree of today without THUMB support for V7 machines 
> breaks:
> 
> linux-2.6/arch/arm/kernel/entry-armv.S: Assembler messages:
> linux-2.6/arch/arm/kernel/entry-armv.S:501: Error: backward ref to unknown label "2:"
> linux-2.6/arch/arm/kernel/entry-armv.S:502: Error: backward ref to unknown label "3:"
> make[2]: *** [arch/arm/kernel/entry-armv.o] Error 1
> 
> Fix this by adding a check for CONFIG_ARM_THUMB.

This still looks wrong.  The code for '2' and '3' is included when:

#if CONFIG_ARM_THUMB && __LINUX_ARM_ARCH__ >= 6 && CONFIG_CPU_V7

is true - so the condition on including it in the exception tables should
be the same as that.
