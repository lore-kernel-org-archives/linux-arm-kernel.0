From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 27 Oct 2016 23:15:40 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <CAJ-oXjRJrs77yE-skpZ-V4e=rdhRyfNve9bibf1VOaZYy2=tRA@mail.gmail.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
 <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
 <CAJ-oXjTfRDvSKs9zZBxt1V2MR5C+XnsqfZBRTWwRrJXx-_7r=Q@mail.gmail.com>
 <4cfdd415-1965-7be9-b204-86a9931683a6@redhat.com>
 <CAJ-oXjRJrs77yE-skpZ-V4e=rdhRyfNve9bibf1VOaZYy2=tRA@mail.gmail.com>
Message-ID: <1a3f21dc-bd72-6749-6890-802be4bab038@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-10-16 19:31, Pierre-Hugues Husson wrote:
> 2016-10-27 16:53 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:

<snip>

>> We could just have:
>>
>>         i2c-probe-stop-at-first-match-0 = <&touchscreen1>, <&touchscreen2>,
>> <&touchscreen3>;
>>         i2c-probe-stop-at-first-match-1 = <&accelerometer1>,
>> <&accelerometer2>;
>>
>> And have the i2c bus code look for an i2c-probe-stop-at-first-match-[i++]
>> property
>> until it is not found. Having a child-node with its own compatible for this
>> feels wrong, as it uses a hierarchy where there really is none.
> Ok, looks much better indeed.
> I had one case where accelerometers could be on either i2c1 or i2c5.
> Do you think this could be handled as well, or this makes things much
> more complicated to fit in the i2c driver?

Handling that is easy, just add a i2c-probe-stop-at-first-match to
both busses (with separate child nodes to be probed under each bus),
the on one bus the probe-code will just read the end of the list
and stop, I believe we should not treat that as an error anyways
(even if there is only 1 bus).

>
>> So this would require us to be able to filter (to use your example)
>> on if another i2c device is found and on which address it is found,
>> that does not even take the rda559x check into account and is
>> going to cause interesting ordering issues, how do we know when
>> we can actually do the filtering if some of the variables we are
>> filtering on are set by other auto-detected paths. Which auto-detect /
>> i2c-probe-stop-at-first-match list do we execute first ? Worse
>> actually for accelerometer orientation I will likely need to
>> set the mount-matrix based on the detected touchscreen ...
>>
>> The rda559x here is a sdio wifi chip, which is also connected to the
>> i2c, and currently is detected through i2c to be able to separately
>> identify 2 q8 boards which share the same touchscreen + accelerometer
>> combination and who knows what other checks I or other people can
>> come up with to differentiate board variants which do not have
>> a simple eeprom to uniquely id them.
>>
>> So as said before, no this cannot be all done in dt without
>> adding a turing complete language to dt, and that is just to
>> select which touchscreen_variant to use.
> Ok, now that I understand the scope of your needs.
> I agree with you, this needs a (close to) turing complete language.
> I'm still not really happy about doing it in a driver, but I agree the
> full scope you need is scarce enough.
> Assuming this is done in a driver, there would need to be some
> plumbing between i2c-probe-stop-at-first-match, device's probe
> function and your driver, so that your driver only does the various
> if/cases and DT changes, but there is no actual device communication
> done in that driver.

Ah, no I meant dealing with this in the actual device driver,
not in some special intermediate driver, just like the actual x86
device drivers (sometimes) apply quirks based on board DMI strings.

<snip>

Regards,

Hans
