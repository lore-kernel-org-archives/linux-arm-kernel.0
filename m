From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Oct 2014 22:58:44 +0100
Subject: [PATCHv2] arm: socfpga: fix fetching cpu1start_addr for system
 with  > 2GB of ram
In-Reply-To: <1412370540-20670-1-git-send-email-dinguyen@opensource.altera.com>
References: <1412370540-20670-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20141003215844.GX5182@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 03, 2014 at 04:09:00PM -0500, dinguyen at opensource.altera.com wrote:
> From: Dinh Nguyen <dinguyen@opensource.altera.com>
> 
> When CPU1 is brought out of reset, it's MMU is not turned yet, so it will only
> be able to use physical addresses. For systems with 1GB or less, clearing
> 0x40000000 will work just fine, as it was just converting the virtual address
> of &cpu1start_addr into a physical address. But for systems with > 2BG, bit
> clearing 0x40000000 is not enough to get the physical address of &cpu1start_addr
> correctly.
> 
> This patch fixes the secondary_trampoline code to correctly fetch the physical
> address of cpu1start_addr directly.
> 
> While at it, change the name of cpu1start_addr to socfpga_cpu1start_addr
> to avoid any future naming collisions for multiplatform image.

I'm still not happy with this.  I see why my suggestion didn't work, but
this is still pretty dire - and will break when we add read-only text
support to the kernel (you are writing into the text segment.)

The reason my suggestion broke is because you aren't executing the code
in the kernel, you're copying it into SRAM and executing it there.  I
think you need to come up with some way to locate the physical address
in the SRAM, either before or after the function you're copying there.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
