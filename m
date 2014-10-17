From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Fri, 17 Oct 2014 15:04:53 -0500
Subject: [PATCH 2/2] ARM: dts: socfpga: Add a 3.3V fixed regulator node
In-Reply-To: <CAD=FV=UaGMjMySV3v_t8fGDbTmwtcJJi0X_fY2tCqw48Qzc3jA@mail.gmail.com>
References: <1413493413-8041-1-git-send-email-dinguyen@opensource.altera.com>	<1413493413-8041-3-git-send-email-dinguyen@opensource.altera.com>	<CAD=FV=V3Ewv7Ns_JD0+gd4J6p3k-N-rmFjkdYQobMgB8m7z6SA@mail.gmail.com>	<54416BDF.6010204@opensource.altera.com>
 <CAD=FV=UaGMjMySV3v_t8fGDbTmwtcJJi0X_fY2tCqw48Qzc3jA@mail.gmail.com>
Message-ID: <54417665.3080603@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2014 02:43 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Oct 17, 2014 at 12:19 PM, Dinh Nguyen
> <dinguyen@opensource.altera.com> wrote:
>> On 10/17/2014 11:57 AM, Doug Anderson wrote:
>>> Dinh,
>>>
>>> On Thu, Oct 16, 2014 at 2:03 PM,  <dinguyen@opensource.altera.com> wrote:
>>>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>>>
>>>> Without the 3.3V regulator node, the SDMMC driver will give these warnings:
>>>>
>>>> dw_mmc ff704000.dwmmc0: No vmmc regulator found
>>>> dw_mmc ff704000.dwmmc0: No vqmmc regulator found
>>>>
>>>> This patch adds the regulator node, and points the SD/MMC to the regulator.
>>>>
>> [...]
>>>>
>>>> -               dwmmc0 at ff704000 {
>>>> +               mmc0: dwmmc0 at ff704000 {
>>>>                         num-slots = <1>;
>>>>                         broken-cd;
>>>>                         bus-width = <4>;
>>>> @@ -41,4 +41,13 @@
>>>>                         cpu1-start-addr = <0xffd080c4>;
>>>>                 };
>>>>         };
>>>> +
>>>> +       regulator_3_3v_hps: fixed_3_3v_hps_regulator at 0 {
>>>
>>> nit: no @0 since there is no "reg" (register) under this node.
>>>
>>> nit: usually people don't like "_" in node names.  ...I would probably
>>> do this but I'm not an expert:
>>>   regulator_3_3v_hps: hps-regulator {
>>
>> Ok..will fix up.
>>
>>>
>>> This regulator also looks pretty bogus to me.  Is this really a
>>> regulator that software has no control over?  It means you can't fully
>>> reset a card but I guess that's OK.
>>
>> Yes, this is a generic 3.3V regulator that is used for the 3.3V power
>> rail for the SOC, and any IP the needs 3.3V.
>>
>> Schematics are here:
>> http://www.rocketboards.org/pub/Documentation/AlteraSoCDevelopmentBoard/c5_soc_devkit_c.pdf?t=1365712679
>>
>> http://www.rocketboards.org/pub/Documentation/ArrowSoCKitEvaluationBoard/SoCKit_RevC.pdf
>>
>> And right, I don't see anyway to be able to reset the card.
>>
>>>
>>> I'd also expect this regulator to be defined in the same dts / dtsi
>>> file that it's used in.  Your current patch says "there's a generic
>>> 3.3V regulator on all boards of the socfpga_arria5 class even if they
>>> don't use MMC, but the "socfpga_arria5_socdk" uses it for MMC.  Is
>>> that really true?
>>>
>>
>> yeah...My original patch had the regulator placed in it's appropriate
>> dts board file, but I saw that as a bit of duplication. I figured that
>> most people are just copying Altera's devkit schematic, that if a new
>> board file shows up that has a different controllable regulator, then
>> the board file can have the new regulator node. Meanwhile, this patch
>> saves adding an additional regulator node for the existing board files.
>>
>> The 3.3V is not just used by MMC, but the for all 3.3V peripherals.
> 
> The advantage of putting it in each board file is you could name it
> based on the schematics.  I see SoCKit_RevC it is named "VCC3P3"
> 

That's fine. I can edit the patch so that each regulator node goes into
it's respective board dts file.

> It also allows you to specify the 3.3 supply as the output of a real
> regulator driver.  In s5_soc_devkit it looks like this comes from
> LTC2978.  That's got i2c connections.  What happens when you add a
> driver for that?
> 

Do you mean the c5_soc_devkit? If so, then the 3.3V is coming from the
LTC3885 regulator. The LTC2978 is a regulator for the the 3.3V_HPS or
3.3V_REG_HPS which is used by others.

So I should change the regulator name from 3.3V_HPS to just 3.3V for the
c5_soc_devkit.

Dinh
