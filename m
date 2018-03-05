From: david@lechnology.com (David Lechner)
Date: Mon, 5 Mar 2018 11:46:46 -0600
Subject: [PATCH v7 10/42] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <d1b91c10-fe11-452e-2c68-86e95fb58266@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <1519071723-31790-11-git-send-email-david@lechnology.com>
 <CAMpxmJVxfGtO=kh63KF-5Uqew3yy97DsK4FSd14CyyRQTOhrTA@mail.gmail.com>
 <93696fc8-bb93-aa20-3506-3d7216c17cd2@lechnology.com>
 <CAMpxmJVpMgikNfB4HgNCs+ep+EOHqH5bthiW82LsnDqzLfE5mg@mail.gmail.com>
 <6bbe9bf3-24c1-acd9-200d-513520d34558@lechnology.com>
 <CAMRc=Mdhi=byn4gPY6tVxgGjn9cgvc3smUkjV=Ku9i3euaZZtQ@mail.gmail.com>
 <d1b91c10-fe11-452e-2c68-86e95fb58266@lechnology.com>
Message-ID: <919e6c76-0818-b330-b0f0-71c3c3f4518d@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2018 10:23 AM, David Lechner wrote:
> On 03/05/2018 07:02 AM, Bartosz Golaszewski wrote:
>> 2018-03-01 17:44 GMT+01:00 David Lechner <david@lechnology.com>:
>>> On 03/01/2018 02:36 AM, Bartosz Golaszewski wrote:
>>>>
>>>> 2018-02-28 22:40 GMT+01:00 David Lechner <david@lechnology.com>:
>>>>>
>>>>> On 02/28/2018 06:38 AM, Bartosz Golaszewski wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> I think I found the reason for the strange crashes we were
>>>>>> experiencing (emac core->name being NULL) thanks to Sekhar who pointed
>>>>>> me in the right direction.
>>>>>>
>>>>>> The mdio driver fails to probe with v7 due to the supplied clock rate
>>>>>> being wrong. Before failing we register the emac clock with
>>>>>> pm_clk_add_clk(). When clock_ops puts the clock, it decreases the
>>>>>> reference count of the clock, but we never actually increased it in
>>>>>> the first place in the line above. The core clock code then destroys
>>>>>> the associated clk_core structure. When the next user comes around (in
>>>>>> our case the clk debug functions) the system crashes.
>>>>>>
>>>>>> I believe there to be two issues: one is with v7 - we need to increase
>>>>>> the clock reference count in davinci_psc_genpd_attach_dev().
>>>>>>
>>>>>> Second is the error path in the clock framework - we should remove the
>>>>>> destroyed clk_core from the debug list, which is not being done now.
>>>>>>
>>>>>> Why we even need to track the refcount of clk_core is a mistery for me
>>>>>> though. Stephen, Mike?
>>>>>>
>>>>>> Best regards,
>>>>>> Bartosz Golaszewski
>>>>>
>>>>>
>>>>>
>>>>> Great find. I figured it had to be something like this, but I wasn't
>>>>> able to reproduce the problem yet.
>>>>>
>>>>> I suppose it is time to spin up a v8 with some fixes.
>>>>
>>>>
>>>> I still don't know why the mdio clock rate is much lower than in
>>>> mainline though. Any ideas?
>>>>
>>>> Thanks,
>>>> Bart
>>>>
>>>
>>> Now that you have fixed the crash, can you answer the questions I have
>>> asked earlier?
>>>
>>>> Can you post the output of this command so that I can see how your
>>>
>>> clocks are setup:
>>>
>>> cat /sys/kernel/debug/clk/clk_summary
>>>
>>>> Using your workaround, can you run:
>>>
>>>
>>> cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>>>
>>> If you see:
>>> ?? 1e27000.clock-controller: emac? off-0
>>>
>>> then genpd is not working like it is supposed to. You should see something
>>> like this for device that are working:
>>> ?????????? 1e27000.clock-controller: uart2? on
>>> ???? /devices/platform/soc at 1c00000/1d0d000.serial??????? active
>>
>> Hi David, Sekhar,
>>
>> I tried booting the board today over tftp but didn't succeed. I then
>> switched to a normal boot from SD card and the boot process froze at
>> the same moment (right after the DHCP config, or after rtc config if I
>> disabled DHCP in bootargs). I then realized that the emac clock can't
>> be the culprit. After some digging I found out that the late_initcall
>> to clk_disable_unused() disables sysclk6 - the parent of the arm
>> clock, which of course freezes the device.
>>
>> If I remove the call to clk_disable_unused(), I can boot just fine.
>>
>> The following other clocks are disabled before pll0_sysclk6:
>> pll1_sysclk3
>> pll0_obsclk
>> pll0_sysclk7
>>
>> davinci_lpsc_clk_enable() is never called for these clocks - in fact
>> it's not called for any parent that's not explicitly defined in
>> psc-da850.c - I believe this may be one of the reasons. I will get
>> back to debugging it tomorrow.
>>
>> Best regards,
>> Bartosz Golaszewski
>>
> 
> Thanks for continuing to dig into this. I think I know what needs to
> be done now. I think I don't have the dependencies quite right where
> the PSC clocks are being registered before the PLL clocks, in which
> case they aren't getting the correct parent clock.
> 

Bartosz,

One more thing to check: I think I had some typos in da850.dtsi where
I wrote clock_names instead of clock-names. Please make sure this is
fixed in your working branch.
