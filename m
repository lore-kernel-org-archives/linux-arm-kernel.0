From: khilman@linaro.org (Kevin Hilman)
Date: Fri, 28 Feb 2014 09:21:34 -0800
Subject: [PATCH 0/8] PM / Sleep / Runtime: Fixup some driver's system
 suspend
In-Reply-To: <CAPDyKFp_ugRytLGR4fGXvdZEMRohg6uWPykcFJ7Co_wipJujDA@mail.gmail.com>
 (Ulf Hansson's message of "Thu, 27 Feb 2014 09:18:34 +0100")
References: <1392910280-12891-1-git-send-email-ulf.hansson@linaro.org>
 <7htxblx2eo.fsf@paris.lan> <12123949.qNoh3vhWUc@vostro.rjw.lan>
 <CAPDyKFp_ugRytLGR4fGXvdZEMRohg6uWPykcFJ7Co_wipJujDA@mail.gmail.com>
Message-ID: <7hk3cftaox.fsf@paris.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 27 February 2014 02:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Wednesday, February 26, 2014 08:30:07 AM Kevin Hilman wrote:
>>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>>>
>>> > Patch 1 -> 2:
>>> > These patches provides two new runtime PM helper functions which intend to be
>>> > used from system suspend/resume callbacks, to make sure devices are put into low
>>> > power state during system suspend and brought back to full power at system
>>> > resume.
>>> >
>>> > The prerequisite is to have all levels of a device's runtime PM callbacks to be
>>> > defined through the SET_PM_RUNTIME_PM_OPS macro, which means these are available
>>> > for CONFIG_PM.
>>> >
>>> > By using the new runtime PM helper functions especially the two scenarios below
>>> > will be addressed.
>>> >
>>> > 1) The PM core prevents .runtime_suspend callbacks from being invoked during
>>> > system suspend. That means even for a runtime PM centric subsystem and driver,
>>> > the device needs to be put into low power state from a system suspend callback.
>>> > Otherwise it may very well be left in full power state (runtime resumed) while
>>> > the system is suspended. By using the new helper functions, we make sure to walk
>>> > the hierarchy of a device's power domain, subsystem and driver.
>>>
>>> I thought it was the case that runtime PM was only disabled during the
>>> 'late' phase now.  Isn't that enough to allow runtime callbacks in the
>>> normal suspend/resume hooks now?   /me looks.
>>>
>>> oh, wait.  Ee still have the _get_noresume() in device_prepare().  hmm
>>>
>>> Either way, I'm not not a big fan of new functions.  Personally, I think
>>> subsystems/busses/pm_domains should be able to opt out of the PM core
>>> behavior that blocks runtime PM transitions during system suspend.
>>> Something like the (untested) hack below.  That way, we could avoid the
>>> need for new helper functions.
>>
>> And if one of the subsystems in question is the platform bus type, then
>> adding the flag doesn't really make sense, because that means that on
>> many system it will be set for the majority of devices. :-)
>>
>> That said I'm tired of this stuff already.  If you really really want to
>> remove the bumping up and dropping of the usage counter during system
>> suspend/resume by the core, please feel free to submit a patch for that
>> and I'll apply it.  However, if it causes any regressions to happen
>> anywhere, it will be dropped and we'll never talk about this again.
>>
>> Deal?
>
> No deal. I prefer the runtime PM helpers, I think that is the right
> approach. I also believe this is what Alan Stern also would prefer,
> right!? So let's convince Kevin instead. :-)

I don't need much convincing.  

My preference is for fewer functions/helpers because runtime PM is
already complicated enough for drivers.  However, I'm not going to
object to the helpers because they will allow us to simplify many
drivers/subsystems that are trying to handle the various combinations of
suspend/resume and runtime PM, so it's a step in the right direction.

Kevin
