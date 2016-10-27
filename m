From: phh@phh.me (Pierre-Hugues Husson)
Date: Thu, 27 Oct 2016 18:59:00 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <9B288597-7812-459D-A5C7-B61107751DA6@konsulko.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <9B288597-7812-459D-A5C7-B61107751DA6@konsulko.com>
Message-ID: <CAJ-oXjT=eVwEk7t5WoZAhjMhiZZkq0NN5tFLidSnUNO97D62zQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-27 17:52 GMT+02:00 Pantelis Antoniou <pantelis.antoniou@konsulko.com>:
> Yes there is no EEPROM but you might be able to map probing results to
> a fake ?model? number.
>
> Let me expand a bit:
>
> Assume that you have a number of probing steps, for example A, B, C each
> returning true or false, and C being executed only when B is ?true? you
> could do this to generate a bit field that identifies it.
>
> For example let?s assume that model FOO?s probing steps are
>
> A false, B true, C false -> 010
>
> Model?s BAR
>
> A true, B false, C don?t care -> 10x
>
> Mapping these to models could be
>
> Model FOO, (010 & 111) == 010 (all three probing steps must match)
>
> Model BAR, (10x & 110) = 100 (the first two probing steps must match)

This method looks too complex on multiple grounds.
Assuming your method, I'm not too sure how this would actually be
described in a DTS.
Such probing steps should include reading/matching IDs in an EEPROM/on
an ADC, but it should also include the result of a driver's probe.
Also, drivers should have a way to report an ID/OTP instead of just a
boolean.

As you mentioned, it is a way to distinguish models, not just a set of
parameters.
Does this mean that this DT would lead to loading various DT based on
the matching model, which would look like a FIT?
Also there is a modularity problem there. If I have phones with either
screen A or screen B, and with either accelerometer A or accelerometer
B, I would have to implement all four combinations.

I'm starting to agree with Hans, and to be able to implement
everything he needs, would require a turing complete device-tree,
which can include and apply device-tree overlays.
This doesn't mean it can't be done, nor that it shouldn't be done, but
that's a lot of work.

Hans' i2c-probe-stop-at-first-match does make sense for most usecases,
but I have two problems with it:
1. It is I2C specific (as I've mentioned earlier, I have the same
needs with DSI panels)
2. This looks like a temporary solution if a turing-complete solution
is to be implemented.
