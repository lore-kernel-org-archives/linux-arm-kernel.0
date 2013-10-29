From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 29 Oct 2013 20:26:19 +0100
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <20131029155616.GG20207@joshc.qualcomm.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
 <526FD278.8080102@metafoo.de> <20131029155616.GG20207@joshc.qualcomm.com>
Message-ID: <52700BDB.5080403@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2013 04:56 PM, Josh Cartwright wrote:
>>> +{
>>> +	int dummy;
>>> +
>>> +	if (!ctrl)
>>> +		return -EINVAL;
>>> +
>>> +	dummy = device_for_each_child(&ctrl->dev, NULL,
>>> +				      spmi_ctrl_remove_device);
>>> +	device_unregister(&ctrl->dev);
>>
>> Should be device_del(). device_unregister() will do both device_del() and
>> put_device(). But usually you'd want to do something in between like release
>> resources used by the controller.
> 
> I'm not sure I understand your suggestion here.  If put_device() isn't
> called here, wouldn't we be leaking the controller?  What resources
> would I want to be releasing here that aren't released as part of the
> controller's release() function?
> 

Resources used by the driver implementing the controller. Usually the driver
state struct will be allocated by spmi_controller_alloc() as well. So if you
store resources in that struct, e.g. a clk you first want to unregister the
spmi controller to make sure that the resources are no longer accessed, then
free the resources and finally drop the reference to the controller so the
memory can be freed. E.g.

static int foobar_remove(struct platform_device *pdev)
{
	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
	struct foobar *foobar = spmi_controller_get_drvdata(ctrl);

	spmi_controller_remove(ctrl);

	free_irq(foobar->irq)
	clk_put(foobar->clk);
	...

	spmi_controller_put(ctrl);

	return 0;
}

>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(spmi_controller_remove);
>>> +
>> [...]
>>> +/**
>>> + * spmi_controller_alloc: Allocate a new SPMI controller
>>> + * @ctrl: associated controller
>>> + *
>>> + * Caller is responsible for either calling spmi_device_add() to add the
>>> + * newly allocated controller, or calling spmi_device_put() to discard it.
>>> + */
>>> +struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl);
>>> +
>>> +static inline void spmi_device_put(struct spmi_device *sdev)
>>
>> For symmetry reasons it might make sense to call this spmi_device_free().
> 
> Except that it doesn't necessarily free() the underlying device, so I
> find that more confusing.

Well, for all the driver cares the device has been freed.
