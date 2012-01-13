From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 14 Jan 2012 01:11:41 +0800
Subject: [RFC PATCH v3 2/5] pinctrl: add dt binding support for pinmux
 mappings
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
References: <1324402840-32451-1-git-send-email-b29396@freescale.com>
 <1324402840-32451-3-git-send-email-b29396@freescale.com>
 <74CDBE0F657A3D45AFBB94109FB122FF176BE92F00@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC6057885075542@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF176CC743EF@HQMAIL01.nvidia.com>
 <CAA+hA=RBqpSmntS2h+6xMQuRvSRHenmDgrYSSzMXHtOCpU+HCQ@mail.gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF17761F18F8@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788507F698@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE39E6B@HQMAIL01.nvidia.com>
 <7FE21149F4667147B645348EC605788508AC65@039-SN2MPN1-013.039d.mgd.msft.net>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A76A@HQMAIL01.nvidia.com>
Message-ID: <CAA+hA=RCmctmQJU4-k7YhzQDMi8KuyisBqOFhuMd3RV4_E=gCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 4:17 AM, Stephen Warren <swarren@nvidia.com> wrote:
...
>> To keep consistency as the currently design of pinctrl subsystem and also meet
>> the dt design philosophy, we still do not introduce a pinmux map in dt.
>> Instead, we choose to scan all the device node with a 'pinmux' phandle to construct
>> a pinmux map table before register the pin controller device(here we may also scan
>> the hog_on_boot node) and I guess it's easy to do that.
> ...
>> (Without scan the device node to construct the pinmux map table, we can only get the map
>> Information when we run the pinmux_get.
>> See: https://lkml.org/lkml/2012/1/5/153
>> So no pinmux map table exists and we surely do not want to see that the sysfs exporting
>> pinmux map information works in dt but unwork in non-dt)
>
> Hmmm. I'm not sure that the pinctrl code should actively scan all nodes
> in the device tree for pin mux properties. That seems a little invasive;
> how does pinctrl know which nodes it really should be looking at, and
> which nodes are random internal parts of some device's custom binding?
>
> Personally, I think I'd be OK with the sysfs pinctrl map file only
> containing the map entries for devices that had used the pinctrl API,
> and hence only parsing the pinmux properties in pinmux_get().
>
> However, we could perhaps do better by registering a bus notifier, and
> pro-actively parsing the top-level DT node (if there is one) for every
> device that is created. That way, the mapping would be parsed as soon
> as the device was created (or perhaps after probe?).
>
After refer to usb bus notifier, usb core will register a bus notifier.
When a new usb bus is registered, it will notify the usb core for a
new bus added.

So i guess you mean pinctrl core provides a notifier to handle the map
creation when new map is found during parsing each device node, right?
But it seems parsing of device node and creation of device is at the very early
stage when call of_platform_populate in .init_machine code and pinctrl subsystem
may still have not change to run to register a bus notifier.
And i'm not sure it's the right place for of_platform.c to handle
pinmux things when create new devices.
I wonder it may not work for pinmux map case.
If pinctrl core does not provide notifier, who else can be the right
one to privide it?

> The only case this
> might not cover is DT nodes for which the kernel doesn't actually have
> a driver, and hence no device is created.
>
Per my understanding, the device creation should be independent on the driver.
I don't know why no device is created if not have a driver.
Did i miss something?

Regards
Dong Aisheng
