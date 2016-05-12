From: eric@anholt.net (Eric Anholt)
Date: Thu, 12 May 2016 11:23:15 -0700
Subject: [PATCH 0/3] clk: bcm2835: critical clocks and parent selection
In-Reply-To: <FD44F435-512C-49A5-B1F5-3C62AAF805AC@martin.sperl.org>
References: <1462842090-2017-1-git-send-email-eric@anholt.net>
 <5731B8BA.30402@martin.sperl.org> <87a8jxyfua.fsf@eliezer.anholt.net>
 <FD44F435-512C-49A5-B1F5-3C62AAF805AC@martin.sperl.org>
Message-ID: <87oa8b9lv0.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Sperl <kernel@martin.sperl.org> writes:

>> On 10.05.2016, at 19:37, Eric Anholt <eric@anholt.net> wrote:
>> 
>> Martin Sperl <kernel@martin.sperl.org> writes:
>>> and also hsm (probably hardware security module):
>>> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/regdump
>>> ctl = 0x000002d6
>>> div = 0x000030e0
>>> root at raspcm:~# cat /sys/kernel/debug/clk/hsm/clk_rate
>>> 163551916
>> 
>> That's the HDMI state machine (there's even a comment saying so),
>> controlled by the vc4 driver.
>> 
>>> So turning plld off stops sdram and hsm - at least that is my
>>> interpretation.
>>> 
>>> This means we need to define a clock property in firmware or
>>> we need a ram node making use of "mmio-sram" maybe?
>>> 
>>> Marking sdram as "critical" or "hand_off" could also solve that
>>> for the moment (but it does not solve all the other hidden
>>> clock dependencies of the firmware)
>> 
>> If there are other hidden dependencies, then we should figure them out.
>
> But strangely the sdram (plus the below) is the only one with
> plld that is enabled (unless it is one of the clocks we have not
> added to the kernel side yet)
>
> Maybe there is something that derives directly from plld_core
> or any of the other plld-dividers?

Nothing I can find.

> Core would indicate anything central to the videocore...
> Anyway both plld_core as well as plld_per ad well as both
> Pll_dsi that are running by default (but I doubt that the
> Dsi would be relevant)
>
> I guess you are in a better situation to figure out which
> hidden HW blocks uses plld...
>
>> 
>>> --- a/drivers/clk/bcm/clk-bcm2835.c
>>> +++ b/drivers/clk/bcm/clk-bcm2835.c
>>> @@ -1655,7 +1655,8 @@ static const struct bcm2835_clk_desc 
>>> clk_desc_array[] = {
>>>                .ctl_reg = CM_SDCCTL,
>>>                .div_reg = CM_SDCDIV,
>>>                .int_bits = 6,
>>> -               .frac_bits = 0),
>>> +               .frac_bits = 0,
>>> +               .flags = CLK_IS_CRITICAL),
>>>        [BCM2835_CLOCK_V3D]     = REGISTER_VPU_CLK(
>>>                .name = "v3d",
>>>                .ctl_reg = CM_V3DCTL,
>> 
>> The Pi foundation folks believe that the cprman SDRAM clock isn't ever
>> used (there's a separate PLL in the SDRAM controller, and cprman is only
>> intended for unused low-power states), and at least in your sample of
>> the reg, it's not enabled.  Instead of grepping for clk_enable_count, it
> See my comment above - it must be configured for some reason
> during the boot process by the firmware .

You have to write the register to configure the sdram controller's clock
parent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160512/b537a4e4/attachment.sig>
