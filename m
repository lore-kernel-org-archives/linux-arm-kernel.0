From: stefan@agner.ch (Stefan Agner)
Date: Tue, 29 Mar 2016 00:39:03 -0700
Subject: [PATCH v2 6/8] drm/fsl-dcu: add TCON driver
In-Reply-To: <3752084.bcROvR6fvG@ws-stein>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
 <2234894.ri36D5MRrN@ws-stein> <57c86de8eca0aa16a5cdfc488977ca4e@agner.ch>
 <3752084.bcROvR6fvG@ws-stein>
Message-ID: <154ce63f6767c2fc6f15e2486c0753c1@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-29 00:26, Alexander Stein wrote:
> On Tuesday 29 March 2016 00:11:13, Stefan Agner wrote:
>> >> --- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
>> >> +++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
>> >>
>> >> @@ -14,6 +14,7 @@ Required properties:
>> >>  Optional properties:
>> >>  - clocks:		Second handle for pixel clock.
>> >>  - clock-names:		Second name "pix" for pixel clock.
>> >>
>> >> +- fsl,tcon:		The phandle to the timing controller node.
>> >
>> > Maybe a comment this is (currently) only for Vybrid, but not LS1021A.
>>
>> IMHO, such references to SoCs in a peripheral binding is somewhat
>> misplaced. If we would start doing this, we would end up in lots of SoC
>> references, and nobody knows whether they are actually accurate and up
>> to date... And I think we should add tcon to LS1021a, more on that
>> below...
> 
> Well, I don't mind after all.
> 
>> >> --- /dev/null
>> >> +++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
>> >> [...]
>> >> +struct fsl_tcon *fsl_tcon_init(struct device *dev)
>> >> +{
>> >> +	struct fsl_tcon *tcon;
>> >> +	struct device_node *np;
>> >> +	int ret;
>> >> +
>> >> +	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
>> >> +	if (!tcon)
>> >> +		return NULL;
>> >> +
>> >> +	np = of_parse_phandle(dev->of_node, "fsl,tcon", 0);
>> >> +	if (!np) {
>> >> +		dev_warn(dev, "Couldn't find the tcon node\n");
>> >> +		return NULL;
>> >> +	}
>> >
>> > Maybe check for device tree node before allocating struct fsl_tcon? Also
>> > this should not be a warning, as on LS1021A this is to be expected.
>>
>> Agreed, definitely the smarter sequence.
>>
>> Afact LS1021a has also a TCON. At least in Jianwei Wangs initial patches
>> it was part of the driver, see:
>> https://lkml.org/lkml/2015/7/13/242
>>
>> Not sure how that driver can work without TCON support on LS1021a, maybe
>> the bootloader sets the TCON to bypass?
>>
>> Since I do not have a LS1021a, I hesitated to just add it to the LS1021s
>> dt's, but it should be fairly straight forward.
> 
> Interesting, but in Patch 3
> (https://lists.freedesktop.org/archives/dri-devel/2015-July/086381.html)
> no TCON node is added and using is still
> optional. Yet, I don't find any TCON hardware in the LS1021A reference manual, 
> e.g. in the memory map. I hard guess is that it doesn't require/use one. 
> Without memory address it would be pretty hard to add one.

Ok, maybe I am completely wrong on that. I thought I have seen it...

It could be that Jianwei added TCON support for Vybrid only, in this
case I agree there shouldn't be a warning if TCON is missing. Maybe even
the other way around, write a info message in case TCON has been found.

--
Stefan
