From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 22 Oct 2012 23:11:02 +0200
Subject: [PATCH 3/5] arm: mvebu: Added IPI support via doorbells
In-Reply-To: <20121022200708.GO21046@lunn.ch>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
 <20121022173028.GM21046@lunn.ch> <50859976.6080601@free-electrons.com>
 <20121022200708.GO21046@lunn.ch>
Message-ID: <5085B666.1040500@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 10:07 PM, Andrew Lunn wrote:
> On Mon, Oct 22, 2012 at 09:07:34PM +0200, Gregory CLEMENT wrote:
>> On 10/22/2012 07:30 PM, Andrew Lunn wrote:
>>> On Mon, Oct 22, 2012 at 07:02:45PM +0200, Gregory CLEMENT wrote:
>>>> From: Yehuda Yitschak <yehuday@marvell.com>
>>>>
>>>> Signed-off-by: Yehuda Yitschak <yehuday@marvell.com>
>>>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>>>> ---
>>>>  arch/arm/boot/dts/armada-xp.dtsi        |    2 +-
>>>>  arch/arm/mach-mvebu/armada-370-xp.h     |   10 ++++
>>>>  arch/arm/mach-mvebu/irq-armada-370-xp.c |   92 +++++++++++++++++++++++++++++--
>>>>  3 files changed, 97 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
>>>> index f521ed8..531619f 100644
>>>> --- a/arch/arm/boot/dts/armada-xp.dtsi
>>>> +++ b/arch/arm/boot/dts/armada-xp.dtsi
>>>> @@ -24,7 +24,7 @@
>>>>  
>>>>  	mpic: interrupt-controller at d0020000 {
>>>>  	      reg = <0xd0020a00 0x1d0>,
>>>> -		    <0xd0021870 0x58>;
>>>> +		    <0xd0021070 0x58>;
>>>>  	};
>>>
>>> Hi Gregory
>>>
>>> Is this a bug fix needed for 3.7?
>>>
>>>    Andrew
>>>
>> I don't think so.
>> We extended the reg map to be able to use registers only used for SMP.
>> When we didn't have SMP support the mapping was correct, and now by
>> introducing SMP we extend it.
> 
> The length has stayed the same, so its not extended. Its now 0x800
> bytes earlier in the address space.
> 

Right!
I didn't check it, sorry.

The correct explanation is that the offset +21070 is a CPU virtual offset.
That means that depending of the CPU core which will access to this register,
the controller will internally change the offset automagically to point the
correct offset.

I should have added an explanation in the commit log. I will do it for V2.

>       Andrew
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
