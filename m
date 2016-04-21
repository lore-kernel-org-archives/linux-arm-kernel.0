From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Apr 2016 13:20:03 +0200
Subject: [PATCH 02/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 driver header file
In-Reply-To: <1461236675-10176-3-git-send-email-peter.griffin@linaro.org>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <3852823.Jd9ACgHlZU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 April 2016 12:04:19 Peter Griffin wrote:
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>

Please add a changelog text for each patch.

>  drivers/dma/st_fdma.h | 281 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 281 insertions(+)
>  create mode 100644 drivers/dma/st_fdma.h

When the header file is only included from one other file, it's
usually better to move the entire contents into the .c file.

> +#define fdma_read(fdev, name) \
> +	readl_relaxed((fdev)->io_base + FDMA_##name##_OFST)
> +
> +#define fdma_write(fdev, val, name) \
> +	writel_relaxed((val), (fdev)->io_base + FDMA_##name##_OFST)

Try to avoid string concatenation for macro names. It's better
to always pass the full name of the register in there to make
it easier to grep for the usage when trying to understand the
driver as a reader.

Once you do that, just convert the macro into an inline function.

> +bool st_fdma_filter_fn(struct dma_chan *chan, void *param);

The filter function should not be needed here.

	Arnd
