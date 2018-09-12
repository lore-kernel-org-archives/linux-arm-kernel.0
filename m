From: vkoul@kernel.org (Vinod)
Date: Wed, 12 Sep 2018 10:05:30 +0530
Subject: [PATCH v2 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
In-Reply-To: <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
 <20180911070003.GI2634@vkoul-mobl>
 <CAK7LNASMhKfQT-Hqv48=HqOPRx3OVMtdNBEe=c7dE-B_5_Nuyw@mail.gmail.com>
Message-ID: <20180912043530.GE2766@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-09-18, 12:01, Masahiro Yamada wrote:
> Hi Vinod,
> 
> 
> 2018-09-11 16:00 GMT+09:00 Vinod <vkoul@kernel.org>:
> > On 24-08-18, 10:41, Masahiro Yamada wrote:
> >
> >> +/* mc->vc.lock must be held by caller */
> >> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
> >> +{
> >> +     u32 residue = 0;
> >> +     int i;
> >> +
> >> +     for (i = md->sg_cur; i < md->sg_len; i++)
> >> +             residue += sg_dma_len(&md->sgl[i]);
> >
> > so if the descriptor is submitted to hardware, we return the descriptor
> > length, which is not correct.
> >
> > Two cases are required to be handled:
> > 1. Descriptor is in queue (IMO above logic is fine for that, but it can
> > be calculated at descriptor submit and looked up here)
> 
> Where do you want it to be calculated?

where is it calculated now?

> This hardware provides only simple registers (address and size)
> for one-shot transfer instead of descriptors.
> 
> So, I used sgl as-is because I did not see a good reason
> to transform sgl to another data structure.


> > this seems missing stuff. Where do you do register calculation for the
> > descriptor and where is slave_config here, how do you know where to
> > send/receive data form/to (peripheral)
> 
> 
> This dmac is really simple, and un-flexible.
> 
> The peripheral address to send/receive data from/to is hard-weird.
> cfg->{src_addr,dst_addr} is not configurable.
> 
> Look at __uniphier_mdmac_handle().
> 'dest_addr' and 'src_addr' must be set to 0 for the peripheral.

Fair enough, what about other values like addr_width and maxburst?
-- 
~Vinod
