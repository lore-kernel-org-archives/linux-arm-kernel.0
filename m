From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 21 Dec 2012 09:48:40 +0530
Subject: [PATCH] ARM: tegra: dts: add aliases and DMA requestor for serial
 controller
In-Reply-To: <50D344E9.70305@wwwdotorg.org>
References: <1355898671-3960-1-git-send-email-ldewangan@nvidia.com>
 <50D1F2CB.3090206@wwwdotorg.org> <50D2AD02.6060101@nvidia.com>
 <50D344E9.70305@wwwdotorg.org>
Message-ID: <50D3E320.2090804@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 December 2012 10:33 PM, Stephen Warren wrote:
> On 12/19/2012 11:15 PM, Laxman Dewangan wrote:
>> On Wednesday 19 December 2012 10:30 PM, Stephen Warren wrote:
>>> On 12/18/2012 11:31 PM, Laxman Dewangan wrote:
>>>> Add APB DMA requestor and serial aliases for serial controller.
>>>> There will be two serial driver i.e. 8250 based simple serial driver
>>>> and APB DMA based serial driver for higher baudrate and performace.
>>>>
>>>> The simple serial driver get enabled with compatible nvidia,tegra20-uart
>>>> and APB DMA based driver will get enabled with compatible
>>>> nvidia,tegra20-hsuart.
>>> This patch seems to do two things:
>>>
>>> 1) Add a comment describing how to select the basic or DMA-based driver.
>>> I can see why this is useful.
>>>
>>> 2) Add aliases for the serial ports. I have no idea why this is useful.
>> Serial aliases are added because we want to get the port number like
>> /dev/ttyTHS0,  /d/ttyTHS2 etc. The uarta should be /dev/ttyTHS0 and
>> uartc should be /dev/ttyTHS2. The port number can be found using aliases
>> and of_alias_get_id() in driver file:
>>
>> port_number = of_alias_get_id(np, "serial");
> Oh, I see. I guess the aliases make sense then.
>
> But, wouldn't you only add aliases for the specific UARTs that are in
> use on a particular board (so put them in tegraNN-board.dts) rather than
> all UARTs on Tegra (i.e. the current patch which puts them into
> tegraNN.dtsi)?

I like to have this in tegraN N.dtsi file becasue:
- This policy is not going to change the board to board. For high speed 
driver the uarta will be ttyTHS0 and uartb ttyTHS1.
- In board file I will only enable driver and make compatible, not worry 
about the making aliases.

This approach will simplify the instantiation. This will also avoid 
confusion like the aliases get added or not when we create board dts file.
This will be on same line we have with board files where pdev->id is 
fixed for all board in common place i.e. device.c which decide the 
port-number.
