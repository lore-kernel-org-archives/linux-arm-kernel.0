From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 11:55:55 -0800
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <20141211170934.GZ11764@sirena.org.uk>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
 <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
 <20141211170934.GZ11764@sirena.org.uk>
Message-ID: <CAD=FV=WBAuF0+BVMG9rp53Zt851Ou0kZ6xgTe9mjmgxyugWteg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Dec 11, 2014 at 9:09 AM, Mark Brown <broonie@kernel.org> wrote:
>> OK, I'll give a shot at taking my code and using it as a new
>> implementation for regulator_set_voltage_tol().  In the SD card code
>> I'll pick some reasonable tolerances--they won't be exactly what the
>> spec says, but they ought to be good enough.  If Ulf comes back and
>> yells at me then we can revisit adding a new API.
>
> OK, thanks.  Even if a new interface does get added the implementation
> needs to be shared with that for setting by tolerance, they're doing the
> same thing.

Yup, exactly.  I'll admit wasn't originally aware of the tolerance API
and my first thought after your email was to reimplement it atop my
patch.  ...but just having tolerance right now also seems sane.


> Please also bear in mind the need to handle shared supplies in your
> implementation.

I'm being dense, can you give more details?  Do you want me to grab
the mutex or do something smarter like track the voltage / tolerance
requested by multiple clients and resolve them, or ...?

I didn't grab any mutex because I thought all of the attributes I was
looking at were unchanging.  If they're not then
regulator_is_supported_voltage() probably has a bug since I'm reading
roughly the same attributes that it is.  ...and in fact the flow of my
code is also amost the same as regulator_is_supported_voltage()...

-Doug
