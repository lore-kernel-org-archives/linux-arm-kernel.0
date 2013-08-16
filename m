From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 16 Aug 2013 13:41:25 +0100
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Clock DT bindings
In-Reply-To: <20130816040708.4443.26655@quantum>
References: <520D9788.5080805@codeaurora.org>
 <20130816040708.4443.26655@quantum>
Message-ID: <520E1DF5.4030409@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/13 05:07, Mike Turquette wrote:
> Quoting Saravana Kannan (2013-08-15 20:07:52)
>> You asked for specific topics. So, here's one:
>>
>> Clock DT bindings discussion on:
>> * Allowing producers to export clocks by names.
>> * Allowing consumers to list clocks by "producer phandle, clock name".
>> * Should we allow for -clock magic similar to regulators?
>> * Should the entire clock tree be represented in DT.
>>
>> I would like to attend the ARM summit to represent the needs of SoCs 
>> with complicated clocking HW. I have worked on clocks for about 5 years 
>> (since MSM started running Linux) and would like to throw in my opinion 
>> on what clock DT bindings would work well, why and help come up with a 
>> solution that works well for everyone.

I'd also be interested in attending discussions about Clocks and DT
(among other things - I'm the Meta architecture (arch/metag) maintainer,
and will find myself increasingly working on MIPS and KVM).

I've worked on supporting the Meta based TZ1090 SoC, which has clock
layout entirely represented in DT, but hit difficulties with where to
put clock configuration/policy data that doesn't describe the hardware
itself.

This is a general problem that I think needs discussion. Basically some
other data is sometimes required that:
* doesn't describe the hardware - therefore it cannot live in device tree.
* is platform specific - so doesn't really live in the clock drivers
themselves (and there's resistance to having any platform setup code in
new arches like Meta).
* is application specific, perhaps depending on what has been started on
other non-Linux processor cores in the SoC, or on what the bootloader
has configured, or perhaps some arbitrary constraint to workaround a
hardware bug - so doesn't really live in platform setup code anyway.

A couple of more concrete examples:
* Prevent a clock from being remuxed or changed (or force it to use a
specific parent). For whatever reason it is sometimes desired that a
particular clock uses a particular parent or cannot be remuxed. E.g.
firmware on a non-Linux core might be driving a peripheral which shares
the clock and doesn't want the clock rate to change under it's feet, or
perhaps the use of a particular clock causes instability in certain
devices, or perhaps it's a critical clock (that the core CPU or DDR
clock is derived from).
* Disable certain devices. If firmware on other non-Linux cores are
driving certain devices (e.g. one of the SPI or I2C buses that a radio
tuner is connected to), then you want status="disabled" on that device
to prevent Linux trying to drive it at the same time, but technically
there's nothing preventing Linux from driving it if it wasn't already in
use.

The automatic clock reparenting patchset I wrote helps with some cases
where the best/correct clock to use can be determined dynamically, but
that doesn't cover all cases.

I've heard Mike refer to a hypothetical configtree (which I think is the
idea of passing a tree of config data similar to device tree, either in
addition to or somehow merged with the device tree), but at the moment
in our kernel tree we work around these by putting that data directly in
device tree.

Have others hit similar difficulties?

Is some kind of configtree the right solution or are there other
preferred solutions?

I'm attending ELCE so should be able to be around.

Cheers
James

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130816/fd733f17/attachment.sig>
