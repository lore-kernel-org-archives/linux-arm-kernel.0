From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 03 Apr 2012 17:42:56 +0300
Subject: [PATCH] ARM: pxa: mfp: Force gpio direction for
 MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1333456258.38206.YahooMailClassic@web29003.mail.ird.yahoo.com>
References: <1333456258.38206.YahooMailClassic@web29003.mail.ird.yahoo.com>
Message-ID: <4F7B0C70.2040005@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/12 15:30, Paul Parsons wrote:
> Hello Igor,

[...]

>> Now I can see that it will not... because of the below
>> line:
>> GPDR(i * 32) = gpdr_lpm[i];
>>
>> in the pxa2xx_mfp_suspend() function.#
> 
> Which is precisely the issue this patch addresses, namely to force
> the gpdr_lpm[] direction to output for KEEP_OUTPUT configurations.

Yes, but it changes the meaning of KEEP_OUTPUT and that is not good.

[...]

>>> Don't prevent a GPIO input being changed to an output
>> when entering
>>> suspend().
>>
>> Why should they prevent that? In case of bidirectional GPIOs
>> it is
>> perfectly fine.
> 
> I didn't say they should prevent that. I said they don't prevent
> that, thereby allowing the direction of an input gpio to be changed
> to output before the PGSR value is applied.

Ok, I see.

> 
>>
>>>
>>> By the way, there is still the issue of DRIVE_HIGH and
>> DRIVE_LOW
>>> forcing the GPIO direction to output in
>> pxa2xx_mfp_suspend()
>>> *before* the PGSR values take effect. Surely a bug?
>>
>> No, the order is not important as the final setting is done
>> by the h/w
>> during the suspend transition.
> 
> No, the GPIO direction is changed by software, not hardware.
> Hardware suspend does not change the GPIO direction, it only
> drives the GPIO values from the PGSR registers.

Yes, that is correct.

> 
> Thus there is a definite window between the direction being changed
> by software and the PGSR value being driven by hardware.

Right, this is the cost of lack of the h/w MFP support :-(

> 
> Within that window, the output values are indeterminate, at least
> as far as the suspend software is concerned.
> 
> So unless valid output values have already been programmed onto
> those input GPIOs beforehand, this direction/PGSR window is a bug.

Yep, sounds correct.

[...]

>> Please, check the attached patch.
>> It should not change the meaning of KEEP_OUTPUT, but fix the
>> bug.
> 
> Yes, that fixes the KEEP_OUTPUT bug.

Can this be considered as Tested-by for the formal patch?

> 
> It would be beneficial if someone could formally document the precise
> meaning of KEEP_OUTPUT.

I will try to do it along with the formal patch submission.

> 
> The direction/PGSR window bug is still present though.

Yet another patch "closing windows" attached,
care to check/test it please?

> 
> I'm starting to think it would be better for pxa2xx_mfp_suspend()
> to not touch GPDR at all, ever. Thus outputs would remain outputs,
> inputs would remain inputs. That would solve the latter bug and
> simplify PXA2xx MFP, but at the cost of making DRIVE_HIGH/DRIVE_LOW
> conditional like KEEP_OUTPUT.

I don't think it is a good idea, because then DRIVE_HIGH/DRIVE_LOW will
have different meaning between the platforms (SoCs).
How about the attached patch to fix this "windows" thing for PXA2xx?

> 
> It would be beneficial if someone could formally document the precise
> meaning of DRIVE_HIGH/DRIVE_LOW.

I can try doing it along with the formal version of the attached patch,
if we will consider it as a solution.

[...]

>> No, your patch will change also the inputs to outputs.
>> Because "last level" does not apply to input pins.
> 
> My point was that KEEP_OUTPUT configurations are only applied to
> GPIOs used as outputs. So no directions would be changed in practice.

I failed to understand that from your previous posts.
Nevertheless, the patch in the previous email fixes exactly this.

-- 
Regards,
Igor.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pxa2xx-mfp2.patch
Type: text/x-patch
Size: 763 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120403/03d40497/attachment.bin>
