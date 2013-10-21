From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 20 Oct 2013 22:19:10 -0700
Subject: [REGRESSION?] sensors and fancontrol not seeing armada_thermal
 on 3.12-rc series
In-Reply-To: <1382322502.2410.12.camel@rzhang1-mobl4>
References: <87ppqzolsu.fsf@natisbad.org> <52642DAF.8080301@roeck-us.net>
 <1382322502.2410.12.camel@rzhang1-mobl4>
Message-ID: <5264B94E.9090805@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2013 07:28 PM, Zhang Rui wrote:
> Hi,
>
> On Sun, 2013-10-20 at 12:23 -0700, Guenter Roeck wrote:
>> On 10/20/2013 11:10 AM, Arnaud Ebalard wrote:
>>> Hi,
>>>
>>> With 3.12-rc series, sysfs support for thermal susbsytem (and/or hwmon
>>> one) was modified in such a way that sensors utility (current 3.3.4
>>> version with 3.3.4 version of libsensors from lm-sensors package on
>>> Debian unstable) does not see the temperature sensor anymore on armada
>>> 370 platforms (not tested on others). Additionally, the changes break
>>> existing configurations of fancontrol utility, which prevents the
>>> fan to be regulated correctly w/o recreating an /etc/fancontrol w/
>>> pwmconfig.
>>>
>>> Here is what I have on my Armada 370-based system on a 3.11.5:
>>>
>>> # sensors
>>> g762-i2c-0-3e
>>> Adapter: mv64xxx_i2c adapter
>>> fan1:        2457 RPM  (div = 1)
>>>
>>> armada_thermal-virtual-0
>>> Adapter: Virtual device
>>> temp1:        +45.7?C
>>>
>>> And what I get on 3.12-rc6:
>>>
>>> # sensors
>>> g762-i2c-0-3e
>>> Adapter: mv64xxx_i2c adapter
>>> fan1:        1350 RPM  (div = 1)
>>>
>>>
>>> Monitoring what sensors does w/ strace, I started looking at the changes
>>> to /sys/class/hwmon/hwmon1/:
>>>
>>> On 3.11.5:
>>>
>>> # find /sys/class/hwmon/hwmon1/
>>> /sys/class/hwmon/hwmon1/
>>> /sys/class/hwmon/hwmon1/name
>>> /sys/class/hwmon/hwmon1/subsystem
>>> /sys/class/hwmon/hwmon1/uevent
>>> /sys/class/hwmon/hwmon1/temp1_input
>>>
>>> On 3.12-rc6:
>>>
>>> # find /sys/class/hwmon/hwmon1/
>>> /sys/class/hwmon/hwmon1/
>>> /sys/class/hwmon/hwmon1/name
>>> /sys/class/hwmon/hwmon1/device
>>> /sys/class/hwmon/hwmon1/subsystem
>>> /sys/class/hwmon/hwmon1/uevent
>>> /sys/class/hwmon/hwmon1/temp1_input
>>>
>>> # find /sys/class/hwmon/hwmon1/device/
>>> /sys/class/hwmon/hwmon1/device/
>>> /sys/class/hwmon/hwmon1/device/temp
>>> /sys/class/hwmon/hwmon1/device/type
>>> /sys/class/hwmon/hwmon1/device/hwmon1
>>> /sys/class/hwmon/hwmon1/device/hwmon1/name
>>> /sys/class/hwmon/hwmon1/device/hwmon1/device
>>> /sys/class/hwmon/hwmon1/device/hwmon1/subsystem
>>> /sys/class/hwmon/hwmon1/device/hwmon1/uevent
>>> /sys/class/hwmon/hwmon1/device/hwmon1/temp1_input
>>> /sys/class/hwmon/hwmon1/device/subsystem
>>> /sys/class/hwmon/hwmon1/device/policy
>>> /sys/class/hwmon/hwmon1/device/uevent
>>> /sys/class/hwmon/hwmon1/device/passive
>>>
>>> Is that expected? As for sensors, it *seems* to be bothered to find a
>>> device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.
>>>
>
> I agree. And it should be caused by this commit.
>
> commit b82715fdd4a5407f56853b24d387d484dd9c3b5b
> Author: Eduardo Valentin <eduardo.valentin@ti.com>
> Date:   Fri Aug 23 17:07:58 2013 -0400
>
>      drivers: thermal: parent virtual hwmon with thermal zone
>
>      When  creating virtual hwmon devices based out of thermal
>      zone devices, the virtual devices won't have parents.
>
>      This patch changes the code so that the parent of virtual
>      hwmon devices is the thermal zone device that they are
>      based of.
>
>      Cc: Zhang Rui <rui.zhang@intel.com>
>      Cc: linux-pm at vger.kernel.org
>      Cc: linux-kernel at vger.kernel.org
>      Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>
>>
>> The 'name' attribute should not be the problem, since there is a 'name'
>> attribute in the /sys/class/hwmon/hwmon1/ directory.
>>
>> Key difference is that there is now a 'device' subdirectory,
>
> Right.
>
>>   which results
>> in different handling by libsensors;
> Oh, I'm not aware of this before.
> There is no such statement in the comments of hwmon_device_register(),
> or anywhere else.
> Could you show me some tutorials about how the sysfs I/F misleads
> libsensors?
>

I looked into the libsensors source code. I don't think there is a tutorial,
or at least I am not aware of one.

Still, I don't entirely understand how the above commit results in what seems
to be recursive parents (or, from looking into the code, how that happens in
the first place).

Guenter

> But anyway, I will revert this patch first.
> Thanks for reporting the problem, Arnaud!
>
> thanks,
> rui
>>   the entry is no longer a virtual entry
>> but is expected to have a real device attached to it. For this device,
>> libsensors tries to scan the 'subsystem' entry which in turn must be well
>> defined and known. My suspicion is that the reported subsystem may not be
>> recognized by libsensors.
>
>>
>> One question is why there is now a device entry, even though this is still as
>> virtual as it was before. You'll have to ask the thermal subsystem maintainers
>> for an answer.
>
>> I am also concerned about the 'hwmon1' subdirectory underneath hwmon1/device;
>> that suggests that hwmon1 may be declared to be a child of itself, which would
>> obviously not be a good idea.
>>
>> Also, note that the thermal subsystem creates (or may create) sensor attributes
>> after registering the hwmon device, which means you can not rely on the udev
>> event that comes with the hwmon device creation and assume that all sensor
>> attributes exist at that time. I don't currently know how to handle this situation.
>> This is not unique, though; the coretemp driver does the same. Just something
>> to keep in mind.
>>
>> Guenter
>>
>
>
>
>
