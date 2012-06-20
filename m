From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Jun 2012 10:51:42 -0600
Subject: Where to power on the wifi device before loading the driver.
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C6EE2DD629@HKMAIL01.nvidia.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD90352.9090606@wwwdotorg.org>
 <20120614063120.GA20167@avionic-0098.mockup.avionic-design.de>
 <20120614121234.GC3913@opensource.wolfsonmicro.com>
 <4FDA092E.10301@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE8D@HKMAIL01.nvidia.com>
 <4FDB5976.20809@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD61F@HKMAIL01.nvidia.com>
 <43E4817426ED174AA81263BCECB4351D138E8ACD6B@sc-vexch3.marvell.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD622@HKMAIL01.nvidia.com>
 <20120619091719.GZ3974@opensource.wolfsonmicro.com>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD626@HKMAIL01.nvidia.com>
 <4FE112F2.7000506@wwwdotorg.org>
 <6B4D417B830BC44B8026029FD256F7F1C6EE2DD629@HKMAIL01.nvidia.com>
Message-ID: <4FE1FF9E.4070604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2012 05:28 AM, Wei Ni wrote:
...
> Stephen, as Rakesh said that in case of bcm4329, the two GPIO (WF_EN
> and WF_RST) are shorted. So I think we can simply to use the
> power-gpios properity in the SD driver, just use one gpio I test it
> in this way, it runs ok, the bcm4329 can be powered up. We can use
> this option.

Wei, again, your emails and not correctly word-wrapped to well under 80
columns. I know it's a pain to do that with Exchange/Outlook, but it's
really difficult for anyone to read emails that aren't correctly formatted.

So yes, once we'd resolved this general issue, that was going to be my
next topic of discussion.

I looked at the schematic of the 4329 module, and the GPIOs aren't
shorted, but rather there's a stuffing option - either WF_EN or WF_RST
is actually connected to the 4329's WL_SHUTDOWN_N_RST pin. I believe
WF_EN is the one connected. If the two signals were shorted, you'd need
to control both of them to avoid sinking power from one of Tegra's GPIO
outputs into the other if they were set to differing values.

So, yes, using the power-gpios property will probably work in this case.

This rather begs the question: WTF is our downstream kernel doing
actively controlling both GPIOs with time delays between each? Do you
have the schematic for the 4330 module, or indeed any other module
that's used on Cardhu? If so, please do send them to me internally.
While this workaround might work for the 4329, additional research would
be useful so we can determine whether we still have a problem to solve
for other modules.

Thanks.
