From: highguy@gmail.com (Stijn Devriendt)
Date: Sun, 30 Sep 2012 17:19:14 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <506860C6.5020408@antcom.de>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CAOY=C6GG6jqqEAAGJjmDG-BFT2eq=9+ck+F_EOcthRgDCDv8=Q@mail.gmail.com>
 <50682402.8020402@antcom.de>
 <CAOY=C6FaLckRHSfAHvw2=J9xZEVFDZPL+1oKnKeGnpOGPFVB1w@mail.gmail.com>
 <506860C6.5020408@antcom.de>
Message-ID: <CAOY=C6F1rHoGM0T9FqLYuVwzaidDZBzEf_uWn9mP8fmT1oURTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 30, 2012 at 5:09 PM, Roland Stigge <stigge@antcom.de> wrote:
> Hi Stijn,
>
> On 30/09/12 16:52, Stijn Devriendt wrote:
>>> One question: How did you solve the one-value-per-file in the sysfs
>>> interface?
>>>
>> By exporting the group as a whole:
>> /sys/.../gpiogroup248/value
>> where value contains a decimal representing the group value.
>> Again, this respects the ordering of the pins:
>>
>> Actual pins: 0x2D (b 0010 1101)
>> Selected pins: 6 3 0 1
>> Readout: 6 (b 0 1 1 0)
>>
>> The export sysfs file does, however, accept multiple gpio IDs for groups.
>> Not sure if this is a 'violation' per se...
>
> If I understand correctly, it's a violation (single-value should hold
> for read and write).
>
> To solve it, I have the following in mind: /sys/.../gpiogroupXXX/
> contains files "bit0" ... "bit31" which contain a gpio number each,
> empty if "unconnected".

Unfortunately that means you can't atomically create a group.
It also creates a mess to keep ordering intact and to either
keep the current pin state or override it at allocation-time.

Rules are rules, but why make the interface overly complex when
the multi-value file is saner, cleaner and simpler?
I know I'm on the happy/corporate side of things and I can violate
whatever rule I can if it gets our product shipping, but I'd still
propose to have the multi-value approach, even in mainline.

Regards,
Stijn
