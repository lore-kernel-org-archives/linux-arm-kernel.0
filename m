From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Dec 2012 18:28:07 +0100
Subject: [PATCH] cpuidle: kirkwood: Move out of mach directory, add DT.
In-Reply-To: <50DDCF47.1030305@ti.com>
References: <1356698844-4220-1-git-send-email-andrew@lunn.ch>
 <50DDAA42.2020101@gmail.com> <20121228143517.GA5172@lunn.ch>
 <50DDB2E3.103@gmail.com> <20121228154927.GC5172@lunn.ch>
 <50DDC54A.3020509@gmail.com> <50DDCF47.1030305@ti.com>
Message-ID: <20121228172807.GA7578@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Putting DDR/SDRAM into self refresh means, you no longer have RAM
> available to execute and any code CPU needs to execute after that has
> to be executed either from lock down cache with no cache evictions or
> from some internal on chip memory with caches disabled to avoid accesses
> to DDR. Not sure how below code works if the first writel puts DDR into
> self refresh. Is cpu_do_idle() code copied to some internal memory ?
> 
> +	writel(0x7, ddr_operation_base);
> +	cpu_do_idle();
> 
> May be I am missing something but i have worked on such a code for OMAP3
> kind of devices and seen major issues with DDR self refresh and CPU
> entering into idle state.

Quoting the datasheet:

  To place the SDRAM into self refresh set the <Cmd> field in the
  SDRAM Operation Register (Table 174 p. 400) to 0x7. The SDRAM
  controller waits for 256 cycles and then generates a self refresh
  command to SDRAM, and clears the SDRAM Operation register.

I assume we always manage to execute the WFI within these 256 cycles.

There is also some text about handling new pending transactions, so
even if it does not WFI, e.g. because of an interrupts, it seems to do
the right thing.

    Andrew
