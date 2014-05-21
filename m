From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 21 May 2014 16:05:56 +0300
Subject: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
In-Reply-To: <20140519195100.GB11945@atomide.com>
References: <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com>
 <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com>
 <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com>
 <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com>
 <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com>
 <20140519195100.GB11945@atomide.com>
Message-ID: <537CA4B4.2040001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/05/14 22:51, Tony Lindgren wrote:

>>> 4. Having this hack limited to device tree based booting while we are
>>>    trying to unify the functions for drivers to use to get their
>>>    resources.
>>
>> I don't understand this one. With non-DT boot we don't have the issue at
>> all, there's no need for hacks.
> 
> Hmm can't we still have multiarch booting happening with the same
> panel name being used by two different display drivers?

Yes, but in that case the driver names are internal to kernel. You can
append "omapdss" or such to the driver name, and have that name used in
the board file and in the driver. It's not visible outside the kernel,
and when there's a common display framework, it can be changed without
anyone knowing.

With DT we have the old, stable .dts files that need to be supported...

>>> 5. Seeing the possibility of this spreading to other drivers.
>>
>> Well, until we have a common display framework, one of the hacky options
>> we've discussed will spread to other drivers if they need to have their
>> own drivers for the same hardware devices.
>>
>> Which is not nice, but not something we can escape. And using the
>> of_machine_is_compatible or having the compatible strings in .dts
>> appended with "dss" or such doesn't change that, it just changes which
>> hack may spread.
> 
> Yes I agree they are all hacks, but your version seems to carry some
> extra early init baggage with it as I noted above :)

True, but it doesn't feel very big baggage to me. We can bail out
immediately if the machine is not omap, so for non-omap's the effect
should be negligible.

For omap there is some extra stuff being done. I don't really know heavy
it is, performance wise, but the operation itself is quite small.

I'll try and see how the other options work, which are:

- Bailing out from module_init in each display driver. The reason I
don't like this (although I haven't tried it) is that all the display
drivers need the modification, and because I need to catch the
module_init, I cannot use the helpers like module_platform_driver(), so
it adds multiple lines to every driver.

- Traveling the video graph, starting from omapdss. This one is possibly
better performance-wise than my original version, as we only need to
search for the omapdss node and can then follow the links. But the code
will be more complex.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/5e27c4eb/attachment.sig>
