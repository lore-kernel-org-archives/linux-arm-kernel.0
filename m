From: hjk@hansjkoch.de (Hans J. Koch)
Date: Wed, 2 Mar 2011 21:09:56 +0100
Subject: [PATCH v8 1/1] PRUSS UIO driver support
In-Reply-To: <1299065886-30099-2-git-send-email-pratheesh@ti.com>
References: <1299065886-30099-1-git-send-email-pratheesh@ti.com>
	<1299065886-30099-2-git-send-email-pratheesh@ti.com>
Message-ID: <20110302200956.GB23818@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 05:08:06PM +0530, Pratheesh Gangadhar wrote:
> This patch implements PRUSS (Programmable Real-time Unit Sub System)
> UIO driver which exports SOC resources associated with PRUSS like
> I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> processors which is efficient in performing embedded tasks that
> require manipulation of packed memory mapped data structures and
> handling system events that have tight real time constraints. This
> driver is currently supported on Texas Instruments DA850, AM18xx and
> OMAP-L138 devices.
> For example, PRUSS runs firmware for real-time critical industrial
> communication data link layer and communicates with application stack
> running in user space via shared memory and IRQs.
> 
> Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/uio/Kconfig     |   17 ++++
>  drivers/uio/Makefile    |    1 +
>  drivers/uio/uio_pruss.c |  226 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 244 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/uio/uio_pruss.c

That looks good now, I don't see any further issues. But you should
address Arnd's comment about that __iomem stuff. It's a bit nit-picking,
but he's right, ioremap() returns void __iomem *, and uio_mem.internal_addr
also has that type.

> +static struct uio_info *info;
> +static dma_addr_t sram_paddr, ddr_paddr;
> +static void *prussio_vaddr, *sram_vaddr, *ddr_vaddr;

So the correct thing would be

static void __iomem *prussio_vaddr;
static void *sram_vaddr, *ddr_vaddr;

Thanks,
Hans
