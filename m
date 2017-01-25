From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 25 Jan 2017 03:51:07 -0800
Subject: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
In-Reply-To: <20170125111233.GB3912@amd>
References: <20170123141331.GA11402@amd>
 <da1f1b45-3ae5-ffe8-62c6-9ec7c3a1505b@roeck-us.net>
 <20170123144031.GA7870@amd> <20170123232654.GA19342@amd>
 <20170123234912.GA2460@roeck-us.net> <20170124070639.GA5068@rzhang1-surface>
 <20170124073720.GB5603@amd>
 <88c94ea6-abe2-0f20-337e-e9ee00c883d8@roeck-us.net>
 <20170124175800.GA15070@amd> <20170124184526.GA25056@roeck-us.net>
 <20170125111233.GB3912@amd>
Message-ID: <d5321db7-fc74-fe36-812b-1918a2ac3fc0@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2017 03:12 AM, Pavel Machek wrote:
> Hi!
>
>>>>>> Right.
>>>>>>
>>>>>> Before reverting, can you please try if this patch works or not?
>>>>>
>>>>> Not really. Revert now. Sorry.
>>>>>
>>>>> Are you sure? This does not look equivalent to me at all.
>>>>>
>>>>> "name" file handling moved from drivers to the core, which added some
>>>>> crazy checks what name can contain. Even if this "works", what is the
>>>>> expected effect on the "name" file?
>>>>>
>>>> The hwmon name attribute must not include '-', as documented in
>>>> Documentation/hwmon/sysfs-interface. Is enforcing that 'crazy' ?
>>>> Maybe in your world, but not in mine.
>>>
>>> Well, lets revert the patch and then we can discuss what to do with
>>> the "name" problem.
>
> Ok, so the patch is on the way in. What to do next?
>
> pavel at n900:/sys/class/hwmon$ cat hwmon0/name
> bq27200-0
> pavel at n900:/sys/class/hwmon$ cat hwmon1/name
> rx51-battery
>

The 'name' parameter will be mandatory for hwmon_device_register_with_groups()
and hwmon_device_register_with_info() starting with v4.11, and the API
documentation will be updated to list all invalid characters.

The thermal subsystem doesn't play well when it comes to hwmon userspace
interaction (generating and removing sensor attributes dynamically
messes up pretty much everything, and generating the name attribute after
hwmon registration for sure messes up any udev listener). libsensors gets
confused by '-' in the 'name' attribute. libsensors also doesn't expect
sensor attributes to be dynamically generated and removed, and may
react unpredictably if they are. This all means that any existing users
of hwmon devices created by the thermal subsystem will most likely not
use libsensors nor udev listeners. At the same time, it seems to be quite
important at least to you that the '-' in the name is retained.

Given all that, maybe thermal should just stick with the deprecated API
and accept the deprecated warning message (or maybe drop hwmon support
altogether).

Guenter
