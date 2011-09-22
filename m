From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 22 Sep 2011 08:08:44 +0800
Subject: [PATCH] dmaengine: delete redundant chan_id and chancnt
	initialization in dma drivers
In-Reply-To: <CABb+yY2L=wfRoascoriAcnNMKkV7LbQEHCpp78+rCY=aM46x7A@mail.gmail.com>
References: <1316166200-20595-1-git-send-email-Baohua.Song@csr.com>
	<CABb+yY2L=wfRoascoriAcnNMKkV7LbQEHCpp78+rCY=aM46x7A@mail.gmail.com>
Message-ID: <CAGsJ_4zURv1_zJ0rwZawa8VSOw0kT9U4-cCCj2Q4-BhV1pdTHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/9/21 Jassi Brar <jassisinghbrar@gmail.com>:
> On Fri, Sep 16, 2011 at 3:13 PM, Barry Song <Baohua.Song@csr.com> wrote:
>> dma_async_device_register will re-init chan_id and chancnt,
>> so whatever chan_id and chancnt are set in drivers, they will
>> be re-written by dma_async_device_register.
>>
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Viresh Kumar <viresh.kumar@st.com>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: Piotr Ziecik <kosmo@semihalf.com>
>> Cc: Yong Wang <yong.y.wang@intel.com>
>> Cc: Jaswinder Singh <jassi.brar@samsung.com>
>> Cc: Pelagicore AB <info@pelagicore.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?drivers/dma/at_hdmac.c ? ? ?| ? ?5 ++---
>> ?drivers/dma/dw_dmac.c ? ? ? | ? ?5 ++---
>> ?drivers/dma/intel_mid_dma.c | ? ?2 --
>> ?drivers/dma/mpc512x_dma.c ? | ? ?1 -
>> ?drivers/dma/pch_dma.c ? ? ? | ? ?2 --
>> ?drivers/dma/pl330.c ? ? ? ? | ? ?2 --
>> ?drivers/dma/timb_dma.c ? ? ?| ? ?3 +--
>
> Apparently ....
>
> drivers/dma/ppc4xx/adma.c
> drivers/dma/ipu/ipu_idmac.c
> ? ? ? still write to chan_id.
>
> drivers/dma/amba-pl08x.c
> drivers/dma/fsldma.c
> drivers/dma/ioat/dma_v2.c
> drivers/dma/ioat/dma.c
> drivers/dma/mpc512x_dma.c
> drivers/dma/shdma.c
> ? ? ? still write to chancnt
>
> Most of them are simply a matter of removal, but some seem
> like really depending upon setting them(?)
>
> Anyways, even after you modify those as well, chan_id and chancnt
> are rendered overstaying guests in dmaengine core. Because chan_id
> of each channel would be _precisely_ the order in which the
> _dmac-driver_ added the channel to the 'channels' list.
>
> So if their values are _always_ gonna be just contiguously incrementing
> why need variables for that in the dmaengine api?
> Dmac drivers could use local variables for that.
>
> OTOH, why not chan_id be left solely for use by dmac drivers read by the
> dmaengine only to create sysfs entries ?

actually i don't like the way dmaengine core handles chan_id. in my
opinion, every dmac only needs to tell dmaengine core the chan_base.
then dmaengine core set the id in a global scale.

for example, if you have two dmac in system:
dmac0 chan_base 0
dmac1 chan_base 16
then core will have chan 0~31 by chan_id from 0 to 31 but not
dmac0chan0~15, dmac1chan0~15.

client drivers can request a specific chan_id just like it can request a gpio.

now dmac drivers and dmaengine core have repeated chan_id and chancnt,
anyway, it is a problem that should be fixed at first. then i'd like
to have some common function to support the request of specific
chan_id.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

-barry
