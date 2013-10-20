From: arno@natisbad.org (Arnaud Ebalard)
Date: Sun, 20 Oct 2013 20:10:41 +0200
Subject: [REGRESSION?] sensors and fancontrol not seeing armada_thermal on
 3.12-rc series
Message-ID: <87ppqzolsu.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With 3.12-rc series, sysfs support for thermal susbsytem (and/or hwmon
one) was modified in such a way that sensors utility (current 3.3.4
version with 3.3.4 version of libsensors from lm-sensors package on
Debian unstable) does not see the temperature sensor anymore on armada
370 platforms (not tested on others). Additionally, the changes break
existing configurations of fancontrol utility, which prevents the 
fan to be regulated correctly w/o recreating an /etc/fancontrol w/
pwmconfig.

Here is what I have on my Armada 370-based system on a 3.11.5:

# sensors
g762-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:        2457 RPM  (div = 1)

armada_thermal-virtual-0
Adapter: Virtual device
temp1:        +45.7?C  

And what I get on 3.12-rc6:

# sensors
g762-i2c-0-3e
Adapter: mv64xxx_i2c adapter
fan1:        1350 RPM  (div = 1)


Monitoring what sensors does w/ strace, I started looking at the changes
to /sys/class/hwmon/hwmon1/:

On 3.11.5:

# find /sys/class/hwmon/hwmon1/
/sys/class/hwmon/hwmon1/
/sys/class/hwmon/hwmon1/name
/sys/class/hwmon/hwmon1/subsystem
/sys/class/hwmon/hwmon1/uevent
/sys/class/hwmon/hwmon1/temp1_input

On 3.12-rc6:

# find /sys/class/hwmon/hwmon1/
/sys/class/hwmon/hwmon1/
/sys/class/hwmon/hwmon1/name
/sys/class/hwmon/hwmon1/device
/sys/class/hwmon/hwmon1/subsystem
/sys/class/hwmon/hwmon1/uevent
/sys/class/hwmon/hwmon1/temp1_input

# find /sys/class/hwmon/hwmon1/device/
/sys/class/hwmon/hwmon1/device/
/sys/class/hwmon/hwmon1/device/temp
/sys/class/hwmon/hwmon1/device/type
/sys/class/hwmon/hwmon1/device/hwmon1
/sys/class/hwmon/hwmon1/device/hwmon1/name
/sys/class/hwmon/hwmon1/device/hwmon1/device
/sys/class/hwmon/hwmon1/device/hwmon1/subsystem
/sys/class/hwmon/hwmon1/device/hwmon1/uevent
/sys/class/hwmon/hwmon1/device/hwmon1/temp1_input
/sys/class/hwmon/hwmon1/device/subsystem
/sys/class/hwmon/hwmon1/device/policy
/sys/class/hwmon/hwmon1/device/uevent
/sys/class/hwmon/hwmon1/device/passive

Is that expected? As for sensors, it *seems* to be bothered to find a
device/ folder in /sys/class/hwmon/hwmon1/ w/o no name entry in it.

Cheers,

a+

ps: I can test if this is the same on kirkwood if there is a need.
