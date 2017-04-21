From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 21 Apr 2017 19:22:05 +0200
Subject: [PATCH 2/5] mtd: nand: gpmi: add i.MX 7 SoC support
In-Reply-To: <494a7bc044457240a302d92b3a50b8e5@agner.ch>
References: <20170421010755.18025-1-stefan@agner.ch>
 <20170421010755.18025-3-stefan@agner.ch>
 <af3fe671-c5fb-d3cf-c891-e6b7c973baa1@gmail.com>
 <5cf26d2b020392c875464c7504a9fb5b@agner.ch>
 <8377dadc-043f-5932-cb13-3367db38a6dd@gmail.com>
 <494a7bc044457240a302d92b3a50b8e5@agner.ch>
Message-ID: <57336d7e-7b48-8855-9e87-3eb370facd05@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2017 06:19 PM, Stefan Agner wrote:
> On 2017-04-21 06:08, Marek Vasut wrote:
>> On 04/21/2017 05:15 AM, Stefan Agner wrote:
>>> On 2017-04-20 19:03, Marek Vasut wrote:
>>>> On 04/21/2017 03:07 AM, Stefan Agner wrote:
>>>>> Add support for i.MX 7 SoC. The i.MX 7 has a slightly different
>>>>> clock architecture requiring only two clocks to be referenced.
>>>>> The IP is slightly different compared to i.MX 6SoloX, but currently
>>>>> none of this differences are in use so there is no detection needed
>>>>> and the driver can reuse IS_MX6SX.
>>>>>
>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>>> ---
>>>>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>>>> index c8bbf5da2ab8..4a45d37ddc80 100644
>>>>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>>>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>>>>> @@ -127,6 +127,18 @@ static const struct gpmi_devdata gpmi_devdata_imx6sx = {
>>>>>  	.clks_count = ARRAY_SIZE(gpmi_clks_for_mx6),
>>>>>  };
>>>>>
>>>>> +static const char * const gpmi_clks_for_mx7d[] = {
>>>>> +	"gpmi_io", "gpmi_bch_apb",
>>>>> +};
>>>>> +
>>>>> +static const struct gpmi_devdata gpmi_devdata_imx7d = {
>>>>> +	.type = IS_MX6SX,
>>>>
>>>> Would it make sense to use IS_MX7 here already to prevent future surprises ?
>>>>
>>>
>>> Yeah I was thinking we can do it once we have an actual reason to
>>> distinguish.
>>
>> So what are the differences anyway ?
>>
> 
> I did not check the details, but Han's patchset (link in cover letter)
> mentions:
> "add the HW bitflip detection and correction for i.MX6QP and i.MX7D."...

Oh, interesting.

>>> But then, adding the type would only require 2-3 lines of change if I
>>> add it to the GPMI_IS_MX6 macro...
>>
>> Then at least add a comment because using type = IMX6SX right under
>> gpmi_data_mx7d can trigger some head-scratching. And put my R-B on V2.
> 
> FWIW, I mentioned it in the commit message.
> 
> I think rather then adding a comment it is cleaner to just add IS_IMX7D
> and add it to the GPMI_IS_MX6 macro. That does not need a comment since
> it implicitly says we have a i.MX 7 but treat it like i.MX 6 and it is a
> rather small change. Does that sound acceptable?

Sure, that's even better, thanks.

btw isn't there some single-core mx7 (mx7s ?) , maybe we should just go
with mx7 (without the d suffix). I dunno if it has GPMI NAND though, so
maybe mx7d is the right thing to do here ...

> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
> @@ -132,7 +132,7 @@ static const char * const gpmi_clks_for_mx7d[] = {
>  };
> 
>  static const struct gpmi_devdata gpmi_devdata_imx7d = {
> -       .type = IS_MX6SX,
> +       .type = IS_MX7D,
>         .bch_max_ecc_strength = 62,
>         .max_chain_delay = 12,
>         .clks = gpmi_clks_for_mx7d,
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> index 2e584e18d980..f2cc13abc896 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.h
> @@ -123,7 +123,8 @@ enum gpmi_type {
>         IS_MX23,
>         IS_MX28,
>         IS_MX6Q,
> -       IS_MX6SX
> +       IS_MX6SX,
> +       IS_MX7D,
>  };
> 
>  struct gpmi_devdata {
> @@ -307,6 +308,8 @@ void gpmi_copy_bits(u8 *dst, size_t dst_bit_off,
>  #define GPMI_IS_MX28(x)                ((x)->devdata->type == IS_MX28)
>  #define GPMI_IS_MX6Q(x)                ((x)->devdata->type == IS_MX6Q)
>  #define GPMI_IS_MX6SX(x)       ((x)->devdata->type == IS_MX6SX)
> +#define GPMI_IS_MX7D(x)                ((x)->devdata->type == IS_MX7D)
> 
> -#define GPMI_IS_MX6(x)         (GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x))
> +#define GPMI_IS_MX6(x)         (GPMI_IS_MX6Q(x) || GPMI_IS_MX6SX(x) ||
> \
> +                                GPMI_IS_MX7D(x))
>  #endif
> 
> --
> Stefan
> 


-- 
Best regards,
Marek Vasut
