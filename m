From: trenn@suse.de (Thomas Renninger)
Date: Wed, 24 Oct 2012 02:40:49 +0200
Subject: [RFC] Energy/power monitoring within the kernel
In-Reply-To: <1351013449.9070.5.camel@hornet>
References: <1351013449.9070.5.camel@hornet>
Message-ID: <4317776.evLpJapyim@hammer82.arch.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday, October 23, 2012 06:30:49 PM Pawel Moll wrote:
> Greetings All,
> 
> More and more of people are getting interested in the subject of power
> (energy) consumption monitoring. We have some external tools like
> "battery simulators", energy probes etc., but some targets can measure
> their power usage on their own.
> 
> Traditionally such data should be exposed to the user via hwmon sysfs
> interface, and that's exactly what I did for "my" platform - I have
> a /sys/class/hwmon/hwmon*/device/energy*_input and this was good
> enough to draw pretty graphs in userspace. Everyone was happy...
> 
> Now I am getting new requests to do more with this data. In particular
> I'm asked how to add such information to ftrace/perf output.
Why? What is the gain?

Perf events can be triggered at any point in the kernel.
A cpufreq event is triggered when the frequency gets changed.
CPU idle events are triggered when the kernel requests to enter an idle state
or exits one.

When would you trigger a thermal or a power event?
There is the possibility of (critical) thermal limits.
But if I understand this correctly you want this for debugging and
I guess you have everything interesting one can do with temperature
values:
  - read the temperature
  - draw some nice graphs from the results

Hm, I guess I know what you want to do:
In your temperature/energy graph, you want to have some dots
when relevant HW states (frequency, sleep states,  DDR power,...)
changed. Then you are able to see the effects over a timeline.

So you have to bring the existing frequency/idle perf events together
with temperature readings

Cleanest solution could be to enhance the exisiting userspace apps
(pytimechart/perf timechart) and let them add another line
(temperature/energy), but the data would not come from perf, but
from sysfs/hwmon.
Not sure whether this works out with the timechart tools.
Anyway, this sounds like a userspace only problem.

   Thomas
