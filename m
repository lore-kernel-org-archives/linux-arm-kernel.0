From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 26 Jul 2012 15:02:18 +0800
Subject: [PATCH 1/3] dmaengine: mmp-pdma support
In-Reply-To: <1343285475.1726.8981.camel@vkoul-udesk3>
References: <1342763164-19208-1-git-send-email-zhangfei.gao@marvell.com>
 <1342763164-19208-2-git-send-email-zhangfei.gao@marvell.com>
 <1343285475.1726.8981.camel@vkoul-udesk3>
Message-ID: <CAMj5BkhpcV=J8goZXMHt2o6bGgn9KL+-mseALN8L2FOpgr2MgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 2:51 PM, Vinod Koul <vinod.koul@linux.intel.com> wrote:
> On Fri, 2012-07-20 at 13:46 +0800, Zhangfei Gao wrote:
>> +struct mmp_dma_platdata {
>> +       int chancnt;
>> +};
>> +
>> +struct mmp_dma_slave_config {
>> +       struct dma_slave_config slave_config;
>> +       u32 drcmr;
>> +};
> Why do you need these definitions?
>
> What is drcmr used for?

Hi, Vinod

"drcmr" is request_line, we used to select which channel map to
specific peripheral.
Is it possible adding request_line to slave_config?

Refer mail with Arnd before.
> For peripheral dma, one special requirement of DMA_RCMRx
> The register is used select which channel is mapped to the peripheral.
> The channel can be alloc dynamically, but the register is constant to
> specific peripheral.
> For example, nand_dma, pxa910 use DRCMR97 (0x1184), what's worse,
> pxa688 use DRCMR28 (0x170).
>
> There is no connection between channel number and drcmr, since channel
> is dynamically allocated.
> So we encapsulating the slave config parsing drcmr to dma-engine driver.

[Arnd]
Ah, so it is the request line. Now the current plan for this is to go
into the "dmas" property of the child device using the dma engine binding.

>
>
> --
> ~Vinod
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
