From: jassisinghbrar@gmail.com (jassi brar)
Date: Sat, 24 Apr 2010 11:06:39 +0900
Subject: [PATCH 3/7] SAMSUNG: PL330: DMA API: Add S3C DMA API driver for
	PL330
In-Reply-To: <1271835635-31309-1-git-send-email-jassisinghbrar@gmail.com>
References: <1271835635-31309-1-git-send-email-jassisinghbrar@gmail.com>
Message-ID: <g2z1b68c6791004231906t2dd31804vebe0be6d04b7c175@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 4:40 PM,  <jassisinghbrar@gmail.com> wrote:
> From: Jassi Brar <jassi.brar@samsung.com>
....
> +int s3c2410_dma_ctrl(enum dma_ch id, enum s3c2410_chan_op op)
> +{
> + ? ? ? struct s3c_pl330_chan *ch;
> + ? ? ? unsigned long flags;
> + ? ? ? enum pl330_chan_op pl330op;
> + ? ? ? int idx, ret;
> +
> + ? ? ? spin_lock_irqsave(&res_lock, flags);
> +
> + ? ? ? ch = id_to_chan(id);
> +
> + ? ? ? if (!ch || chan_free(ch)) {
> + ? ? ? ? ? ? ? ret = -EINVAL;
> + ? ? ? ? ? ? ? goto ctrl_exit;
> + ? ? ? }
> +
> + ? ? ? switch (op) {
> + ? ? ? case S3C2410_DMAOP_START:
> + ? ? ? ? ? ? ? pl330op = PL330_OP_START;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S3C2410_DMAOP_STOP:
> + ? ? ? ? ? ? ? pl330op = PL330_OP_ABORT;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case S3C2410_DMAOP_FLUSH:
> + ? ? ? ? ? ? ? pl330op = PL330_OP_FLUSH;
> + ? ? ? ? ? ? ? break;

Seems the NOP cases S3C2410_DMAOP_PAUSE, RESUME, TIMEOUT and
STARTED went missing. Those are needed here just for the sake of
completeness and have no effect on the overall functioning.
