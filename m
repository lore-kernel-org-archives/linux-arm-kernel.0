From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 26 Jun 2012 15:13:46 +0100
Subject: [PATCH 7/9] I2C: MV64XXX: Add Device Tree support
In-Reply-To: <20120626141047.GA18804@lunn.ch>
References: <1339324322-29388-8-git-send-email-andrew@lunn.ch>
 <4FE9C14C.2030804@codethink.co.uk> <20120626141047.GA18804@lunn.ch>
Message-ID: <4FE9C39A.2080104@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/06/12 15:10, Andrew Lunn wrote:
> On Tue, Jun 26, 2012 at 03:03:56PM +0100, Ben Dooks wrote:
>> On 10/06/12 11:31, Andrew Lunn wrote:
>>> Extends the driver to get properties from device tree. Also extend the
>>> kirkwood DT support to supply the needed properties.
>>>
>>> Signed-off-by: Andrew Lunn<andrew@lunn.ch>
>>> ---
>>>   Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   35 +++++++++++++++++-
>>>   arch/arm/boot/dts/kirkwood.dtsi                    |   13 +++++++
>>>   arch/arm/mach-kirkwood/board-dt.c                  |    2 ++
>>>   drivers/i2c/busses/i2c-mv64xxx.c                   |   38 +++++++++++++++++---
>>>   4 files changed, 82 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
>>> index b891ee2..89ef899 100644
>>> --- a/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
>>> +++ b/Documentation/devicetree/bindings/i2c/mrvl-i2c.txt
>>> @@ -1,4 +1,4 @@
>>> -* I2C
>>> +* Marvell MMP I2C controller
>>>
>>>   Required properties :
>>>
>>> @@ -32,3 +32,36 @@ Examples:
>>>   		interrupts =<58>;
>>>   	};
>>>
>>> +* Marvell MV64XXX I2C controller
>>> +
>>> +Required properties :
>>> +
>>> + - reg         : Offset and length of the register set for the device
>>> + - compatible  : should be "marvell,mv64xxx-i2c"
>>> + - interrupts  : the interrupt number
>>> + - frequency-m : m factor in baud rate calculation
>>> +
>>> +Recommended properties :
>>> +
>>> + - frequency-n : n factor in baud rate calculation
>>> + - timeout-ms  : How long to wait for a transaction to complete
>>> +
>>> +Baud Rate:
>>> +
>>> +The baud rate is calculated thus:
>>> +
>>> +Fscl =          Ftclk
>>> +       ------------------------------------------
>>> +                                (frequency-n + 1)
>>> +       10 *(frequency-m + 1) * 2
>>> +
>>> +Examples:
>>
>> I'd really rather see this calculated at run-time, given some
>> systems can quite easily change their clocks.
>
> Hi Ben
>
> Well, none of the Orion systems would make use of this. They all have
> fixed clocks.
>
> Maybe the new Armada XP systems could make use of clock scaling?

A couple of the development boards here have dip-switches to change
the clocks at start-time, and thus having something that does this
would be useful.

PS, for other people's info, this bounces to the i2c list due to the
use of 'xxx' in the title :(

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
