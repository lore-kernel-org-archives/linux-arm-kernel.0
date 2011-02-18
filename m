From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 18 Feb 2011 16:44:17 +0100
Subject: [PATCH 1/2] PRUSS UIO driver support
In-Reply-To: <1298041530-26855-2-git-send-email-pratheesh@ti.com>
References: <1298041530-26855-1-git-send-email-pratheesh@ti.com>
	<1298041530-26855-2-git-send-email-pratheesh@ti.com>
Message-ID: <201102181644.17634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 February 2011, Pratheesh Gangadhar wrote:
> Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> 
> This patch implements PRUSS (Programmable Real-time Unit Sub System)
> UIO driver which exports SOC resources associated with PRUSS like
> I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> processors which is efficient in performing embedded tasks that
> require manipulation of packed memory mapped data structures and
> efficient in handling system events that have tight real time
> constraints. This driver is currently supported on Texas Instruments
> DA850, AM18xx and OMAPL1-38 devices.
> For example, PRUSS runs firmware for real-time critical industrial
> communication data link layer and communicates with application stack
> running in user space via shared memory and IRQs.

Looks basically ok, but there are two limitations that I see that you
might consider fixing.

Oh, and you should put the Signed-off-by statement below the changelog,
not above it, but that has nothing to do with the code.

> +/*
> + * Host event IRQ numbers from PRUSS 	
> + * 3 PRU_EVTOUT0 PRUSS Interrupt
> + * 4 PRU_EVTOUT1 PRUSS Interrupt
> + * 5 PRU_EVTOUT2 PRUSS Interrupt
> + * 6 PRU_EVTOUT3 PRUSS Interrupt
> + * 7 PRU_EVTOUT4 PRUSS Interrupt
> + * 8 PRU_EVTOUT5 PRUSS Interrupt
> + * 9 PRU_EVTOUT6 PRUSS Interrupt
> + * 10 PRU_EVTOUT7 PRUSS Interrupt
> +*/
> +
> +#define MAX_PRUSS_EVTOUT_INSTANCE	(8)
> +
> +static struct clk *pruss_clk;
> +static struct uio_info *info[MAX_PRUSS_EVTOUT_INSTANCE];
> +static void *ddr_virt_addr;
> +static dma_addr_t ddr_phy_addr;

By making all of these static variables, you limit youself to
a single PRUSS instance in the system. It's generally better
to write device drivers in a way that makes it possible to
have multiple instances, e.g. by moving these four variables
into the 'priv' part of struct uio_info.

> +static irqreturn_t pruss_handler(int irq, struct uio_info *dev_info)
> +{
> +	return IRQ_HANDLED;
> +}

An empty interrupt handler is rather pointless. I guess you really
notify user space when the interrupt handler gets called, as this
is the main point of a UIO driver as far as I understand it.

	Arnd
