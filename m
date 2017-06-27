From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Jun 2017 14:14:59 -0500
Subject: [PATCH 4/4] remoteproc/davinci: streamline the interrupt
 management
In-Reply-To: <20170627053845.GI18666@tuxbook>
References: <20170518220902.2846-1-s-anna@ti.com>
 <20170518220902.2846-5-s-anna@ti.com> <20170625211931.GC26155@builder>
 <8659b48d-5675-6bc9-aaf2-836ea69738d1@ti.com>
 <20170627053845.GI18666@tuxbook>
Message-ID: <396e16da-830b-ca10-297c-434b5618ca25@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2017 12:38 AM, Bjorn Andersson wrote:
> On Mon 26 Jun 09:09 PDT 2017, Suman Anna wrote:
> 
>> Hi Bjorn,
>>
>> On 06/25/2017 04:19 PM, Bjorn Andersson wrote:
>>> On Thu 18 May 15:09 PDT 2017, Suman Anna wrote:
>>>
>>>> The davinci remoteproc driver is currently requesting its interrupt
>>>> that deals with the virtio kicks in probe, and that too before all
>>>> the associated variables used by the handler are initialized. This
>>>> is a lot in advance before the DSP remote processor is even loaded
>>>> and booted and is not essential. Streamline the interrupt request
>>>> and freeing operations instead alongside the boot and shutdown of
>>>> the remote processor.
>>>>
>>>
>>> I do prefer that all resources are acquired at probe() time, rather than
>>> handled upon each start/stop. In the current handle_event()
>>> implementation the remoteproc code will not find the yet unallocated
>>> notify-id's and do nothing. So this seems okay.
>>>
>>> [..]
>>>> @@ -213,15 +224,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>>>  
>>>>  	platform_set_drvdata(pdev, rproc);
>>>>  
>>>> -	/* everything the ISR needs is now setup, so hook it up */
>>>> -	ret = devm_request_threaded_irq(dev, irq, da8xx_rproc_callback,
>>>> -					handle_event, 0, "da8xx-remoteproc",
>>>> -					rproc);
>>>> -	if (ret) {
>>>> -		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
>>>> -		goto free_rproc;
>>>> -	}
>>>
>>> In the error paths after this the driver will end up freeing the rproc
>>> context before disabling the irq, so these cases need a call to
>>> disable_irq().
>>
>> Hmm, I am not sure I understand why we need disable_irq() when we are
>> not even requesting it? This is deleting code, not adding. The IRQ
>> request and free are now balanced in the start and stop ops. The only
>> call here is a platform_get_irq() which doesn't need any cleanup.
>>
> 
> I prefer to keep the initialization of the irq at probe time. What I
> tried to say was that the code is currently broken in regards to the
> (theoretical?) possibility of the interrupt handler being invoked after
> "rproc" has been freed.
> 
>>>
>>>> -
>>>>  	/*
>>>>  	 * rproc_add() can end up enabling the DSP's clk with the DSP
>>>>  	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
>>>> @@ -254,14 +256,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
>>>>  static int da8xx_rproc_remove(struct platform_device *pdev)
>>>>  {
>>>>  	struct rproc *rproc = platform_get_drvdata(pdev);
>>>> -	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
>>>> -
>>>> -	/*
>>>> -	 * The devm subsystem might end up releasing things before
>>>> -	 * freeing the irq, thus allowing an interrupt to sneak in while
>>>> -	 * the device is being removed.  This should prevent that.
>>>> -	 */
>>>
>>> devres _will not_ disable the IRQ until after remove() returns, making it
>>> possible for the interrupt handler to be executed after the rproc
>>> context is freed.
>>>
>>> So this comment would benefit from an update.
>>
>> Again, this is deleting code, not adding. The remove after this cleanup
>> will simply be invoking the rproc_del() and rproc_free() call, and
>> rproc_del() does end up calling the stop since we do use auto-boot where
>> we free the irq.
>>
> 
> I would like to keep the request_irq in the probe() and as such a
> disable_irq is needed either in stop() or here. If we leave it here
> there's room to improve the comment.

Yeah, I did understand your statements after the discussion on the
keystone remoteproc thread, so ok with dropping this. The code already
has the disable_irq() in remove before rproc_free(), so just needs a
comment improvement. I will have to check the other sequences if there
are some missing dependencies, before revising this patch.

regards
Suman
