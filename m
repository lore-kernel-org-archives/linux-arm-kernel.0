From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Thu, 22 Aug 2013 09:39:21 +0800
Subject: [PATCH v2 2/2] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <20130821045823.GK5810@intel.com>
References: <1372423153-6742-1-git-send-email-zhangfei.gao@linaro.org>
 <1372423153-6742-3-git-send-email-zhangfei.gao@linaro.org>
 <20130813112043.GB32147@intel.com>
 <CAMj5Bki0H+=0wQY39+jDw4nAEq5wEq3V3yri9xpNRxQ2GRwPbA@mail.gmail.com>
 <20130819053511.GU32147@intel.com>
 <CAMj5BkixUR2-MnYLVymPLnQ922jEhbKnwUHs__d3hr2d_Qb8fA@mail.gmail.com>
 <20130820082749.GG5810@intel.com> <5213359B.4070208@linaro.org>
 <20130820085037.GH5810@intel.com>
 <CAMj5Bkg_uQUgod0Cf9ZpLgX92Ys-u344BAFeHbrUwysG3pJVgw@mail.gmail.com>
 <20130821045823.GK5810@intel.com>
Message-ID: <CAMj5BkhxeV8oO+x8knj8m-N8wcD+reB5KWOhAUWTYjbk1OS2rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 12:58 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Aug 20, 2013 at 09:36:50PM +0800, zhangfei gao wrote:
>> > and how do you handle when the desc is running on a phy.
>>
>> Currently k3dma is used with uart.
>>
>> drivers/tty/serial/amba-pl011.c
>> pl011_dma_rx_irq: dmaengine_pause -> device_tx_status
>> First pause channel, then get residue.
>> k3_dma_tx_status:
>> a) if desc in issue queue, then it still not started, return total size.
>> b) otherwise get the residue via counting descriptor.
>> pl011 get the residue and recaculate the pending.
> Okay thanks, While looks like for uart this is usage (note this driver doesnt not
> call resume. So for that you dont need resume to be implemented.
>
> Also, the driver will call the residue and then terminate always. So again I dont
> see a point of yours with what your are doing with descriptors.
>
> And since you support PAUSE/RESUME, if someone tries to use this with sound,
> this will break as sound will call pause and then resume. No resubmitting or
> terminating.
>
>> Have pass the stress test with amba-pl011.
> See the example of amba-pl08x.c, I think Linux W had this in mind when he added
> this and other exapmple of PAUSE and RESUME implemented in drivers
>
> Also, again you PAUSE a channel not a trancation, so it doesnt not really matter
> where the descriptor is. In phy or somehwere else! We shouldnt care
>
> ~Vinod

Dear Vinod

I think your concern is device_tx_status does not return right pos.

prep_slave_sg -> vchan_tx_prep -> vd->tx.tx_submit = vchan_tx_submit;
vchan_tx_submit -> cookie = dma_cookie_assign(tx)
So one cookie is assigned for one tx_submit

sound/soc/soc-dmaengine-pcm.c:
dmaengine_pcm_prepare_and_submit -> dmaengine_prep_dma_cyclic ->
prtd->cookie = dmaengine_submit
The cookie is get for one pare prepare and submit.

k3_dma_tx_status:
If cookie is in the issue_queue, means sg list not send out, return
total size of the prepare, including all descriptor.
If the sg list already run, the count descriptor and return the left value.
Since only one cookie match all descriptor, or descriptor is organized
inside, transparent to upper layer, return total left bytes.

Is this fine?

Thanks
