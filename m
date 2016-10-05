From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 5 Oct 2016 11:43:10 +0200
Subject: [PATCH 03/14] ASoC: sun4i-i2s: Add apb reset
In-Reply-To: <20161004154218.GM5228@lukather>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <2c5abe6578c8e4e841cb59357d88ce397551a593.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004141516.53c6fa8c@free-electrons.com> <20161004154218.GM5228@lukather>
Message-ID: <efd96516-c5f4-91d0-450d-7521b1b76ed7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 04/10/2016 17:42, Maxime Ripard wrote:
> Hi,
>
> On Tue, Oct 04, 2016 at 02:15:16PM +0200, Thomas Petazzoni wrote:
>> Hello,
>>
>> On Tue,  4 Oct 2016 11:46:16 +0200, Myl?ne Josserand wrote:
>>
>>>  #include <sound/dmaengine_pcm.h>
>>>  #include <sound/pcm_params.h>
>>> @@ -589,6 +590,7 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>>  {
>>>  	struct sun4i_i2s *i2s;
>>>  	struct resource *res;
>>> +	struct reset_control *reset_apb;
>>>  	void __iomem *regs;
>>>  	int irq, ret;
>>>
>>> @@ -626,7 +628,19 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
>>>  		dev_err(&pdev->dev, "Can't get our mod clock\n");
>>>  		return PTR_ERR(i2s->mod_clk);
>>>  	}
>>> -	
>>> +
>>> +	reset_apb = devm_reset_control_get(&pdev->dev, "apb_reset");
>>
>> I believe this is a change in the Device Tree binding, since you're
>> adding support for a new resource. Perhaps the Device Tree binding
>> documentation should be updated accordingly?
>
> Indeed.
>
> You have two solutions to do that:
>   - Either mark it as optional and use reset_control_get_optional
>     (because here, you broke the other SoCs that have that controller
>     but no reset line)
>   - Or introduce a new compatible, and make the reset property
>     mandatory for that new compatible.
>
> I prefer the latter, since you get a stricter error check, and you
> cannot end up in a situation where your driver probes but is
> useless. But you'll find both in our drivers.
>


Okay, thank you for the hints!


>>> +	}
>>> +
>>> +	ret = reset_control_deassert(reset_apb);
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "Can't deassert apb reset (%d)\n", ret);
>>> +		return ret;
>>> +	}
>>
>> Do you need to re-assert the reset line in the ->remove() hook?
>
> Even better, you can add it to the runtime_pm hooks! :)


I will have a look to runtime_pm and update it for a V2.


-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
