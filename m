From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Wed, 15 Jun 2016 16:40:26 +0200
Subject: [PATCH v3 2/2] ARM: dts: utilite-pro: add mmc card slot support
In-Reply-To: <575994a0ec924e2db7282a2945d3355f@rwthex-s2-b.rwth-ad.de>
References: <20160612232456.1621-1-christopher.spinrath@rwth-aachen.de>
 <c25d8e5d113240c5ab78771f301d901a@rwthex-s1-b.rwth-ad.de>
 <089d827c9de9426eab79a907a2043828@rwthex-s1-a.rwth-ad.de>
 <712bda47d095416f8b69f4eecbf979a5@rwthex-s1-b.rwth-ad.de>
 <575994a0ec924e2db7282a2945d3355f@rwthex-s2-b.rwth-ad.de>
Message-ID: <2160fa6084b94c839b339a663334ae65@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 06/15/2016 12:33 PM, Igor Grinberg wrote:
> Hi Christopher,
> 
> On 06/15/2016 12:16 PM, Christopher Spinrath wrote:
>> Hi Igor,
>>
>> On 06/15/2016 08:40 AM, Igor Grinberg wrote:
>>> Hi Christopher,
>>>
>>> On 06/13/2016 02:24 AM, christopher.spinrath at rwth-aachen.de wrote:
>>>> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>>>
>>>> The Utilite Pro has a mmc card slot connected to the usdhc3
>>>> controller. There is no card detection until hardware revision 1.3.
>>>>
>>>> Add support for it and signal the controller with the broken-cd
>>>> property that polling has to be used to detect a card.
>>>>
>>>> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>>>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>>>> ---
>>>>
>>>> Notes:
>>>>     Changes since v2:
>>>>      - add Fabio's Reviewed-By
>>>>     
>>>>     Changes since v1:
>>>>      - enhance commit message to explain to the broken-cd property
>>>>
>>>>  arch/arm/boot/dts/imx6q-utilite-pro.dts | 44 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>>>> index 7219745..6199063 100644
>>>> --- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
>>>> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
>>>
>>> [...]
>>>
>>>> @@ -151,3 +184,14 @@
>>>>  	uart-has-rtscts;
>>>>  	status = "okay";
>>>>  };
>>>> +
>>>> +&usdhc3 {
>>>> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>>>> +	pinctrl-0 = <&pinctrl_usdhc3>;
>>>> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
>>>> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
>>>> +	no-1-8-v;
>>>> +	broken-cd;
>>>
>>> A wast majority of boards produced are of revision >=1.3.
>>> Can we please have the default as revision 1.3 with cd?
>>> And let the patch you have submitted to U-Boot do the job
>>> for older revisions?
>>>
>>
>> Well, my board has revision 1.0. So I cannot test that and feel uneasy
>> to put my Signed-off-by under such a patch. IMHO the best solution would
>> be that someone with a revision >= 1.3 board sends a follow-up patch
>> adding the cd-gpios.
>>
>> If I resend the patch with cd-gpios could you test it and provide a
>> Tested-By?
> 
> Yes. Absolutely.
> 

Can we have your opinion on that matter?

>>
>> The other question is: should the dts provide a working/sane
>> configuration for all boards (which the broken-cd approach is)
>> independently of the bootloader?
> 
> Well, no, I wouldn't go that way, as "why wouldn't we just use the
> broken-cd approach on all boards and not bother with gpio-cds"...
> We do want the gpio-cd to work as expected where it can.
> 
>> Is it ok to put both, the  cd-gpios and
>> the broken-cd property into the dts and let the bootloader remove the
>> broken-cd property for revision >= 1.3 (due to the documentation it is
>> not but the driver favourites the broken cd property - hence, it would
>> work)?
> 
> That sounds sane from my POV (unless I'm missing something), but
> will have to have comments explaining what is going on.
> 
> There are two main reasons why I would not want to have the broken-cd
> as a default:
> 1) It is not broken... It just does not exist prior to revision 1.3.
> 2) There are more boards of revision >=1.3 then older ones outside and
>    we would want them to work as expected even with older U-Boot versions.
> 
