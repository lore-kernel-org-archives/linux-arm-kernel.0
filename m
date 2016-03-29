From: stefan@agner.ch (Stefan Agner)
Date: Tue, 29 Mar 2016 00:11:13 -0700
Subject: [PATCH v2 6/8] drm/fsl-dcu: add TCON driver
In-Reply-To: <2234894.ri36D5MRrN@ws-stein>
References: <1459216802-32094-1-git-send-email-stefan@agner.ch>
 <1459216802-32094-7-git-send-email-stefan@agner.ch>
 <2234894.ri36D5MRrN@ws-stein>
Message-ID: <57c86de8eca0aa16a5cdfc488977ca4e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-28 23:45, Alexander Stein wrote:
> Hi,
> 
> some comments below.
> 
> On Monday 28 March 2016 19:00:00, Stefan Agner wrote:
>> Add driver for the TCON (timing controller) module. The TCON module
>> is a separate module attached after the DCU (display controller
>> unit). Each DCU instance has its own, directly connected TCON
>> instance. The DCU's RGB and timing signals are passing through
>> the TCON module. TCON can provide timing signals for raw TFT panels
>> or operate in a bypass mode which leaves all signals unaltered.
>>
>> The driver currently only supports the bypass mode.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
>> --- a/Documentation/devicetree/bindings/display/fsl,dcu.txt
>> +++ b/Documentation/devicetree/bindings/display/fsl,dcu.txt
>> @@ -14,6 +14,7 @@ Required properties:
>>  Optional properties:
>>  - clocks:		Second handle for pixel clock.
>>  - clock-names:		Second name "pix" for pixel clock.
>> +- fsl,tcon:		The phandle to the timing controller node.
> 
> Maybe a comment this is (currently) only for Vybrid, but not LS1021A.
> 

IMHO, such references to SoCs in a peripheral binding is somewhat
misplaced. If we would start doing this, we would end up in lots of SoC
references, and nobody knows whether they are actually accurate and up
to date... And I think we should add tcon to LS1021a, more on that
below...

>> --- /dev/null
>> +++ b/drivers/gpu/drm/fsl-dcu/fsl_tcon.c
>> [...]
>> +struct fsl_tcon *fsl_tcon_init(struct device *dev)
>> +{
>> +	struct fsl_tcon *tcon;
>> +	struct device_node *np;
>> +	int ret;
>> +
>> +	tcon = devm_kzalloc(dev, sizeof(*tcon), GFP_KERNEL);
>> +	if (!tcon)
>> +		return NULL;
>> +
>> +	np = of_parse_phandle(dev->of_node, "fsl,tcon", 0);
>> +	if (!np) {
>> +		dev_warn(dev, "Couldn't find the tcon node\n");
>> +		return NULL;
>> +	}
> 
> Maybe check for device tree node before allocating struct fsl_tcon? Also this 
> should not be a warning, as on LS1021A this is to be expected.

Agreed, definitely the smarter sequence.

Afact LS1021a has also a TCON. At least in Jianwei Wangs initial patches
it was part of the driver, see:
https://lkml.org/lkml/2015/7/13/242

Not sure how that driver can work without TCON support on LS1021a, maybe
the bootloader sets the TCON to bypass?

Since I do not have a LS1021a, I hesitated to just add it to the LS1021s
dt's, but it should be fairly straight forward.

--
Stefan
