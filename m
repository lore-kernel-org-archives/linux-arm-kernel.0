From: phh@phh.me (Pierre-Hugues Husson)
Date: Thu, 27 Oct 2016 19:31:52 +0200
Subject: Add Allwinner Q8 tablets hardware manager
In-Reply-To: <4cfdd415-1965-7be9-b204-86a9931683a6@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161024173900.GP15620@leverpostej>
 <4cfbedb2-0249-e881-3577-dda0b0d4cabe@redhat.com>
 <CAJ-oXjQbOkrkNToEXYmPUZOgYBGbxQREZ4NL4bMcZmG=KP2vQQ@mail.gmail.com>
 <99dde1e0-26f0-cc7b-36bf-1181c47296f9@redhat.com>
 <CAJ-oXjTfRDvSKs9zZBxt1V2MR5C+XnsqfZBRTWwRrJXx-_7r=Q@mail.gmail.com>
 <4cfdd415-1965-7be9-b204-86a9931683a6@redhat.com>
Message-ID: <CAJ-oXjRJrs77yE-skpZ-V4e=rdhRyfNve9bibf1VOaZYy2=tRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-10-27 16:53 GMT+02:00 Hans de Goede <hdegoede@redhat.com>:
> Hi,
>
> No, the firmware-name (and matching resolution as different firmwares
> report different axis-ranges for the same digitizer) is selected
> primarily by the touchscreen_variant which sets: touchscreen_fw_name,
> touchscreen_width and touchscreen_height.
>
> The touchscreen_variant module option defaults to -1 which means "auto",
> when it is auto it gets set based on the touchscreen / accelerometer
> combination (which more or less uniquely identifies boards sofar),
> likewise all the other touchscreen module options default to -1,
> but can be overridden from the commandline.
>
> The intention is for things to just work, the commandline options are
> there as a fallback.
Ok, so I was really off. Sorry.
Now I think I understand the full complexity of the problem.

> We could just have:
>
>         i2c-probe-stop-at-first-match-0 = <&touchscreen1>, <&touchscreen2>,
> <&touchscreen3>;
>         i2c-probe-stop-at-first-match-1 = <&accelerometer1>,
> <&accelerometer2>;
>
> And have the i2c bus code look for an i2c-probe-stop-at-first-match-[i++]
> property
> until it is not found. Having a child-node with its own compatible for this
> feels wrong, as it uses a hierarchy where there really is none.
Ok, looks much better indeed.
I had one case where accelerometers could be on either i2c1 or i2c5.
Do you think this could be handled as well, or this makes things much
more complicated to fit in the i2c driver?

> So this would require us to be able to filter (to use your example)
> on if another i2c device is found and on which address it is found,
> that does not even take the rda559x check into account and is
> going to cause interesting ordering issues, how do we know when
> we can actually do the filtering if some of the variables we are
> filtering on are set by other auto-detected paths. Which auto-detect /
> i2c-probe-stop-at-first-match list do we execute first ? Worse
> actually for accelerometer orientation I will likely need to
> set the mount-matrix based on the detected touchscreen ...
>
> The rda559x here is a sdio wifi chip, which is also connected to the
> i2c, and currently is detected through i2c to be able to separately
> identify 2 q8 boards which share the same touchscreen + accelerometer
> combination and who knows what other checks I or other people can
> come up with to differentiate board variants which do not have
> a simple eeprom to uniquely id them.
>
> So as said before, no this cannot be all done in dt without
> adding a turing complete language to dt, and that is just to
> select which touchscreen_variant to use.
Ok, now that I understand the scope of your needs.
I agree with you, this needs a (close to) turing complete language.
I'm still not really happy about doing it in a driver, but I agree the
full scope you need is scarce enough.
Assuming this is done in a driver, there would need to be some
plumbing between i2c-probe-stop-at-first-match, device's probe
function and your driver, so that your driver only does the various
if/cases and DT changes, but there is no actual device communication
done in that driver.

> Then there also the probem of the combinatorial explosion having
> not only 2 firmware files but also invert-x and invert-y flags causes:
> We have 2 revisions with each 2 different firmware-files (more actually
> but I've reduced the set since some firmwares are compatible) with each
> both the x- and / or y axis as normal or inverted, for a total of:
> 2 (revision) * 2 (firmware-files) * 2 (x-inverted or not) * 2 (y...) = 16
> touchscreen variants, which means dt nodes for touchscreen1 to touchscreen16
> and that is just the silead gsl1680, some of these tablets also have
> elan or zeitec touchscreen controllers.
>
> Now imagine what happens if a new board comes out which needs a 3th firmware
> file... I hope you can understand this is not a route I want to go.
Right, I agree with you.
> Another problem is that if a user encounters the need for a new firmware
> variant he can now not easily try this (where as before we had
> module options to separately override firmware-name, the size, etc.
>
> As written in my previous mail, this is all rather gsl1680 specific,
> and esp. being able to override the firmware-name, the size, etc.
> through module options is going to be useful (to ask endusers to test
> stuff without recompiling) on x86 too. So we will likely want to add
> most of the necessary stuff to the silead driver anyways.

That's not currently the case, but can't we assume it will become easy
for users to install a DT overlay?
This would drop all your needs of module parameters, and would
actually be more modulable than your current scheme.
It is a more longer term thought, and could instead apply to further
boards having the same sort of troubles as you, rather than for this
first driver.
