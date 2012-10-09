From: viresh.kumar@linaro.org (viresh kumar)
Date: Tue, 9 Oct 2012 23:11:25 +0530
Subject: [PATCH 07/11] fsmc/nand: Provide contiguous buffers to dma
In-Reply-To: <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <2b88c853b3691338fae037f569917fc300cd6032.1349778821.git.vipin.kumar@st.com>
Message-ID: <CAOh2x=mwWPyPDQG1NZ-XKXCjxFuPdypUNcn8b-prmrv3f2QxsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 4:14 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> diff --git a/drivers/mtd/nand/fsmc_nand.c b/drivers/mtd/nand/fsmc_nand.c
> @@ -675,7 +676,8 @@ static void fsmc_read_buf_dma(struct mtd_info *mtd, uint8_t *buf, int len)
>         struct fsmc_nand_data *host;
>
>         host = container_of(mtd, struct fsmc_nand_data, mtd);
> -       dma_xfer(host, buf, len, DMA_FROM_DEVICE);
> +       dma_xfer(host, host->dma_buf, len, DMA_FROM_DEVICE);
> +       memcpy(buf, (const void *)host->dma_buf, len);

Ahh.. Too much overhead. Can't you do something better here?
- DMA can be done to user buffers too, Pratyush has done some work in
past on this.
- There must be some other way of sharing kernel buffer to user space.

--
viresh
