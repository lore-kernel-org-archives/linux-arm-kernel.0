From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 15 Feb 2016 19:22:36 +0100
Subject: [PATCH 4/4] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <20160215173300.GN19598@localhost> (Vinod Koul's message of "Mon,
 15 Feb 2016 23:03:00 +0530")
References: <1455225798-9510-1-git-send-email-robert.jarzmik@free.fr>
 <1455225798-9510-5-git-send-email-robert.jarzmik@free.fr>
 <20160215163524.GI19598@localhost> <87fuwt28eu.fsf@belgarion.home>
 <20160215173300.GN19598@localhost>
Message-ID: <87bn7h25qr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Mon, Feb 15, 2016 at 06:24:57PM +0100, Robert Jarzmik wrote:
>> Vinod Koul <vinod.koul@intel.com> writes:
>> 
>> > On Thu, Feb 11, 2016 at 10:23:18PM +0100, Robert Jarzmik wrote:
>> >> @@ -1399,13 +1405,17 @@ static int pxad_probe(struct platform_device *op)
>> >>  		return PTR_ERR(pdev->base);
>> >>  
>> >>  	of_id = of_match_device(pxad_dt_ids, &op->dev);
>> >> -	if (of_id)
>> >> +	if (of_id) {
>> >>  		of_property_read_u32(op->dev.of_node, "#dma-channels",
>> >>  				     &dma_channels);
>> >> -	else if (pdata && pdata->dma_channels)
>> >> +		of_property_read_u32(op->dev.of_node, "#requestors",
>> >> +				     &nb_requestors);
>> >
>> > I think we should check the return value here. This might be err in case
>> > when we have older DT on platform, but still should work with default in
>> > that case
>> 
>> Okay, but how should the code react to the err case, more specifically to
>> -EINVAL or -ENODATA ? As this property is optional as per the device-tree
>> description, the current code leaves nb_requestors = 0, as is specified in the
>> description, and fits the mmp_pdma case.
>> 
>> What do you think should be done ? A warning message ? Something else ?
>
> Message is fine, but in order for not to regress we should set this to 32
> (IIRC default before this, right) and not zero.
Okay, got you.

For v2 I'll implement exactly this, ie. a warning message and a default to 32.
I'll amend the device-tree description also to match the 32 (and not the 0 I
wrote earlier).

Cheers.

-- 
Robert
