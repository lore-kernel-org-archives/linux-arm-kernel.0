From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 6 Nov 2014 09:33:54 -0800
Subject: [PATCH] ARM: dts: zynq: Enable PL clocks for Parallella
In-Reply-To: <1415294531-8942-1-git-send-email-afaerber@suse.de>
References: <1415294531-8942-1-git-send-email-afaerber@suse.de>
Message-ID: <e78290abdb85497081f502e5886bf045@BL2FFO11FD057.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On Thu, 2014-11-06 at 06:22PM +0100, Andreas F?rber wrote:
> The Parallella board comes with a U-Boot bootloader that loads one of
> two predefined FPGA bitstreams before booting the kernel. Both define an
> AXI interface to the on-board Epiphany processor.
> 
> Enable clocks FCLK0..FCLK3 for the Programmable Logic by default.
> 
> Otherwise accessing, e.g., the ESYSRESET register freezes the board,
> as seen with the Epiphany SDK tools e-reset and e-hw-rev, using /dev/mem.

Yeah, this is the problem. Bypassing the kernel banging on memory
directly through /dev/mem does not leave any chance of enabling clocks on
demand through the proper interfaces.

Though, this is a valid workaround for the immediate problem, longer
term, you should consider adding some kind of proper kernel driver for
this interface that would then use the clock framework to control the
required clocks dynamically.

	S?ren
