From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 15 Nov 2013 02:16:29 +0900
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <5284E236.1000606@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
 <5283DB34.9050301@gmail.com> <201311141332.58498.arnd@arndb.de>
 <CACxGe6uMWjfmB4WDKs+vu05224jqpbDZBHT_ZXnqxw17JzUqvw@mail.gmail.com>
 <5284E236.1000606@gmail.com>
Message-ID: <CACxGe6sgRwiakJLUCtaaQ2NF51PpkoNZvZr6EoE-BPeZiDsDFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 11:46 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 11/14/2013 07:33 AM, Grant Likely wrote:
>> On Thu, Nov 14, 2013 at 9:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wednesday 13 November 2013, Rob Herring wrote:
>>>> I'm not inclined to expand cpuinfo and prior attempts to add more info
>>>> to cpuinfo like SoC name have failed. The differences between x86 and
>>>> arm cpuinfo already cause issues for arm. lscpu does not really work on arm.
>>>
>>> Well, they turned into drivers/base/soc.c, which adds the information in
>>> a structured way in sysfs, but is only used on a couple of platforms.
>>>
>>>> I'd actually prefer If you really want more system info, then go read
>>>> /proc/device-tree.
>>
>> I really don't mind pulling that information out of /proc/cpuinfo. My
>> point is merely that it is incredibly useful to be able to easily find
>> out exactly which machine_desc got chosen on any given platform. I
>> don't think I should have to grep the source tree to figure that out.
>>
>> The kernel log is useful, but it is also helpful to have it in a /proc
>> or /sysfs file for when the kernel log overflows. /proc/device-tree
>> doesn't give that information.
>
> Either we want to shrink/remove machine_desc or we don't. If we do, then
> the name has to go at some point. So what is the reason to remove it
> later rather than sooner? Later means we will have "Generic DT based
> system" in cpuinfo as platforms transition. Perhaps that is useful to
> know in the short term, but once all platforms print the same thing the
> information becomes useless. Then we either remove Hardware field from
> cpuinfo or change to use DT info. That's changing the string twice
> rather than once.
>
> We probably have at least a dozen machine_desc's we are close to being
> able to remove (sunxi, picoxcell, highbank, dove, rockchip, virt,
> several sh-mobile). There's also more that probably can be combined
> together which will change the string in /proc/cpuinfo.
>
> If this is a required feature then we should make machine_desc common
> (or at least part of it) with the other arches that have copied arm and
> then add it to arm64 as well. Then I could do further consolidation of
> the FDT machine matching code. Otherwise this is all just pointless
> architecture variation that really has nothing to do with the architecture.

I think you are missing my point. go ahead, take it out of
/proc/cpuinfo. That's not the issue.

However, as long as there is more than one machine desc, the kernel
really needs to report which one was chosen because it reflects the
initialization path. Whether it's done with the .name field or some
other mechanism also doesn't matter either, but I really don't see a
reason to even bother removing .name. It is zero practical cost to
keep it. Removing it in an effort to shrink machine_desc is just silly
because it doesn't have any meaning outside of machine desc. It's the
other fields in that structure that require engineering work to
remove. .name can simply disappear naturally at the same time time
structure is deleted.

g.

>
> Rob
