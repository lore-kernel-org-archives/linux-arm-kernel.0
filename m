From: phh@phh.me (Pierre-Hugues Husson)
Date: Thu, 27 Oct 2016 21:04:15 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <D75CB7DE-4165-4D2F-B40B-D2B6875C0172@konsulko.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <9B288597-7812-459D-A5C7-B61107751DA6@konsulko.com>
 <CAJ-oXjT=eVwEk7t5WoZAhjMhiZZkq0NN5tFLidSnUNO97D62zQ@mail.gmail.com>
 <D75CB7DE-4165-4D2F-B40B-D2B6875C0172@konsulko.com>
Message-ID: <CAJ-oXjS_=k4qE25t2b9eNnuqvVHf-1g7CZr81pPJx==aftF4xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-27 19:11 GMT+02:00 Pantelis Antoniou <pantelis.antoniou@konsulko.com>:
>
> Hi Pierre,
>
> > On Oct 27, 2016, at 19:59 , Pierre-Hugues Husson <phh@phh.me> wrote:
> >
> > 2016-10-27 17:52 GMT+02:00 Pantelis Antoniou <pantelis.antoniou@konsulko.com>:
> >> Yes there is no EEPROM but you might be able to map probing results to
> >> a fake ?model? number.
> >>
> >> Let me expand a bit:
> >>
> >> Assume that you have a number of probing steps, for example A, B, C each
> >> returning true or false, and C being executed only when B is ?true? you
> >> could do this to generate a bit field that identifies it.
> >>
> >> For example let?s assume that model FOO?s probing steps are
> >>
> >> A false, B true, C false -> 010
> >>
> >> Model?s BAR
> >>
> >> A true, B false, C don?t care -> 10x
> >>
> >> Mapping these to models could be
> >>
> >> Model FOO, (010 & 111) == 010 (all three probing steps must match)
> >>
> >> Model BAR, (10x & 110) = 100 (the first two probing steps must match)
> >
> > This method looks too complex on multiple grounds.
> > Assuming your method, I'm not too sure how this would actually be
> > described in a DTS.
> > Such probing steps should include reading/matching IDs in an EEPROM/on
> > an ADC, but it should also include the result of a driver's probe.
> > Also, drivers should have a way to report an ID/OTP instead of just a
> > boolean.
> >
>
> Err, I don?t think you got the point.
>
> The probing steps are done by a board specific probe driver.
> This driver performs the probing steps (which is exactly what Hans?s
> method now does) but instead of applying changes to the device tree
> programmatically generates a model string.
>
> This model string can be used by a general purpose overlay manager to apply
> the overlay(s) for the specific board. The plural part is important - read
> below.

Ok, I agree I didn't get the point, and I'm not sure I do now.
If I understand correctly, the difference between your method and
Hans', is that instead of manipulating directly OF properties based on
heuristics, there will be a heuristic to determine model revision, and
THEN apply overlays based on determined model revision.

If this is the correct interpretation, this means that for boards with
two possible accelerometers, a new driver is required, while something
as simple as i2c-probe-stop-at-first-match wouldn't require a new
driver.

> > As you mentioned, it is a way to distinguish models, not just a set of
> > parameters.
> > Does this mean that this DT would lead to loading various DT based on
> > the matching model, which would look like a FIT?
> > Also there is a modularity problem there. If I have phones with either
> > screen A or screen B, and with either accelerometer A or accelerometer
> > B, I would have to implement all four combinations.
> >
>
> The model lookup need not result in a simple overlay to apply.
>
> So for your case it would be:
>
> model corp,0 -> overlay screen A + overlay accel A
> model corp,1 -> overlay screen A + overlay accel B
> model corp,2 -> overlay screen B + overlay accel A
> model corp,3 -> overlay screen B + overlay accel B
>
> You don?t need the combinatorial number of overlays.

My worry initially was that all 4 "model corp" are needed, while with
using a simple approach like i2c-probe-stop-at-first-match, this
wouldn't be needed.
But now that I'm thinking of it again, for such a case to happen, this
would require to have OEMs picking random components for tablets of
one production batch. This wouldn't make any sense.
So I agree a model-based method should cover sufficient cases to be worthwhile.
I think it covers every device I've met.

Regards,
