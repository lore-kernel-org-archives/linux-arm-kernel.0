From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Oct 2016 22:51:09 +0200
Subject: [RFC PATCH 0/5] Add an overlay manager to handle board capes
In-Reply-To: <CAL_JsqKTMjj0x6Zq3t5GsWvAC1qN10r333v9uGXkJq_DjioRmA@mail.gmail.com>
References: <20161026145756.21689-1-antoine.tenart@free-electrons.com>
 <CAL_JsqL9yWBj0yYE54XGi87YPGugGAACzr=CuW6dk5kk3EuyCA@mail.gmail.com>
 <4ca9db09-e52c-11ec-133b-8f193b9b7174@redhat.com>
 <CAL_JsqKTMjj0x6Zq3t5GsWvAC1qN10r333v9uGXkJq_DjioRmA@mail.gmail.com>
Message-ID: <fc4f062e-d22d-016b-cf85-6da3af489852@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-10-16 19:30, Rob Herring wrote:
> On Thu, Oct 27, 2016 at 10:13 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 27-10-16 15:41, Rob Herring wrote:
>>>
>>> Please Cc the maintainers of drivers/of/.
>>>
>>> + Frank R, Hans, Dmitry S
>>>
>>> On Wed, Oct 26, 2016 at 9:57 AM, Antoine Tenart
>>> <antoine.tenart@free-electrons.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> Many boards now come with dips and compatible capes; among others the
>>>> C.H.I.P, or Beaglebones. All these boards have a kernel implementing an
>>>> out-of-tree "cape manager" which is used to detected capes, retrieve
>>>> their description and apply a corresponding overlay. This series is an
>>>> attempt to start a discussion, with an implementation of such a manager
>>>> which is somehow generic (i.e. formats or cape detectors can be added).
>>>> Other use cases could make use of this manager to dynamically load dt
>>>> overlays based on some input / hw presence.
>>>
>>>
>>> I'd like to see an input source be the kernel command line and/or a DT
>>> chosen property. Another overlay manager was proposed not to long
>>> ago[1] as well. There's also the Allwinner tablet use case from Hans
>>> where i2c devices are probed and detected. That's not using overlays
>>> currently, but maybe could.
>>
>>
>> Actually I'm currently thinking in a different direction, which I
>> think will be good for the boards where some ICs are frequently
>> replaced by 2nd (and 3th and 4th) sources, rather then that we're
>> dealing with an extension connector with capes / daughter boards.
>>
>> Although there is some overlap I'm starting to think that we need to
>> treat these 2 cases differently. Let me quickly copy and paste
>> the basic idea I've for the 2nd source touchscreen / accelerometer
>> chip case:
>>
>> """
>> The kernel actually already has a detect() method in struct i2c_driver,
>> we could use that (we would need to implement it in drivers which do not
>> have it yet). Note on second thought it seems it may be better to use
>> probe() for this, see below.
>>
>> Then we could have something like this in dt:
>>
>> &i2c0 {
>>     touchscreen1: gsl1680 at 40 {
>>         reg = <0x40>;
>>         compatible = "silead,gsl1680";
>>         enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>>         status = "disabled";
>>     };
>>
>>     touchscreen2: ektf2127 at 15 {
>>         reg = <0x15>;
>
> Do you ever have different devices with the same address? That would
> be somewhat problematic as really these should be
> "touchscreen@<addr>".

Yes that happens (sometimes).

>
>>         compatible = "elan,ektf2127";
>>         enable-gpios = <&pio 7 1 GPIO_ACTIVE_HIGH>; /* PH1 */
>>         status = "disabled";
>>     };
>>
>>     i2c-probe-stop-at-first-match-0 = <&touchscreen1>, <&touchscreen2>;
>>     i2c-probe-stop-at-first-match-1 = <&accelerometer1>, <&accelerometer2>;
>> }
>>
>> Which would make the i2c subsys call detect (*) on each device, until
>> a device is found. Likewise we could have a "i2c-probe-all" property
>> which also walks a list of phandles but does not stop on the first
>> match.
>>
>> ...
>>
>> *) Yes this sounds Linux specific, but it really is just "execute
>> to-be-probed
>> device compatible specific detection method"
>> """
>
> Yeah, not a fan of these properties at first glance. Why can't you
> just fail probe on the non-existent devices?

That is possible and in the other thread on this there are some
links to some boards which actually already do this, but from a dt
pov it feels wrong. If we know only one of a set of options will
ever be there we ought to describe things like this in the dt.

Functionality wise this has 2 advantages:
1) We stop probing needlessly once a device is found, in some
cases the majority of the board variants has dev a, and some
have dev b / c. Then putting a first in the to-probe list will
save probing b / c on most boards.

2) Not all i2c chips are easily identifiable, so in some cases
one may want to put dev x as last to probe, because the
probe solely consists of: "Does something ack i2c transfers
at this address".

>> This does not 100% solve all q8 issues (see the "Add Allwinner Q8 tablets
>> hardware manager" thread), but does solve quite a bit of the use-case
>> and this matches what many vendor os-images (typically android) are
>> actually doing for these kind of boards.
>
> BTW, I've been meaning to ask you if you are looking at the Android
> side of things as well?

No, I purely use android os images / SDKs as a source of how the
hw works, I do not have any intentions to try and get android up
and running with mainline on these boards.

>> As for the bits this does not solve, those are mostly board specific details
>> which cannot be probed at all, and on x86 are typically solved in the device
>> driver by doing a dmi check to identify the board and then apply a board
>> specific workaround in the driver.
>>
>> I've come to believe that we should similarly delegate dealing this to
>> device
>> drivers in the devicetree case. Note that dt should still of course fully
>> describe the hardware for normal hardware, the driver would just need to
>> care
>> about weird board quirks in certain exceptions.
>
> Which is fine IMO, though I do think we should look at those cases
> carefully to ensure they stay the exception.

Ack.

>> A more interesting problem here is that dt does not have something like
>> DMI, there is the machine compatible, but that typically does not contain
>> board revision info (where as DMI often does). I believe that this is
>> actually something which should be fixed at the bootloader level
>> have it prepend a new machine compatible which contains revision info.
>>
>> Hmm, if we make the bootloader prepend a new machine compatible which
>> contains
>> revision info, we could then trigger quirks on this and in some cases avoid
>> the need for dealing with board quirks in the driver ...
>
> That would work. Board and chip versions both need better handling in
> kernel IMO.
>
> QCom has a whole scheme around version numbering in compatible
> strings. (Unfortunately, bootloaders only support their previous way
> of doing things.)
>
>> Note this is all very specific to dealing with board (revision) variants,
>> for add-ons having the bootloader add info to the machine compatible does
>> not seem the right solution.
>
> Agreed.

Regards,

Hans
