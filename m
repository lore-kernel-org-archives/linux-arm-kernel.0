From: sbranden@broadcom.com (Scott Branden)
Date: Mon, 2 Mar 2015 11:37:57 -0800
Subject: [PATCH v4 2/2] Input: bcm-keypad: Add Broadcom keypad controller
In-Reply-To: <20150228221518.GB36282@dtor-ws>
References: <sbranden@broadcom.com>
 <1425141357-7807-1-git-send-email-sbranden@broadcom.com>
 <1425141357-7807-3-git-send-email-sbranden@broadcom.com>
 <20150228221022.GA36282@dtor-ws> <20150228221518.GB36282@dtor-ws>
Message-ID: <54F4BC15.4020205@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

I don't see the need for a check of the clock in bcm_kp_start or stop. 
See comment below.

On 15-02-28 02:15 PM, Dmitry Torokhov wrote:
> On Sat, Feb 28, 2015 at 02:10:22PM -0800, Dmitry Torokhov wrote:
>> Hi Scott,
>>
>> On Sat, Feb 28, 2015 at 08:35:57AM -0800, Scott Branden wrote:
>>> +	/* Enable clock */
>>> +
>>> +	kp->clk = devm_clk_get(&pdev->dev, "peri_clk");
>>> +	if (IS_ERR(kp->clk)) {
>>> +		dev_info(&pdev->dev,
>>> +			"No clock specified. Assuming it's enabled\n");
>>
>> I was doing the final pass before applying and I think that this is not
>> quite correct, as it does not handle -EPROBE_DEFER properly which is
>> quite common. I think we should do something like this:
>>
>> 		error = PTR_ERR(kp->clk);
>> 		if (error != -ENOENT) {
>> 			if (error != -EPROBE_DEFER)
>> 				dev_err(.. "Failed to get clock" ...);
>> 			return error;
>> 		}
>> 		dev_dbg(... "No clock specified" ...);
>>
>> No need to resubmit if you are OK with this, I can make the change
>> locally.
>
> Hmm, also bcm_kp_start() and bcm_kp_stop() should check if kp->clk is
> valid before trying to enable/disable it.
>
I checked and other keyboard drivers do not check this.  I return an 
error in bcm_kp_start if the clk enable fails.  On stop, if the clk is 
not valid something is really, really wrong as well.
>>
>>> +	}
>>> +	else {
>>
>> Checkpach should have warned you that it should have been "} else {";
>> I'll fix it up locally along with few other cosmetic changes and
>> dropping a few extra headers.
>>
>> Thanks.
>>
>> --
>> Dmitry
>
