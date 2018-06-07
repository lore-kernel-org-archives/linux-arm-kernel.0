From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 7 Jun 2018 10:34:55 +0100
Subject: [PATCH v4 05/14] coresight: get/put module in
 coresight_build/release_path
In-Reply-To: <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
References: <20180605210710.22227-1-kim.phillips@arm.com>
 <20180605210710.22227-6-kim.phillips@arm.com>
 <20180606082422.GB19727@kroah.com>
 <a457594c-b391-23e1-6ab5-d115073cac5a@arm.com>
 <20180606155501.704583e1412996a1a2c6fa61@arm.com>
 <20180607083401.GE16651@kroah.com>
 <3219276b-2703-bc30-92e1-bae80cdc5901@arm.com>
 <20180607091353.GA20438@kroah.com>
 <2f8d233e-8847-ce3d-3a5b-06b175e3944b@arm.com>
Message-ID: <30d4d1cc-47d8-b42d-af5d-b1f6301d1bd9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2018 10:32 AM, Suzuki K Poulose wrote:
> On 06/07/2018 10:13 AM, Greg Kroah-Hartman wrote:
>> On Thu, Jun 07, 2018 at 10:04:33AM +0100, Suzuki K Poulose wrote:
>>> Hi Greg,
>>>
>>> On 06/07/2018 09:34 AM, Greg Kroah-Hartman wrote:
>>>> On Wed, Jun 06, 2018 at 03:55:01PM -0500, Kim Phillips wrote:
>>>>> On Wed, 6 Jun 2018 10:46:36 +0100
>>>>> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>>>>>
>>>>>> On 06/06/2018 09:24 AM, Greg Kroah-Hartman wrote:
>>>>>>> On Tue, Jun 05, 2018 at 04:07:01PM -0500, Kim Phillips wrote:
>>>>>>>> Increment the refcnt for driver modules in current use by calling
>>>>>>>> module_get in coresight_build_path and module_put in release_path.
>>>>>>>>
>>>>>>>> This prevents driver modules from being unloaded when they are 
>>>>>>>> in use,
>>>>>>>> either in sysfs or perf mode.
>>>>>>>
>>>>>>> Why does it matter?? Shouldn't you be allowed to remove any 
>>>>>>> module at
>>>>>>> any point in time, much like a networking driver?
>>>
>>> The user doesn't have an explicit refcount on the individual components
>>> in a trace session. So, when a trace session is in progress, it is as
>>> good as having a "file" open on each component that is part of the
>>> active trace session. So, we don't want the driver to be removed when
>>> the component is being used in the trace collection.
>>
>> Why not?? What's wrong with that happening and then the trace collection
>> starts failing with -ENODEV or something?

Forgot to add, this will indeed hit -ENODEV, if the device driver was
removed, as we fail to build the trace path before the session.

> 
> May be I am missing something here. Can we allow the driver to be 
> removed when one of its device is "turned ON" and we need the same
> driver to "turn it OFF" when the session ends ? To make a better
> comparison :
> 
> Can we unload a usb_mass_storage module when a USB disk(which uses the 
> module driver) is mounted and is being used ? I believe, the module
> will eventually get unloaded when we unmount the disk, if someone did
> a unload.
> 
> We have a similar situation here. The only difference is the driver is
> referenced only when one of its device is in a trace session.
> 
>>
>> Remember, removing a kernel module is something that only happens very
>> rarely, and is an explicit choice by someone with root permissions.? If
>> you want to remove that module, it should be able to go, as you know
>> what you are doing at that point in time.
> 
> Right, but when a device is "in use" can we do that ? I thought the user
> will get a module is in use or busy, error.
> 
> 
>>
>> Don't try to "protect the user from themselves" here, they want to shoot
>> their foot, make it hurt if they are aiming it there :)
>>
> 
> The module_get/put added here are only triggered when we start a trace 
> session, where we build a path for the current session from the 
> configured "source" to the configured "sink" and the path is destroyed
> at the end of the trace session. i.e, the path is not a permanent thing.
> It is constructed per session. So it is perfectly possible to remove a
> device in between trace sessions.
> 
>>> This will be
>>> released as soon as the session is ended. It is just like a PMU driver
>>> where the module refcount is held to ensure the module stays until the
>>> session is over. In this case, we have multiple components, each with
>>> its own driver invisible to the PMU driver. Hence the coresight driver
>>> must hold the reference.
>>
>> Again, please think this through and don't add extra complexity to the
>> normal path, and get it right if you do it (the existing patch is not
>> right as I pointed out.)? Personally, I feel the code should just be
>> able to be unloaded whenever they want, user beware...
> 
> Sure, will explore more to refine the code. Thanks for the trigger.
> 
> Cheers
> Suzuki

Suzuki
