From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jul 2015 11:48:12 +0100
Subject: [PATCH 3/4] irqchip, gicv3: Implement Cavium ThunderX erratum
 23154
In-Reply-To: <1435673643-31676-4-git-send-email-rric@kernel.org>
References: <1435673643-31676-1-git-send-email-rric@kernel.org>
 <1435673643-31676-4-git-send-email-rric@kernel.org>
Message-ID: <20150706104812.GD7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 30, 2015 at 04:14:02PM +0200, Robert Richter wrote:
> +static u64 gic_read_iar_cavium_thunderx(void)
>  {
>  	u64 irqstat;
>  
> +	asm volatile("nop;nop;nop;nop;");
> +	asm volatile("nop;nop;nop;nop;");
>  	asm volatile("mrs_s %0, " __stringify(ICC_IAR1_EL1) : "=r" (irqstat));
> +	asm volatile("nop;nop;nop;nop;");
> +	mb();

NAK.  Please read the GCC manual for proper use of asm().  Even with
"volatile" there, it doesn't stop GCC from inserting instructions
between these.

If you need an instruction sequence to be consecutive, then it _must_
be one single asm().

There should also be a comment explaining why that code is necessary
here.  Please think about the future when you've forgotten why those
nops are there.  The kernel is a long term project, and it's important
that people understand why things are coded the way they are so that
the kernel can be properly maintained into the future.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
