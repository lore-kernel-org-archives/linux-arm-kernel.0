From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 5 Nov 2013 11:44:17 -0600
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <CAL_Jsq+hO_euGM4eBtpeFUaQdo5rDgmyD0HaU0GEHN=S27f0Vg@mail.gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CACxGe6sMXjcsGNEiGQ923_yEKXwaAj_qfqZQPpXqHgh1znsF0Q@mail.gmail.com>
 <CAL_Jsq+hO_euGM4eBtpeFUaQdo5rDgmyD0HaU0GEHN=S27f0Vg@mail.gmail.com>
Message-ID: <CAHCPf3uGnz3iYZYnvH=JwkzKCLx19o-kyRc3H=YeESg_dTLOWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 5, 2013 at 8:34 AM, Rob Herring <robherring2@gmail.com> wrote:
> On Mon, Nov 4, 2013 at 5:36 AM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Sun, Nov 3, 2013 at 8:50 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> From: Rob Herring <rob.herring@calxeda.com>
>>>
>>> As part of the effort to ultimately remove struct machine_desc, the
>>> machine name is not really needed. It is only used for /proc/cpuinfo
>>> "Hardware" field. Get this information from the DT instead and remove
>>> the name string in the machine descriptor for DT machine descriptors. The
>>> model or machine compatible property from the DT is used instead.
>>
>> I've obviously missed some discussions because I wasn't aware of the
>> plan to remove machine_desc. That's neither here not there, but for as
>> long as the structure still exists it is really useful to discover
>> which machine_desc the kernel chooses at boot time. If you're going to
>> remove this, then at the very least I would embed the filename or
>> something similar into the machine desc so it is available for
>> debugging. It can go away when the structure is removed.
>
> It's a very long term goal to remove it completely, but it is now
> optional for "simple" platforms with the default machine_desc and
> default init ptrs. You might want to look at the patches and the WIP
> branch I posted[1] which removes the machine_desc for highbank.
> There's some core boilerplate I'd like your opinion on. Also, I'm sure
> you are aware of the resistance to add a machine_desc to arm64, so I'm
> looking at this from that perspective as well. I'm sure there will be
> platforms which look very similar across arm and arm64.
>
> On boot, the model or compatible string from the DTB is printed out

So in the case of a DTS for a generic, get-started-here board with no
"external" features, you might see "fsl,imx53" as your board name?

> (that change is actually in my DT arch clean-up series, not this
> patch). This has made what is printed out on boot consistent across
> arches using DT. There is no good reason for this to be arch specific.
> Presumably the compatible string is unique

Not necessarily. Most compatible strings in the root node have more
than one string (fsl,imx51-babbage, fsl,imx51) - which do you print?
First? Both/All? Without the model property it's not completely
deterministic (since it's externally provided data, no matter what)
and I don't see code that brings out more than one.

Essentially meaning for anything that never had or never will have a
true model property, something a little more relevant (and entirely
deterministic per-SoC) ends up in the device property.

I really like the idea of ditching machine_desc, but this is one place
where probably init code for the board is the place to parse (and
stuff in) the board name to some global structure.

BTW with the of matching patch, what REALLY guarantees ordering of
these calls, for instance how does it replace map_io, init_irq, etc.?
Highbank seems a special case where it basically didn't need or do any
of this so it's not affected by it going away. What I'm trying to
understand is what replaces those hooks, because I'd like to throw
this into i.MX and see what happens, but I'm not sure what the
eventual goal is. Nonetheless I like the theme;

Acked-by: Matt Sealey <neko@bakuhatsu.net>

-- 
Matt Sealey <neko@bakuhatsu.net>
