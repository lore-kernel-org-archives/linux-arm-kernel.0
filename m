From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 17 Oct 2017 10:29:14 +0100
Subject: ARM64: Regression with commit e3067861ba66 ("arm64: add basic
 VMAP_STACK support")
In-Reply-To: <20171017003054.GB19504@leoy-ThinkPad-T440>
References: <20171010142725.GA24797@leoy-linaro>
 <20171010154558.GJ27659@leverpostej>
 <da09fd83-f3f0-f800-fea4-988cfa56bac7@arm.com>
 <20171016011723.GB12470@leoy-linaro>
 <20171016134819.jv3udrcwsedc4cgs@lakrids.cambridge.arm.com>
 <34ccf02d-fd65-bade-327a-ed8df1d3eea5@arm.com>
 <20171016142622.6yjuzdwxxw3sxjed@lakrids.cambridge.arm.com>
 <dad6105d-1ec0-d5a6-e78c-ff832afe3f9e@arm.com>
 <20171017003054.GB19504@leoy-ThinkPad-T440>
Message-ID: <20171017092914.op4hlzaaqfrpoizm@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 08:30:54AM +0800, Leo Yan wrote:
> On Mon, Oct 16, 2017 at 03:35:46PM +0100, Robin Murphy wrote:
> > On 16/10/17 15:26, Mark Rutland wrote:
> > > On Mon, Oct 16, 2017 at 03:12:45PM +0100, Robin Murphy wrote:
> > >> On 16/10/17 14:48, Mark Rutland wrote:
> > >>> On Mon, Oct 16, 2017 at 09:17:23AM +0800, Leo Yan wrote:
> > >>>> On Tue, Oct 10, 2017 at 05:03:44PM +0100, Robin Murphy wrote:
> > >>>>> On 10/10/17 16:45, Mark Rutland wrote:
> > >>>>>> On Tue, Oct 10, 2017 at 10:27:25PM +0800, Leo Yan wrote:
> > >>>>>>> I work mainline kernel on Hikey620 board, I find it's easily to
> > >>>>>>> introduce the panic and report the log as below. So I bisect the kernel
> > >>>>>>> and finally narrow down the commit e3067861ba66 ("arm64: add basic
> > >>>>>>> VMAP_STACK support") which introduce this issue.
> > >>>>>>>
> > >>>>>>> I tried to remove 'select HAVE_ARCH_VMAP_STACK' from
> > >>>>>>> arch/arm64/Kconfig, then I can see the panic issue will dismiss. So
> > >>>>>>> could you check this and have insight for this issue?

> > >>>> I enabled these debugging configs but cannot get clue from it; but
> > >>>> occasionally found this issue is quite likely related with CA53 errata,
> > >>>> especialy ERRATA_A53_855873 is the relative one. So I changed to use
> > >>>> ARM-TF mainline code with ERRATA fixing, this issue can be dismissed.

> > >>> Just to confirm, with the updated firmware you no longer see the issue?
> > >>>
> > >>> I can't immediately see how that would be related.

> > I guess the vmap addresses might tickle the "same L2 set" condition
> > differently to when both stack and DMA buffer are linear map addresses.
> 
> A bit more info for this.
> 
> I can reproduce this memory abort panic, and the panic places are not
> consistent; usually it's related with kmalloc address. Do you think
> "VMAP_STACK" introduces much more operations for cache clean? If
> so if might be in the same *set* with any other memory access (like
> kmalloc operations), then trigger data abort.

VMAP_STACK doesn't introduce any explicit cache maintenance, but it's
possible that it causes more natural evictions. 

That might explain why it triggers the issue.

> Hikey has CA53 CPUs is r3 version so it's luck can directly apply the
> ERRATA 855873 in ARM-TF.
>
> BTW, in case I may mislead you guys, we should note there have another
> two ERRATAs applied in ARM-TFv1.4 for Hikey:
> 
> ERRATA_A53_836870               :=      1
> ERRATA_A53_843419               :=      1

Thanks for the extra info!

AFAICT, erratum 836870 results in livelock rather than memory
corruption, so I think we can ignore that.

I'm a little worried by erratum 843419. The VMAP_STACK patches changed
{adr,ldr}_this_cpu (and some users thereof), and it's possible we're
managing to tickle that issue.

If you still have an affected kernel, could you dump the output of:

$ aarch64-linux-gnu-objdump -d vmlinux | grep -A 3 'ff[8c]:\s\+[a-f0-9]\+\s\+adrp'

... that would show us if there are any affected sequences.

>From a quick scan of my own vmlinux build from commit e3067861ba66, I
didn't see any, but it's possible this depends on the config used.

Thanks,
Mark.
