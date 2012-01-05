From: eric.miao@linaro.org (Eric Miao)
Date: Thu, 5 Jan 2012 17:34:37 +0800
Subject: [PATCH v3 2/2] dma/imx-sdma: use writel to write register when
 enable a channel
In-Reply-To: <20120105091904.GO2414@b20223-02.ap.freescale.net>
References: <1325750362-22598-1-git-send-email-richard.zhao@linaro.org>
 <1325750362-22598-3-git-send-email-richard.zhao@linaro.org>
 <20120105092316.GB1729@S2101-09.ap.freescale.net>
 <20120105091904.GO2414@b20223-02.ap.freescale.net>
Message-ID: <CAMPhdO9rJEMKyyL_SMkb7XsRdd3G_A63biQ=Uu3WUD0geJTwYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2012 at 5:19 PM, Richard Zhao <richard.zhao@freescale.com> wrote:
> Hi Shawn,
>
> On Thu, Jan 05, 2012 at 05:23:17PM +0800, Shawn Guo wrote:
>> On Thu, Jan 05, 2012 at 03:59:22PM +0800, Richard Zhao wrote:
>> > dma_alloc_coherent memory may be bufferable when set
>> > CONFIG_ARM_DMA_MEM_BUFFERABLE. We need to add nececcary
>> > memory barrier. writel implicitly call wmb in such case.
>> >
>> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
>> > ---
>> > ?drivers/dma/imx-sdma.c | ? ?2 +-
>> > ?1 files changed, 1 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
>> > index c2bc4f1..e987468 100644
>> > --- a/drivers/dma/imx-sdma.c
>> > +++ b/drivers/dma/imx-sdma.c
>> > @@ -396,7 +396,7 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
>> >
>> > ?static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
>> > ?{
>> > - ? __raw_writel(1 << channel, sdma->regs + SDMA_H_START);
>> > + ? writel(1 << channel, sdma->regs + SDMA_H_START);
>> > ?}
>> >
>>
>> As educated by Arnd, generally it's safer to use pair of readl/writel
>> than __raw_readl/__raw_writel in driver. ?I'm wondering if it's a good
>> opportunity for us to change the pair all over this driver.
> Russel mentioned that too. But I cannot understand.
> If CONFIG_ARM_DMA_MEM_BUFFERABLE, readl/writel always call rmb/wmb. Do
> we realy need it? It might affect performance.

It's generally a good idea to use readl() and writel() unless it's performance
critical, e.g. where endian conversion is not necessary and IO read/write
order doesn't matter.

As MT_DEVICE is strongly ordered, I think it'll be OK for __raw_{read,write}l()
to be used for those ioremap() register accesses, not necessarily to those
ioremap_*() version though.
