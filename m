From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 04 Sep 2013 10:43:28 -0700
Subject: [RFC Patch v2 0/3] add temporary parent migration support
In-Reply-To: <3927125.3UOplv4uU5@localhost>
References: <1378208072-10173-1-git-send-email-chander.kashyap@linaro.org>
 <3927125.3UOplv4uU5@localhost>
Message-ID: <20130904174328.10934.18433@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-09-03 15:36:50)
> Hi Chander,
> 
> On Tuesday 03 of September 2013 17:04:28 Chander Kashyap wrote:
> > Some platform has provision to change cpu parent clock during
> > cpu frequency scaling. This patch series provides a mechanism to
> > implement the same using CCF.
> > 
> > Patch1 provides mechanism to migrate to new parent temporarily.
> > 
> > Patch2 updates the user of clk_register_mux and DEFINE_CLK_MUX which are
> > modified to add support for clk migration.
> > 
> > Patch3 adds support to Exynos5250 to use the clock parent migration
> > feature implemented in CCF.
> 
> I don't really like this approach. A need to change mux setting 
> temporarily is heavily platform-specific and I don't think it should be 
> handled by generic code.

I agree with Tomasz.

> First of all there are many factor that you would 
> have to account for to make this solution generic, such as:
>  - board specific alternative parents,
>  - exact moment of parent change,
>  - some other platform specific conditions, like CPU voltage that must be 
> changed when mux is changed, because it changes CPU frequency,
>  - and probably a lot of more factors that only people working with all 
> the platforms supported (and unsupported yet) by Linux.
> 
> I can see at least two solutions for this problem that don't require 
> changing core code of common clock framework:
> 
> 1) Implementing a special clock type using normal mux ops, but also 
> registering a notifier for its PRE_RATE_CHANGE and POST_RATE_CHANGE events 
> to perform parent switching.

Creating a custom clock type is the way to go here. It is possible to
wrap the mux clk_ops to re-use that code, or just write a custom clock
type from scratch.

I do not like using the clock rate-change notifiers for this purpose.
The notifiers provide hooks to drivers that need to take care around
clock transitions. Using the notifiers from within the clock framework
indicates poor design.

> 
> 2) Using normal mux clock, but registering such notifiers in clock 
> controller or cpufreq driver.

This depends on what the data sheet or reference manual states. If using
a temporary parent is a property of the clock programming sequence (e.g.
to have a glitch-less transition) then that logic belongs in the clock
provider driver (i.e. a custom clock type needs to be created with this
logic).

However if using a temporary parent is not required for programming the
clock, but is instead a requirement of the clock consumer (e.g. a CPU,
or some I/O controller) then perhaps putting this logic in that driver
is the right way to go. In that case the logic could be explicit:

	clk_set_parent(clk, temp_parent);
	clk_set_rate(clk, target_rate);
	clk_set_parent(clk, target_parent);

Or it could implicit with the use of rate-change notifiers. Again the
rate-change notifiers exist for clock consumer drivers to use, so this
is OK.

I have a hunch that the right way to do this is for a custom clock type
to be created which simply calls clk_set_parent from within the clock's
.set_rate callback, but I'll wait on feedback from Chander on the needs
of his platform.

Regards,
Mike

> 
> Best regards,
> Tomasz
