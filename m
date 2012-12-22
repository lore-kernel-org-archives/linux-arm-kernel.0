From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sun, 23 Dec 2012 01:45:21 +0530
Subject: [PATCH] ARM: tegra: dts: add aliases and DMA requestor for serial
 controller
In-Reply-To: <50D4CBB0.7080603@wwwdotorg.org>
References: <1355898671-3960-1-git-send-email-ldewangan@nvidia.com>
 <50D1F2CB.3090206@wwwdotorg.org> <50D2AD02.6060101@nvidia.com>
 <50D344E9.70305@wwwdotorg.org> <50D3E320.2090804@nvidia.com>
 <50D4CBB0.7080603@wwwdotorg.org>
Message-ID: <50D614D9.8020106@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 December 2012 02:20 AM, Stephen Warren wrote:
> On 12/20/2012 09:18 PM, Laxman Dewangan wrote:
>> On Thursday 20 December 2012 10:33 PM, Stephen Warren wrote:
>>> On 12/19/2012 11:15 PM, Laxman Dewangan wrote:
>>>> On Wednesday 19 December 2012 10:30 PM, Stephen Warren wrote:
>>>>> On 12/18/2012 11:31 PM, Laxman Dewangan wrote:
>>>>>> Add APB DMA requestor and serial aliases for serial controller.
>>>>>> There will be two serial driver i.e. 8250 based simple serial driver
>>>>>> and APB DMA based serial driver for higher baudrate and performace.
> ...
>>>>> This patch seems to do two things:
> ...
>>>>> 2) Add aliases for the serial ports. I have no idea why this is useful.
>>>> Serial aliases are added because we want to get the port number like
>>>> /dev/ttyTHS0,  /d/ttyTHS2 etc. The uarta should be /dev/ttyTHS0 and
>>>> uartc should be /dev/ttyTHS2. The port number can be found using aliases
>>>> and of_alias_get_id() in driver file:
>>>>
>>>> port_number = of_alias_get_id(np, "serial");
>>> Oh, I see. I guess the aliases make sense then.
>>>
>>> But, wouldn't you only add aliases for the specific UARTs that are in
>>> use on a particular board (so put them in tegraNN-board.dts) rather than
>>> all UARTs on Tegra (i.e. the current patch which puts them into
>>> tegraNN.dtsi)?
>> I like to have this in tegraN N.dtsi file becasue:
>> - This policy is not going to change the board to board. For high speed
>> driver the uarta will be ttyTHS0 and uartb ttyTHS1.
> Sure it is. Since the board files select which UARTs use the low-speed
> driver vs. the high-speed driver by overriding the compatible value,
> each board will have a different subset of UARTs which use the high
> speed driver and hence which use the aliases. Don't you want to end up
> with /dev/ttyHS0 on each board, rather than ending up with a "random"
> device node name depending on which UART the board designer picked for
> the high speed device?

We had this in past where we started the high speed driver always from 0 
like in one board uartc become ttyHS0 and another board uarta become 
ttyHS0 and uartc become ttyHS1.
This confused more to other team (BT and modem team) as they need to 
know all uart instance and their corresponding driver.  So we kept uarta 
will be always 0 and uartc will be always 2. This way it is straight 
forward for the uart user to directly see the uart instance on board and 
decide the port number rather than going to what are other uart and 
their corresponding driver.


So we kept the
