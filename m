From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 10:24:13 -0700
Subject: [PATCH V2 2/2] ARM: tegra: add ams AS3722 device to Venice2 DT
In-Reply-To: <52B2A01D.2000207@nvidia.com>
References: <1387371179-16725-1-git-send-email-ldewangan@nvidia.com>
 <1387371179-16725-2-git-send-email-ldewangan@nvidia.com>
 <52B20BB4.50506@wwwdotorg.org> <52B2A01D.2000207@nvidia.com>
Message-ID: <52B32BBD.8090404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 12:28 AM, Laxman Dewangan wrote:
> On Thursday 19 December 2013 02:25 AM, Stephen Warren wrote:
>> On 12/18/2013 05:52 AM, Laxman Dewangan wrote:
>>> Add ams AS3722 entry for gpio/pincontrol and regulators
>>> to venice2 DT.
>> This patch still causes:
>>
>>> [    0.726545] as3722-pinctrl as3722-pinctrl: pin gpio0 already
>>> requested by as3722-pinctrl; cannot claim for as3722-regulator
>>> [    0.737681] as3722-pinctrl as3722-pinctrl: pin-0
>>> (as3722-regulator) status -22
>>> [    0.744895] as3722-pinctrl as3722-pinctrl: could not request pin 0
>>> (gpio0) from group gpio0  on device as3722-pinctrl
>>> [    0.755500] as3722-regulator as3722-regulator: Error applying
>>> setting, reverse things back
> 
> This error is nothing related to the ams dt or driver. This came from
> the framework from the driver/base for adding pinmux call before calling
> any diver's probe.
> Here is my finding:
> Frameworks calls the pinctrl_bind_pins() before calls the driver's probe
> (drivers/base/dd.c) and pinctrl_bind_pins() calls the pinmux mapping and
> try to set the default (drvers/base/pinctrl.c).
> 
> AMS AS3722 DT is flat type on which all sub devices of AS3722 have the
> property on parent node only, there is no subnode for each sub driver
> like palmas. In this case all sub drivers of_node is initialized as
> parent->of_node in mfd-core.c (mfd_add_devices).
> 
> mfd-core.c: mfd_add_device()
>        if (!pdev->dev.of_node)
>                 pdev->dev.of_node = parent->of_node;
> 
> So all sub devices of AS3722 has the parent node.
> This node has the default pinmux configuration and so it tries to set
> the default pinmux before sud-driver's probe get called.
> The first one (for pinmux driver) it is success but for regulator and
> rtc, it is failed as pins are owned by the pinmux drivers.

Ah. I guess we should drop/revert 1c79a8b9f4a7 "mfd: Always assign
of_node in mfd_add_device()" then. I guess I'll make the RTC core look
at dev->of_node, or dev->parent->of_node to search for aliases. That
should avoid the issue.
