From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 7 Apr 2014 23:38:04 +0200
Subject: [PATCH] arm/igep0020: fix IGEPv2 boot
In-Reply-To: <53430D09.3060706@xenomai.org>
References: <1396801938-24788-1-git-send-email-gilles.chanteperdrix@xenomai.org>
 <CABxcv=k3nrhVtMPw1BqO6Cz07VEtGA9ZBMvkXBJuLrcCSoXpwg@mail.gmail.com>
 <5341C351.5060406@xenomai.org>
 <CABxcv=nYt_9x3m9siCVyXTE=bRNPPRoPhxW8oByweV6MrmZ+pg@mail.gmail.com>
 <53430D09.3060706@xenomai.org>
Message-ID: <CABxcv=nzjX3p5qrQjoYEKKzPLBT+ZG7W1EZt_548W34Fh8byew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 7, 2014 at 10:39 PM, Gilles Chanteperdrix
<gilles.chanteperdrix@xenomai.org> wrote:
> On 04/07/2014 01:45 AM, Javier Martinez Canillas wrote:
>> Hello,
>>
>> On Sun, Apr 6, 2014 at 11:12 PM, Gilles Chanteperdrix
>> <gilles.chanteperdrix@xenomai.org> wrote:
>>> On 04/06/2014 10:04 PM, Javier Martinez Canillas wrote:
>>>> Hello Giles,
>>>
>>> Hi,
>>>
>>>> It looks suspiciously similar to an issue we had due some DT clock
>>>> changes were the IGEPv2 (or any board that used the "ti,omap3"
>>>> compatible string) were initialized as omap3430 instead of omap3630
>>>> thus using omap3430 clock data which left the UART4 uninitialized.
>>>>
>>>> I fixed that particular issue on commit fb0cfec ("ARM: dts:
>>>> omap3-igep: fix boot fail due wrong compatible match") which was
>>>> merged on v3.14-rc6 so it should be on your v3.14 kernel so maybe is a
>>>> different issue.
>>>>
>>>> I wonder why you are having this issue though since I didn't have that
>>>> problem with 3.14 as far as I can remember.
>>>>
>>>> Can you provide me the exact commit id of your HEAD? or is just the
>>>> tagged v3.14 commit?
>>>
>>> It is the tagged v3.14 commit, with omap2plus_defconfig configuration
>>> My IGEPv2 does not have an omap3630, but a 3530.
>>>
>>> The boot logs say:
>>> [    0.000000] OMAP3430/3530 ES3.1 (l2cache iva sgx neon isp )
>>>
>>
>> Then in your case is the exact opposite, that commit seems to broke
>> your board since now it is initialized as an omap3630 instead of an
>> omap3430. So you need to change the compatible string:
>>
>> --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> @@ -14,7 +14,7 @@
>>
>>  / {
>>         model = "IGEPv2 (TI OMAP AM/DM37x)";
>> -       compatible = "isee,omap3-igep0020", "ti,omap36xx", "ti,omap3";
>> +       compatible = "isee,omap3-igep0020", "ti,omap3";
>>
>>         leds {
>>                 pinctrl-names = "default";
>>
>
> That is not sufficient. In order to avoid the kernel oops, I have to
> include omap34xx-hs.dtsi instead of omap36xx.dtsi in omap3-igep.dtsi. As
> far as I understand, omap36xx.dtsi gets the uart4 declared, and this is
> what is causing the oops.
>

Right, I completely forgot about the included dtsi file on
omap3-igep.dtsi, sorry about that.

>> The problem is that there are too many IGEP boards revisions that use
>> use different SoC (DM3730 or OMAP3530), flash memory type (OneNAND or
>> NAND), memory sizes and connectivity (with or without wifi chip).
>>
>> So to support all different combinations with DeviceTree mean that an
>> exponential number of dts/dtsi is needed to describe each variation so
>> I decided to only support the most common versions:
>>
>> - IGEPv2 with DM3730, NAND, wifi and 512MB of RAM.
>> - IGEP COM Module with DM3730, NAND, wifi and 512MB of RAM.
>>
>> And companies using IGEP boards and mainline could use it as a
>> reference and adapt the DTS to match their board revision.
>
> I have done that, I created omap3-igep0020-3430.dts, and it works fine.
>
>>
>> Honestly I didn't know that there were mainline users using the old
>> omap3530 IGEPv2 so I'll prepare some patches to support both DM3730
>> and OMAP3530 versions.
>
> It still works, no need to change it ;-)
>

Great, glad to hear that you make it work :-)

Best regards,
Javier

> Regards.
>
>
> --
>                                                                 Gilles.
