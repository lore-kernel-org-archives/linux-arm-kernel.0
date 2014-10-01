From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Oct 2014 14:20:57 +0100
Subject: [PATCH] arm: socfpga: fix fetching cpu1start_addr for system
 with  > 2GB of ram
In-Reply-To: <1412161334-12359-1-git-send-email-dinguyen@opensource.altera.com>
References: <1412161334-12359-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20141001132057.GO5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 06:02:14AM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> When CPU1 is brought out of reset, it's MMU is not turned yet, so it will only
> be able to use physical addresses. For systems with 1GB or less, clearing
> 0x40000000 will work just fine. However for systems with 2GB or more, we
> need to clear at least 0x80000000.
> 
> Essentially, the bic instruction is converting the cpu1start_addr from a
> virtual to a physical address. We should be using bic 0xf0000000 for all
> systems.

Err.  Why not do the job properly rather than create this type of hack?
This is not a fast path, so it's really not required to code it for an
absolute minimum number of cycles.  So...

	adr	r0, 1f		@ physical address of '1'
	ldmia	r0, {r1, r2}	@ load virtual address of '1' and 'cpu1start_addr'
	sub	r0, r0, r1	@ offset between virtual and physical
	ldr	r2, [r2, r0]	@ load *cpu1start_addr
	bx	r2
...
	.align
1:	.long	.
	.long	cpu1start_addr

will fix it properly.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
