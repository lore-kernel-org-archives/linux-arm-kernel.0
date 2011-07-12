From: sundaram@ti.com (Raju, Sundaram)
Date: Tue, 12 Jul 2011 16:26:32 +0530
Subject: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
	configuration
In-Reply-To: <CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
References: <1310310203-12288-1-git-send-email-sundaram@ti.com>
	<CABb+yY1HJOR+QzmM4-ju4cs+8keoyUbMv+SpVoM6BW=DCMzmQQ@mail.gmail.com>
	<CACRpkdbLg0+_2kpi4NizFj0fDWb6QPtkcKirKgoH+83vGD0O0A@mail.gmail.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94030259DB5B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Tuesday, July 12, 2011 3:33 PM
> To: Jassi Brar
> Cc: Raju, Sundaram; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; davinci-linux-open-source at linux.davincidsp.com;
> linux at arm.linux.org.uk; dan.j.williams at intel.com; linux-omap at vger.kernel.org
> Subject: Re: [PATCH] dmaengine: add dma_ctrl_cmd to pass buffer stride
> configuration
> 
> On Tue, Jul 12, 2011 at 6:17 AM, Jassi Brar <jassisinghbrar@gmail.com>
> wrote:
> 
> > 1) Striding, in one form or other, is supported by other DMACs as well.
> > ? The number will only increase in future.
> > ? Are we to add ?<VENDOR>_DMA_STRIDE_CONFIG for each case ?
> 
> If we are sure about this and striding will work in a similar way on all
> then let's have the enum named DMA_STRIDE_CONFIG and move the
> passed-in struct to <linux/dmaengine.h) then?
> 
> Would that be:
> 
> struct dma_stride_config {
>     u32 read_bytes;
>     u32 skip_bytes;
> };
> 
> Or something more complex?
> 

When I started this discussion on stride config, I received comments like
this is too specific to TI DMAC, and there are not many DMACs which can
do this. I actually wanted to generalize the configuration passed and put
a comment on it similar to the one on top of dma_slave_config, which says

|
|/**
<snip>
| * The rationale for adding configuration information to this struct
| * is as follows: if it is likely that most DMA slave controllers in
| * the world will support the configuration option, then make it
| * generic. If not: if it is fixed so that it be sent in static from
| * the platform data, then prefer to do that. Else, if it is neither
| * fixed at runtime, nor generic enough (such as bus mastership on
| * some CPU family and whatnot) then create a custom slave config
| * struct and pass that, then make this config a member of that
| * struct, if applicable.
| */
|

If any other DMAC can do similar stride configuration,
then we can generalize it. 

Till we generalize this stride configuration I think a custom
configuration aligned between the client driver and
the offload engine driver can be used.

> > 2) As Dan noted, client drivers are going to have ifdef hackery in
> > order to be common
> > ?to other SoCs.
> 
> Don't think so, why? This is a runtime config entirely, and I just illustrated
> in mail to Dan how that can be handled by falling back to a sglist I believe?
> 
> We can *maybe* even put the fallback code into dmaengine, so that an
> emulated sglist in place for the DMAengine is done automatically of the
> DMA controller does not support striding.
> 

Good Idea.

But the client might always have a better way to handle this fallback than
this suggested fallback code in dmaengine, which will be a common
implementation based on the received sg_list and the DMAC capabilities.
If this is done then preference should be provided to the client's fallback
implementation, if present.

> > 3) TI may not have just one DMAC IP used in all the SoCs. So if you want
> > ?vendor specific defines anyway, please atleast also add DMAC version to it.
> > ?Something like
> >> ? ? ? ?DMA_SLAVE_CONFIG,
> >> ? ? ? ?FSLDMA_EXTERNAL_START,
> >> + ? ? ? TI_DMA_v1_STRIDE_CONFIG,
> 
> Yep unless we make it generic DMA_STRIDE_CONFIG simply, this makes
> a lot of sense.
>

Okay, I can add one cmd for the EDMAC in DaVinci series of SoCs and 
one for SDMAC in OMAP series of SoCs.

Regards,
Sundaram
