From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 9 Aug 2011 16:56:22 +0530
Subject: [PATCH 2/6] spi/spi-pl022: Use GFP_NOWAIT for allocation from
	tasklet
In-Reply-To: <cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
Message-ID: <CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 4:35 PM, Viresh Kumar <viresh.kumar@st.com> wrote:
> tasklets don't allow invocation to sleeping routines. In configure_dma()
> routine, sg_alloc_table() was called with GFP_KERNEL flag and so this causes
> crash when called from tasklet.
>
> Replace GFP_KERNEL with GFP_NOWAIT to get this fixed.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
> ?drivers/spi/spi-pl022.c | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f600d00..cbd9afe 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1019,11 +1019,11 @@ static int configure_dma(struct pl022 *pl022)
> ? ? ? ?pages = (pl022->cur_transfer->len >> PAGE_SHIFT) + 1;
> ? ? ? ?dev_dbg(&pl022->adev->dev, "using %d pages for transfer\n", pages);
>
> - ? ? ? ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_KERNEL);
> + ? ? ? ret = sg_alloc_table(&pl022->sgt_rx, pages, GFP_NOWAIT);
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?goto err_alloc_rx_sg;
>
> - ? ? ? ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_KERNEL);
> + ? ? ? ret = sg_alloc_table(&pl022->sgt_tx, pages, GFP_NOWAIT);
> ? ? ? ?if (ret)
> ? ? ? ? ? ? ? ?goto err_alloc_tx_sg;

Since this could be called from when we actually need the transfer start,
maybe we could try harder using GFP_ATOMIC instead ?
