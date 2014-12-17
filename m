From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 17 Dec 2014 11:52:58 +0900
Subject: [PATCH v5 1/3] gpio: Cygnus: define Broadcom Cygnus GPIO binding
In-Reply-To: <2063145.N1Hk6vVF2S@wuerfel>
References: <1418342706-14755-2-git-send-email-rjui@broadcom.com>
 <1628217.66frkAqHMc@wuerfel> <548F5433.5090901@broadcom.com>
 <2063145.N1Hk6vVF2S@wuerfel>
Message-ID: <CAAVeFu+ZUJ7TJEPQ7Krxw92_giTW_FuD16xmV4vi8D-=O0fO9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 6:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 December 2014 13:35:47 Ray Jui wrote:
>>
>> Like I said previously, dynamic GPIO allocation works fine in the
>> kernel, as long as all of our GPIO clients in the kernel use gpiod based
>> API, which is what we will enforce going forward. The only problem is
>> with some of our customers who use GPIO through sysfs and expect fixed
>> global GPIO numbers. Thinking about this more, it's probably not that
>> difficult to add a script for those customers to convert/map the GPIO
>> numbers based on readings parsed from sysfs, so I guess that's fine.
>>
>
> I think we discussed the user space interface a number of times
> in the past, but I forgot the outcome. Either there is already
> a way to name gpio lines uniquely in sysfs, or there should be
> one.
>
> Can you reach the gpio interfaces using /sys/devices/0001234.bus/1234566.gpiocontroller/...?

No, but it seems like this is exactly the solution we need. We could
have an "export" node there that takes a relative GPIO number and
exports it under
/sys/devices/0001234.bus/1234566.gpiocontroller/exported/ the same way
the current sysfs exporter does. Then for convenience we could also
allow exported GPIOs to take names to be used under the shorter
/sys/class/gpio/ (named GPIOs is another request we pushed back many
times but that keeps coming).

Let's see if I can come with a patch. That would at least give us
something to reply to the many people that hit this issue.
