From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 21 Feb 2018 13:01:44 +0100
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v7_00=2F42=5D_ARM=3A_davinci=3A_convert_to_common?=
 =?UTF-8?Q?_clock_framework=E2=80=8B?=
In-Reply-To: <6142ab0d-85b1-84da-3a35-bdd8733bebd9@lechnology.com>
References: <1519071723-31790-1-git-send-email-david@lechnology.com>
 <CAMRc=MdT5Vd68eoWfJGv=5_uzD0L5m3Y+wi6r7N6O8y6HZrQSg@mail.gmail.com>
 <6142ab0d-85b1-84da-3a35-bdd8733bebd9@lechnology.com>
Message-ID: <CAMRc=Mf_pumyTZPn9T=sG7Ab95YS3KqKc2bT0evhESTRRFeiuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-02-20 19:39 GMT+01:00 David Lechner <david@lechnology.com>:
> On 02/20/2018 07:33 AM, Bartosz Golaszewski wrote:
>>
>> 2018-02-19 21:21 GMT+01:00 David Lechner <david@lechnology.com>:
>>>
>>> This series converts mach-davinci to use the common clock framework.
>>>
>>>
>>
>> Hi David,
>>
>> just some quick results from today's playing with v7.
>>
>> I started out with da850-lcdk with my standard rootfs over NFS. I was
>> not able to boot to console so far. The first problem is that mdio
>> fails to probe:
>>
>> libphy: Fixed MDIO Bus: probed
>> davinci_mdio 1e24000.mdio: davinci mdio revision 1.5, bus freq 2200000
>> davinci_mdio 1e24000.mdio: no live phy, scanning all
>> davinci_mdio: probe of 1e24000.mdio failed with error -5> After some
>> digging I noticed that the supplied clock rate differs
>> between mainline (114000000Hz) vs common-clock-v7 (18000000). Since
>> we're not setting the rate in mdio, using LPSC_SET_RATE_PARENT would
>> not help like with lcdc.
>
>
> Can you post the output of this command so that I can see how your
> clocks are setup:
>
> cat /sys/kernel/debug/clk/clk_summary
>
>
>>
>> After that, the boot just hangs without ever getting to emac's probe.
>
>
> Using your workaround, can you run:
>
> cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
>
> If you see:
>   1e27000.clock-controller: emac  off-0
>
> then genpd is not working like it is supposed to. You should see something
> like this for device that are working:
>           1e27000.clock-controller: uart2  on
>     /devices/platform/soc at 1c00000/1d0d000.serial        active
>
>
>>
>> Once I set the emac clock to always enabled (a workaround that was
>> necessary with v6, but could be dropped with my first
>> genpd-in-a-separate-driver attempt), I'm getting a rather strange NULL
>> pointer dereference:
>
>
> I noticed this too when adding the power-domains property to some device
> tree nodes. This is part of the reason why I didn't add it everywhere.
> I wasn't able to figure out the cause of this yet. As a work around
> though, please try removing the power-domains property from the emac
> and mdio nodes and use your previous workaround of having an always
> enabled clock.
>
>

When I use any of the workarounds I just keep getting more problems
(e.g. [1] from blk and pinctrl). I only had a couple hours today to
play with it but it seems to me we have some memory corruption
somewhere. I'll check the initialization order of all the frameworks
involved tomorrow.

Best regards,
Bartosz

[1] https://pastebin.com/75mkkuJL
