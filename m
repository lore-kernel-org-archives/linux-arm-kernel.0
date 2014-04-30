From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 30 Apr 2014 23:25:35 +0200
Subject: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM
 with the PM core
In-Reply-To: <20140429131610.29859C4094A@trevor.secretlab.ca>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <7hoazpdldx.fsf@paris.lan> <20140429131610.29859C4094A@trevor.secretlab.ca>
Message-ID: <2401458.kIFL7AxWq0@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 14:16:10 Grant Likely wrote:
> On Fri, 25 Apr 2014 16:44:58 -0700, Kevin Hilman <khilman@linaro.org> wrote:
> > Geert Uytterhoeven <geert+renesas@glider.be> writes:
> > > When adding a device from DT, check if its clocks are suitable for
> > > Runtime PM, and register them with the PM core.
> > > If Runtime PM is disabled, just enable the clock.
> > > 
> > > This allows the PM core to automatically manage gate clocks of devices
> > > for Runtime PM.
> > 
> > ...unless the device is already in an existing pm_domain, right?
> > 
> > I like this approach, and it extends nicely what we already do on
> > platforms using drivers/base/power/clock_ops.c into DT land.
> > 
> > My only concern is how this will interact if it's used along with
> > devices that have existing pm_domains.  I don't have any specific
> > concerns (yet, because it's Friday, and my brain is turing off), but it
> > just made me wonder if this will be potentially confusing.
> 
> I have big concerns about this approach. First, it will only work if
> a clock is available at deivce creation time. The conversion of irq
> controllers to normal device drivers has already shown that is a bad
> idea.
> 
> I also don't like that it tries to set up every clock, but there is no
> guarantee that the driver will even use it. I would rather see this
> behaviour linked into the function that obtains the clock at driver
> .probe() time. That way it can handle deferred probe correctly and it
> only sets up clocks that are actually used by the driver.

I like the idea, as it gives an opt-in approach to the problem: drivers could 
decide whether they want the runtime PM core to handle clocks automatically 
(which should cover most cases), but would have the option of handling clocks 
manually if needed for special purposes.

-- 
Regards,

Laurent Pinchart
