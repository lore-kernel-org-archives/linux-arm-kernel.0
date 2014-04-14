From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 14 Apr 2014 14:28:29 +0200
Subject: [PATCH 20/29] ARM: orion5x: convert edmini_v2 to DT pinctrl
In-Reply-To: <20140414120648.GB20845@lunn.ch>
References: <1397400006-4315-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397400006-4315-21-git-send-email-thomas.petazzoni@free-electrons.com>
 <534BBDAC.2010801@gmail.com> <20140414132329.48df793e@skate>
 <534BC62D.6010000@gmail.com> <20140414120648.GB20845@lunn.ch>
Message-ID: <534BD46D.4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2014 02:06 PM, Andrew Lunn wrote:
> On Mon, Apr 14, 2014 at 01:27:41PM +0200, Sebastian Hesselbarth wrote:
>> On 04/14/2014 01:23 PM, Thomas Petazzoni wrote:
>>> Dear Sebastian Hesselbarth,
>>>
>>> On Mon, 14 Apr 2014 12:51:24 +0200, Sebastian Hesselbarth wrote:
>>>
>>>>>    		internal-regs {
>>>>> +			pinctrl at 10000 {
>>>>
>>>> Use node label reference:
>>>>
>>>> &pinctrl {
>>>> 	...
>>>> };
>>>
>>> I personally dislike using node label references. I know they are used
>>> for Ethernet because it has been done by someone else for Orion
>>> platforms. But on all Armada 370/XP platforms, we don't use node label
>>> references, and I'd prefer to do it the same way for Orion5x platforms
>>> if possible.
>>
>> Well, I definitely disagree and would like to _enforce_ using node
>> label references. Anyway, if there is a strong reason for not using
>> them, I'd be fine too.
>
> Could you both explain your like/dislike for using node labels.

My personal preferences are

(a) you cannot add any typos in nodes already existing, e.g.
     while copying serial at 11000 you have serial at 11100, or
     clock-frequency = <100000000>; becomes
     clock-frequency = <10000000>;.

(b) any mistake in toplevel includes gets multiplied by
     board dts files using the include.

Best example is kirkwood.dtsi which grew incrementally of
course. There are some issues with it and each of it is
replicated in up to ~40 board files.

For example, moving ocp at f1000000 for kirkwood will be a
real pain in the ass. Thomas can do it for orion5x.dtsi
because there is only one board using it, dove.dtsi was
already painful with only 3 boards.. but kirkwood.. don't
even think of it ;)

Also, I found two or three board files for kirkwood that
still have their pcie nodes sitting in ocp at f100000 because
we missed them when moving the nodes. With node label
references, this wouldn't be a problem at all.

The only drawback for node label references is, they have
to be known at dtc link time. I already mentioned it in
our internal mail, but if you have

kirkwood.dtsi
   +- kirkwood-6281.dtsi adds sata, sdio, ...
   +- kirkwood-6282.dtsi adds sata, sdio, ..., i2c1

You cannot have another set of dts[i] files doing

kirkwood-db.dtsi
   +- kirkwood-db-88f6281.dts
   +- kirkwood-db-88f6282.dts

with:

kirkwood-db.dtsi:
#include <kirkwood.dtsi>

&sdio {...};

because kirkwood.dtsi does not know about &sdio.

One way of solving this would be to include e.g.
kirkwood-6281.dtsi and overwrite what was added
in the corresponding board files again.

But again, this really is my personal preference.
If there are other good reasons not to do it, I'll agree.

Sebastian
