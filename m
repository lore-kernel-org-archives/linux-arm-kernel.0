From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 23 May 2017 17:55:57 +0100
Subject: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
In-Reply-To: <20170523162507.GA1729@n2100.armlinux.org.uk>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
 <1475600632-21289-7-git-send-email-sricharan@codeaurora.org>
 <a3d4533f-165d-f444-7681-141479617a18@arm.com>
 <004c01d23003$7230ed90$5692c8b0$@codeaurora.org>
 <20170523162507.GA1729@n2100.armlinux.org.uk>
Message-ID: <a9debbce-17dc-aeaa-59bd-668aa15b97fe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/17 17:25, Russell King - ARM Linux wrote:
> On Thu, Oct 27, 2016 at 09:07:23AM +0530, Sricharan wrote:
>> Hi Robin,
>>
>>> -----Original Message-----
>>> From: Robin Murphy [mailto:robin.murphy at arm.com]
>>> Sent: Wednesday, October 26, 2016 8:37 PM
>>> To: Sricharan R <sricharan@codeaurora.org>; will.deacon at arm.com; joro at 8bytes.org; iommu at lists.linux-foundation.org; linux-arm-
>>> kernel at lists.infradead.org; linux-arm-msm at vger.kernel.org; laurent.pinchart at ideasonboard.com; m.szyprowski at samsung.com;
>>> tfiga at chromium.org; srinivas.kandagatla at linaro.org
>>> Subject: Re: [PATCH V3 6/8] arm: dma-mapping: Reset the device's dma_ops
>>>
>>> On 04/10/16 18:03, Sricharan R wrote:
>>>> The dma_ops for the device is not getting set to NULL in
>>>> arch_tear_down_dma_ops and this causes an issue when the
>>>> device's probe gets deferred and retried. So reset the
>>>> dma_ops to NULL.
>>>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>>
>>
>>  Thanks.
>>
>>> This seems like it could stand independently from the rest of the series
>>> - might be worth rewording the commit message to more general terms,
>>> i.e. arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops()
>>> thus clearing the ops set by the latter, and sending it to Russell as a
>>> fix in its own right.
>>
>>   Ok, will reword the commit log and push this separately.
> 
> So, I've come to apply this patch (since it's finally landed in the patch
> system), and I'm not convinced that the commit message is really up to
> scratch.
> 
> The current commit message looks like this:
> 
> "   ARM: 8674/1: dma-mapping: Reset the device's dma_ops
> 
>     arch_teardown_dma_ops() being the inverse of arch_setup_dma_ops(),
>     dma_ops should be cleared in the teardown path. Otherwise this causes
>     problem when the probe of device is retried after being deferred. The
>     device's iommu structures are cleared after EPROBEDEFER error, but on
>     the next try dma_ops will still be set to old value, which is not right."
> 
> It is obviously a fix, but a fix for which patch?  Looking at the
> history, we have "arm: dma-mapping: Don't override dma_ops in
> arch_setup_dma_ops()" which I would have guessed is the appropriate
> one, but this post-dates your patch (it's very recent, v4.12-rc
> recent.)
> 
> So, I need more description about the problem you were seeing when
> you first proposed this patch.
> 
> How does leaving the dma_ops in place prior to "arm: dma-mapping:
> Don't override dma_ops in arch_setup_dma_ops()" cause problems for
> deferred probing?
> 
> What patch is your change trying to fix?  In other words, how far
> back does this patch need to be backported?

In effect, it's fixing a latent inconsistency that's been present since
its introduction in 4bb25789ed28. However, that has clearly not proven
to be an issue in practice since then. With 09515ef5ddad we start
actually calling arch_teardown_dma_ops() in a manner that might leave
things partially initialised if anyone starts removing and reprobing
drivers, but so far that's still from code inspection[1] rather than
anyone hitting it.

Given that the changes which tickle it are fresh in -rc1 I'd say there's
no need to backport this, but at the same time it shouldn't do any
damage if you really want to.

Robin.

[1]:https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg14301.html
