From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 13 Apr 2016 17:42:23 -0700
Subject: [PATCH 3/6] ARM: PSCI: Register with kernel restart handler
In-Reply-To: <CAMuHMdU+vj4HDTLdXngUsTjF-Ki-HtbhoRU6mV7UKCz-BhFAtQ@mail.gmail.com>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-4-git-send-email-linux@roeck-us.net>
 <20160413110519.GE32018@leverpostej>
 <570E4550.5000207@roeck-us.net>
 <CAMuHMdU+vj4HDTLdXngUsTjF-Ki-HtbhoRU6mV7UKCz-BhFAtQ@mail.gmail.com>
Message-ID: <20160414004223.GA18564@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 03:22:44PM +0200, Geert Uytterhoeven wrote:
> On Wed, Apr 13, 2016 at 3:10 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On 04/13/2016 04:05 AM, Mark Rutland wrote:
> >> On Fri, Apr 08, 2016 at 05:53:56AM -0700, Guenter Roeck wrote:
> >>>
> >>> Register with kernel restart handler instead of setting arm_pm_restart
> >>> directly. This enables support for replacing the PSCI restart handler
> >>> with a different handler if necessary for a specific board.
> >>>
> >>> Select a priority of 129 to indicate a higher than default priority, but
> >>> keep it as low as possible since PSCI reset is known to fail on some
> >>> boards.
> >>
> >> For reference, which boards?
> >>
> > Salvator-X, reported by Geert Uytterhoeven. Wolfram Sang also reported
> > that it is broken on a board he is using, but I don't recall if it is
> > the same board.
> 
> Yes it is.
> 
> >> It's unfortunate that that a PSCI 0.2+ implementation would be lacking a
> >> working SYSTEM_RESET implementation, and it's certainly a mistake to
> >> discourage.
> >>
> >>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>> ---
> >>> It might make sense to introduce a restart-priority property for
> >>> devicetree
> >>> based configurations, but I am not sure if this would be acceptable.
> >>
> >>> From the DT side, I'm not keen on properties for priorities. They're
> >> incredibly fragile and don't really encode a HW property.
> >>
> > Depends. It is a convenient means to say "primary restart method" or
> > "may be broken".
> 
> The issue is supposed to be fixed in a more recent firmware, which I still have
> to try.
> 
> DT indeed isn't the right place to work around this. What we need is a
> blacklist of bad firmware versions...
> Or Perfect Firmware from Day One on (like Perfect DT from Day One ;-)
> 
That makes things quite tricky. Best I can think of is a series of boolean
devicetree properties, such as

	broken-reset-handler
	last-resort-restart-handler
	secondary-restart-handler
	default-restart-handler
	primary-restart-handler

which ends up being quite similar to the 'restart-priority' property. I'll
do this as follow-up patch, though - I do not see the point holding up the
series for this, and it is really a separate problem. I'll send rev2 with
the various Acked-by: and Reviewed-by: tags as well as the variable rename
suggested by Wolfram.

Thanks,
Guenter
