From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 01 Dec 2014 15:07:15 +0000
Subject: [RFC V1 0/8] CPUFreq: create platform-dev for DT based cpufreq
 drivers
In-Reply-To: <23115535.r6kXsReHU2@wuerfel>
References: <cover.1417433163.git.viresh.kumar@linaro.org>
 <CAKohpo=EPOH-WJ4mmAr-1BzzAEpvC-F0Y99Ox_yL7meUcRNx6Q@mail.gmail.com>
 <547C6E9D.2090205@arm.com> <23115535.r6kXsReHU2@wuerfel>
Message-ID: <547C8423.2090300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/12/14 14:11, Arnd Bergmann wrote:
> On Monday 01 December 2014 13:35:25 Sudeep Holla wrote:
>> On 01/12/14 13:29, Viresh Kumar wrote:
>>> On 1 December 2014 at 18:24, Arnd Bergmann <arnd@arndb.de> wrote:
>>>> Thanks a lot for working on this, we really need to figure it out one day!
>>>
>>>
>>>
>>>> Your patches seem well-implemented, so if everybody thinks the general
>>>> approach is the best solution, we should do that. From my point of view,
>>>> there are two things I would do differently:
>>>>
>>>> - In the DT binding, I would strongly prefer anything but the root compatible
>>>>     property as the key for the new platforms. Clearly we have to keep using
>>>>     it for the backwards-compatibility case, as you do, but I think there
>>>>     are more appropriate places to put it. Sorting from most favorite to least
>>>>     favorite, my list would be:
>>>>           1. a new property in /cpus/
>>>>           2. a new property each /cpus/cpu at ... node.
>>>
>>> I did it this way earlier and named it dvfs-method but probably putting this
>>> into the /cpus/ node is far better. But then Sudeep asked to utilize
>>> compatible property only..
>>>
>>> Are you fine with the name here? "dvfs-method"
>>>
>>
>> That's right, I don't like driver specific method in the cpu node as you
>> initially did. But if it's a property in the chosen node (where we
>> usually put the Linux specific properties), I am fine with
>> that as Arnd has illustrated in his patch.
>
> I would prefer the /cpus node over the /chosen node because the former
> describes the hardware while the latter is supposed to be user-settable
> (on real open-firmware at least). But I think either one is better than
> using the / node compatible string.
>

Agreed, the main reason for objection was that in the initial proposal
it was more a Linux configuration rather than hardware property.

<dvfs-method> = "cpufreq-dt";

I don't see anything hardware feature presented with that. On the other
hand, we could represent the some thing like whether the cpu share
clock or are they independently clocked as a hardware property in the
cpu nodes.

> How about a "linux,cpu-dvfs-method" property in the root node? Would
> that work better for you than a "linux,dvfs-method" in the "/cpus"
> node?
>

I will leave that to the DT maintainers for specific details though
my preference is still chosen node as it's more related to Linux and
it's driver choice and unlikely to be used by other OSes. IMO we just
need single entry in the DT, so I am fine with either of your choice above.

Regards,
Sudeep
