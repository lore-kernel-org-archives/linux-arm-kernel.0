From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Aug 2013 17:44:42 +0100
Subject: [PATCH V1 4/5] spi: Add Freescale QuadSpi driver
In-Reply-To: <1376885403-12156-5-git-send-email-b32955@freescale.com>
References: <1376885403-12156-1-git-send-email-b32955@freescale.com>
 <1376885403-12156-5-git-send-email-b32955@freescale.com>
Message-ID: <20130823164442.GA30359@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 12:10:02PM +0800, Huang Shijie wrote:

Looks good apart from the issues people identified already and a few
small things below:

> +/* Instruction set for the LUT register. */
> +#define CMD			1
> +#define ADDR			2
> +#define DUMMY			3
> +#define MODE			4
> +#define MODE2			5
> +#define MODE4			6
> +#define READ			7
> +#define WRITE			8
> +#define JMP_ON_CS		9
> +#define ADDR_DDR		10
> +#define MODE_DDR		11
> +#define MODE2_DDR		12
> +#define MODE4_DDR		13

Most of the defines in the driver ought to be namespaced to avoid
collisions with other things defining them.  FSL_QSPI_ or something for
example.

> +	default:
> +		dev_err(q->dev, "Unsupported cmd 0x%.2x\n", cmd);
> +		break;
> +	}
> +	return -1;

Return a proper error code.

> +static int fsl_qspi_wait_till_ready(struct fsl_qspi *q)
> +{
> +	unsigned long deadline;
> +	u32 sr;
> +
> +	deadline = jiffies + msecs_to_jiffies(40000);
> +
> +	do {
> +		if ((sr = fsl_qspi_read_sr(q)) < 0)
> +			break;
> +		else if (!(sr & SR_WIP))
> +			return 0;
> +
> +		cond_resched();
> +
> +	} while (!time_after_eq(jiffies, deadline));
> +
> +	return 1;
> +}

Return an error code if we time out?

> +static int fsl_qspi_nor_do_one_msg(struct spi_master *master,
> +		struct spi_message *m)
> +{
> +	struct fsl_qspi *q = spi_master_get_devdata(master);
> +	struct spi_transfer *t;
> +	int ret = 0;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		if (t->rx_buf && t->tx_buf) {
> +			dev_err(q->dev,
> +				"Can't send and receive simultaneously\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (t->tx_buf) {
> +			ret = fsl_qspi_nor_tx(q, t);
> +			if (!ret)
> +				m->actual_length += t->len;
> +			continue;
> +		}
> +
> +		if (t->rx_buf) {
> +			ret = fsl_qspi_nor_rx(q, t);
> +			if (!ret)
> +				m->actual_length += t->len;
> +		}
> +	}

The driver should flag SPI_HALF_DUPLEX since it doesn't support
simultaneous RX and TX.

> +	q->clk_en = devm_clk_get(&pdev->dev, "qspi_en");
> +	q->clk = devm_clk_get(&pdev->dev, "qspi");
> +	if (IS_ERR(q->clk_en) || IS_ERR(q->clk)) {
> +		dev_err(&pdev->dev, "failed to get clocks\n");
> +		ret = -ENOENT;
> +		goto map_failed;
> +	}

Should use the actual returned error value from devm_clk_get().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/9cbe573e/attachment.sig>
