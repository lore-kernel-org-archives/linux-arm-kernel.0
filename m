From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Nov 2014 00:23:34 +0000
Subject: [PATCH] clk: Propagate prepare and enable when reparenting orphans
In-Reply-To: <CAD=FV=WCwGjuLNFPANqqq-+rEN_jhqi+Bfss2ugDJEgjf3z_Gg@mail.gmail.com>
References: <1415386312-23741-1-git-send-email-dianders@chromium.org>
 <20141107185844.GR4042@n2100.arm.linux.org.uk>
 <CAD=FV=WhWqMB=-ErD-59-z=y7OCZx4r7REkr3DpyYR=76SEJ6A@mail.gmail.com>
 <20141107233607.GS4042@n2100.arm.linux.org.uk>
 <CAD=FV=WCwGjuLNFPANqqq-+rEN_jhqi+Bfss2ugDJEgjf3z_Gg@mail.gmail.com>
Message-ID: <20141108002334.GT4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 04:14:23PM -0800, Doug Anderson wrote:
> Russell,
> I guess I'm still confused.  My patch continues to be about orphans
> and I don't see the bug you are pointing to.

Ah, in which case, the question changes: how can an orphaned clock be
succesfully prepared and enabled?

Drivers expect that a clock for which clk_enable() has returned
successfully _will_ at that point be supplying the clock.  If we don't
yet know it's parent, how do we know that it will be supplying that
clock?

What about a driver calling clk_set_rate() on an orphaned clock?

>From what I can see (__clk_reparent will re-set the child's clock when
reparenting) having a driver able to claim an orphaned clock, let
alone prepare and enable it, looks rather buggy to me.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
