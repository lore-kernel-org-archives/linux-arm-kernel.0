From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 May 2017 17:25:07 +0100
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <004c01d23003$7230ed90$5692c8b0$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
 <a3d4533f-165d-f444-7681-141479617a18@arm.com>
 <004c01d23003$7230ed90$5692c8b0$@codeaurora.org>
Message-ID: <20170523162507.GA1729@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2016 at 09:07:23AM +0530, Sricharan wrote:
> Hi Robin,
> 
> >-----Original Message-----
> >From: Robin Murphy [mailto:robin.murphy at arm.com]
> >Sent: Wednesday, October 26, 2016 8:37 PM
> >To: Sricharan R <sricharan@codeaurora.org>; will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org; linux-arm-
> >kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; laurent.pinchart at ideasonboard.com; m.szyprowski at samsung.com;
> >tfiga at chromium.org; srinivas.kandagatla at linaro.org
> >Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
> >
> >On 04/10/16 18:03, Sricharan R wrote:
> >> The dma_ops for the device is not getting set to NULL in
> >> arch_tear_down_dma_ops and this causes an issue when the
> >> device's probe gets deferred and retried. So reset the
> >> dma_ops to NULL.
> >
> >Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> >
> 
>  Thanks.
> 
> >This seems like it could stand independently from the rest of the series
> >- might be worth rewording the commit message to more general terms,
> >i.e. arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
> >thus clearing the ops set by the latter, and sending it to Russell as a
> >fix in its own right.
> 
>   Ok, will reword the commit log and push this separately.

So, I've come to apply this patch (since it's finally landed in the patch
system), and I'm not convinced that the commit message is really up to
scratch.

The current commit message looks like this:

"   ARM: 8674/1: dma-mapping: Reset the device's dma_ops

    arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops(),
    dma_ops should be cleared in the teardown path. Otherwise this causes
    problem when the probe of device is retried after being deferred. The
    device's iommu structures are cleared after EPROBEDEFER error, but on
    the next try dma_ops will still be set to old value, which is not right."

It is obviously a fix, but a fix for which patch?  Looking at the
history, we have "arm: dma-mapping: Don't override dma_ops in
arch_setup_dma_ops()" which I would have guessed is the appropriate
one, but this post-dates your patch (it's very recent, v4.12-rc
recent.)

So, I need more description about the problem you were seeing when
you first proposed this patch.

How does leaving the dma_ops in place prior to "arm: dma-mapping:
Don't override dma_ops in arch_setup_dma_ops()" cause problems for
deferred probing?

What patch is your change trying to fix?  In other words, how far
back does this patch need to be backported?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
