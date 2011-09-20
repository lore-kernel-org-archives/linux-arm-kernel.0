From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 20 Sep 2011 10:10:11 +0530
Subject: [PATCH v2] dmaengine: add CSR SiRFprimaII DMAC driver
In-Reply-To: <CAGsJ_4y0F7JTwFwesVvbgq1Lupw+a_-EpiTwW9GtXxOauohdVQ@mail.gmail.com>
References: <1316166960-20964-1-git-send-email-Baohua.Song@csr.com>
	<1316422774.26662.30.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E9840F3A8D@SHAASIEXM01.ASIA.ROOT.PRI>
	<1316425277.26662.41.camel@vkoul-udesk3>
	<5EB3BFCD089AD643B9BB63439F5FD5E9840F3B18@SHAASIEXM01.ASIA.ROOT.PRI>
	<1316430878.26662.46.camel@vkoul-udesk3>
	<CAGsJ_4y0F7JTwFwesVvbgq1Lupw+a_-EpiTwW9GtXxOauohdVQ@mail.gmail.com>
Message-ID: <CAJe_ZhdA17cB4WqoARct98NjDu8OhD76r6_S7JHOMdFDZ17wrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 September 2011 16:55, Barry Song <21cnbao@gmail.com> wrote:
> 2011/9/19 Vinod Koul <vinod.koul@intel.com>:
>> On Mon, 2011-09-19 at 09:56 +0000, Barry Song wrote:
>>> > > > Not sure why you support this, there seem to be no DMA_SLAVE
>>> support in
>>> > > > this version ate least
>>> > >
>>> > > Not. I support dma_slave. But I have no prep_slave_sg function
>>> since I can
>>> > use the gen xfer to replace it.
>>> > Yes thats okay...
>>> >
>>> > Then I have questions on genxfer function...
>>> > where are you copying either src or dstn_start address, you seem to
>>> > completely ignore them?
>>>
>>> Since I only support memory->device or device ->memory, and channel
>>> number is fixed to every device. Then I actually don't care device
>>> address at all. Either src or dst is fixed to the device's address.
>> peripheral address can be fixed, not the memory, where do you copy the
>> memory address?
>
> +static int sirfsoc_dma_slave_config(struct sirfsoc_dma_chan *schan,
> + ? ? ? struct dma_slave_config *config)
> +{
> + ? ? ? u32 addr, direction;
> + ? ? ? unsigned long flags;
> +
> + ? ? ? switch (config->direction) {
> + ? ? ? case DMA_FROM_DEVICE:
> + ? ? ? ? ? ? ? direction = 0;
> + ? ? ? ? ? ? ? addr = config->dst_addr;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? case DMA_TO_DEVICE:
> + ? ? ? ? ? ? ? direction = 1;
> + ? ? ? ? ? ? ? addr = config->src_addr;
> + ? ? ? ? ? ? ? break;
> +
> + ? ? ? default:
> + ? ? ? ? ? ? ? return -EINVAL;
> + ? ? ? }
> + ?...
I repeat
{
Pass addresses using dmaxfer_template.src_start and dmaxfer_template.dst_start
instead of dma_slave_config.dst_addr and dma_slave_config.src_addr
}
