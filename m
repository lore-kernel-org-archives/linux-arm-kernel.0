From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jun 2018 16:15:06 +0100
Subject: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180618162124.21749-2-bugalski.piotr@gmail.com>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
Message-ID: <20180619151506.GG11230@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 06:21:23PM +0200, Piotr Bugalski wrote:

> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}

If this can be empty should we adjust the callers to allow it to just be
omitted?

> +static int atmel_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
> +	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
> +
> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	clk_disable_unprepare(aq->clk);
> +
> +	spi_unregister_controller(ctrl);
> +
> +	return 0;
> +}

You should unregister the controller before disabling the hardware,
otherwise something could come in and try to start an operation on the
controller (or already be running one) while the hardware is disabled
which might blow up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/0ebd21f0/attachment.sig>
