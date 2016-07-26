From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 08:32:53 +0200
Subject: [PATCH v2 06/14] ARM: sun8i: clk: Add clk-factor rate
 application method
In-Reply-To: <c46d1af5-9410-402a-7144-48b396ef6da7@megous.com>
References: <20160625034511.7966-1-megous@megous.com>
 <20160625034511.7966-7-megous@megous.com>
 <20160630204001.GC5485@lukather>
 <0b71ed7e-98c9-109e-85e6-ceb95131d88a@megous.com>
 <20160715085356.GR4761@lukather>
 <085e185a-ac76-dd3f-9b0e-a7dc9c0c09f3@megous.com>
 <20160721094852.GI5993@lukather>
 <c46d1af5-9410-402a-7144-48b396ef6da7@megous.com>
Message-ID: <20160726063253.GW7419@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 11:52:15AM +0200, Ond?ej Jirman wrote:
> >>> If so, then yes, trying to switch to the 24MHz oscillator before
> >>> applying the factors, and then switching back when the PLL is stable
> >>> would be a nice solution.
> >>>
> >>> I just checked, and all the SoCs we've had so far have that
> >>> possibility, so if it works, for now, I'd like to stick to that.
> >>
> >> It would need to be tested. U-boot does the change only once, while the
> >> kernel would be doing it all the time and between various frequencies
> >> and PLL settings. So the issues may show up with this solution too.
> > 
> > That would have the benefit of being quite easy to document, not be a
> > huge amount of code and it would work on all the CPUs PLLs we have so
> > far, so still, a pretty big win. If it doesn't, of course, we don't
> > really have the choice.
> 
> It's probably more code though. It has to access different register from
> the one that is already defined in dts, which would add a lot of code
> and require dts changes. The original patch I sent is simpler than that.

Why?

You can use container_of to retrieve the parent structure of the clock
notifier, and then you get a ccu_common structure pointer, with the
CCU base address, the clock register, its lock, etc.

Look at what is done in drivers/clk/meson/clk-cpu.c. It's like 20 LoC.

I don't really get why anything should be changed in the DT, or why it
would add a lot of code. Or maybe we're not talking about the same
thing?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/fe36e315/attachment-0001.sig>
