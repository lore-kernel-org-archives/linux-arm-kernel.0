From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 8 Jan 2015 13:11:05 +0200
Subject: [PATCH 2/2] ARM: DRA7xx: hwmod: set DSS submodule parent hwmods
In-Reply-To: <alpine.DEB.2.02.1501081000180.28771@utopia.booyaka.com>
References: <1418985914-9027-1-git-send-email-tomi.valkeinen@ti.com>
 <1418985914-9027-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1501022250010.27058@utopia.booyaka.com>
 <54AA68CF.9050904@ti.com>
 <alpine.DEB.2.02.1501081000180.28771@utopia.booyaka.com>
Message-ID: <54AE65C9.6080600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/15 12:15, Paul Walmsley wrote:

>> For DSS, the bit 0, DSS_DESHDCP_CLKEN is critical. While the bit is
>> rather undocumented, it presumably enables a clock for DSS's HDCP. Now,
>> we don't support HDPC in the display driver, but unfortunately the clock
>> is required for the DSS hardware to initialize.
> 
> Do you know where this DSS_DESHDCP clock appears in the clock tree?  Is it 
> downstream of the main DSS functional clock, or does it come from 
> somewhere else?

Unfortunately not. It is not mentioned in any documentation I can find.
OMAP5 has the exact same HDMI block, but it does not have this bit in
the control module.

There's this commit from Archit (who is no longer in TI) with some data,
but I cannot find any of it in the documentation:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/247993.html

Maybe OMAP5 has this clock always enabled, i.e. direct L3 clock without
the gate, and the bit was added to DRA7x to give the tiny bit of power
saving it might produce. This sounds quite likely scenario to me.

If so, it would not sound too bad to set the bit at boot time to make
the HW work like OMAP5, so that the SW could be the same. But then
again, I'm purely guessing.

> Sounds like the thing to do in the short term is to drop that patch from 
> the fixes series.  Then we can add it back when DSS_DESHDCP_CLKEN is 
> sorted.  Are you OK with that for the time being?

Yes, I think it's fine to drop it. While resetting the DSS at boot time
would be nice, I think in practice the only diff with this patch (if it
worked) and the current situation are the few hwmod warnings we get at
boot time.

However, I'm working on DRA7 display support for omapdss, and it won't
work if the DSS_DESHDCP_CLKEN is not enabled. So we need some kind of
solution pretty soon.

>> I don't have a good idea how to manage the bit properly. As far as I
>> see, the bit has to be managed via syscon, using remap_update_bits, so
>> that we get proper locking. With a quick glance, I didn't see anything
>> for that in the current clock code. And can we presume that syscon is
>> probed before hwmods? I guess not.
> 
> Based on the description so far, it sounds like there should be a system 
> control module driver that registers this clock, along with all of the 
> other clocks in the CTRL_CORE_CONTROL_IO_2 register.  Just shooting from 
> the hip here, I guess we'd probably list that DSS_DESHDCP_CLKEN clock as 
> an optional clock for DSS in the hwmod data, and add some code to indicate 
> that it should be enabled and disabled with the main_clk.

Hmm, ok. So a syscon driver, that registers this clock (and maybe some
others), and allows access to the non-clock bits via regmap, and handles
locking between the clock and non-clock accesses?

>> For the time being, I think the easiest solution would be to just set
>> the bit and leave it enabled. My understanding (based on commits in TI's
>> product kernel) is that leaving the DSS_DESHDCP_CLKEN enabled doesn't
>> really affect much, and any increased power consumption would be too
>> small to measure.
>>
>> If that's the route, the question is still where to enable it. As I
>> said, I have an u-boot which enables it, but I'd rather do the enabling
>> in the kernel. If in the kernel, where there? It has to happen before
>> the hwmod init is ran.
> 
> Yeah, that's a tricky question to answer.  If DSS_DESHDCP_CLKEN is modeled 
> as a clock, then it could be marked as ENABLE_ON_INIT, but that seems like 
> kind of a hack.

True, but the HW here also seems like a kind of hack =). Random bits
from various subsystems in the same register... sigh...

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/efa115b8/attachment-0001.sig>
