From: carlo@caione.org (Carlo Caione)
Date: Thu, 18 Feb 2016 22:04:41 +0100
Subject: [PATCH 2/2] ARM: dts: meson: Adding hwrev syscon node
In-Reply-To: <4136837.fyWFbJqZfO@wuerfel>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
 <4158343.mkrTsd5B4G@wuerfel>
 <CAOQ7t2byFoW657-1xnsBpeyPkB6K25R=_pPmRDmT32Sjef=kUw@mail.gmail.com>
 <4136837.fyWFbJqZfO@wuerfel>
Message-ID: <CAOQ7t2aqZj3STFsdTSQZMTK5U+8Oem8oFroxHKWkt=AeP+Zczg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 3:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 February 2016 15:14:45 Carlo Caione wrote:
>> >
>> > Yes, you should describe the device that is actually there, which would be
>> > something like
>> >
>> >         cbus at c1100000 {
>> >                 compatible = "amlogic,meson8b-cbus", "syscon";
>> >                 reg = <0xc1100000 0x10000>; /* no idea what the length is, fix it */
>> >         };
>> >
>> > Don't just make things up because you happen to access them in a particular
>> > way, but try to stay as close as you can to describing the actual hardware.
>>
>> Arnd,
>> in the cbus region are mapped a lot of different devices, do you think
>> that it is a good idea mapping the whole region as a single syscon
>> device?
>
> It really depends on what those other devices do with the registers:
>
> If each device just uses a couple of random registers from the cbus,
> they should probably all be changed to go through syscon.

In our case each device (pinmux, GPIO IRQ, clock controller, ...) uses
a consistent and contiguous set of registers inside cbus.
But in the same cbus sometimes we have also some registers that are
used for something different or peculiar like in this case. Usually
it's matter of one or two registers though, that's why I was a bit
curious about such a huge size 0x460.

> However, if some or all of the other devices actually are entirely
> made up of register ranges within cbus, that would indicate that
> cbus itself is not just a collection of random registers but something
> that could be considered a bus of itself in hardware, and then
> we could represent the other devices as children of this bus.

I think that this is exactly the case. We are missing this cbus in the
DTS because (for lacking of proper documentation) we are not sure
about start / end / size.

> Usually once you have a list of all the register locations, you can
> identify the hardware structure to a certain degree from that, even
> if you don't have access to a data sheet that would clarify this
> better.

Yes, in general for each single device the registers of interest are
contiguous inside cbus.

Thanks,

-- 
Carlo Caione
