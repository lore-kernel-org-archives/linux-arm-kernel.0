From: stigge@antcom.de (Roland Stigge)
Date: Sun, 30 Sep 2012 17:46:29 +0200
Subject: [PATCH RFC 1/2] gpio: Add a block GPIO API to gpiolib
In-Reply-To: <CAOY=C6F1rHoGM0T9FqLYuVwzaidDZBzEf_uWn9mP8fmT1oURTQ@mail.gmail.com>
References: <1348780923-27428-1-git-send-email-stigge@antcom.de>
 <CAOY=C6GG6jqqEAAGJjmDG-BFT2eq=9+ck+F_EOcthRgDCDv8=Q@mail.gmail.com>
 <50682402.8020402@antcom.de>
 <CAOY=C6FaLckRHSfAHvw2=J9xZEVFDZPL+1oKnKeGnpOGPFVB1w@mail.gmail.com>
 <506860C6.5020408@antcom.de>
 <CAOY=C6F1rHoGM0T9FqLYuVwzaidDZBzEf_uWn9mP8fmT1oURTQ@mail.gmail.com>
Message-ID: <50686955.8040503@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/12 17:19, Stijn Devriendt wrote:
>> If I understand correctly, it's a violation (single-value should hold
>> for read and write).
>>
>> To solve it, I have the following in mind: /sys/.../gpiogroupXXX/
>> contains files "bit0" ... "bit31" which contain a gpio number each,
>> empty if "unconnected".
> 
> Unfortunately that means you can't atomically create a group.

I don't see a big advantage of having atomic create/request. Most
important is set/get, isn't it? I assume the following usage pattern:

* Create(request) - non atomic (maybe atomic but why not add GPIOs later?)
* Set - atomic
* Get - atomic
* ...

> It also creates a mess to keep ordering intact and to either
> keep the current pin state or override it at allocation-time.

Ordering should stay intact, and later add/delete operations could be
possible. I meant bit0 ... bit31 in the gpio block as such:

bit0  - "80"
bit1  - ""  (i.e. unconnected)
bit2  - "85"
bit3  - "2"
...
bit31 - ""

This scheme can support multiple gpio_chips, as discussed with Linus and
JC, which of course can't always guarantee real simultaneous I/O but
provide virtual I/O word access (32bit/64bit).

> Rules are rules, but why make the interface overly complex when
> the multi-value file is saner, cleaner and simpler?

Simply because they won't (and probably shouldn't) accept it mainline.

Roland
