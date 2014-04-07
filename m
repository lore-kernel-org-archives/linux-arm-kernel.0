From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Mon, 7 Apr 2014 09:54:23 +0200
Subject: [PATCH] Route keyboard LEDs through the generic LEDs layer.
In-Reply-To: <20140407021015.GA8518@core.coreip.homeip.net>
References: <20140331122323.GC6044@type.bordeaux.inria.fr>
 <20140407021015.GA8518@core.coreip.homeip.net>
Message-ID: <20140407075423.GZ7179@type.wlan.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Torokhov, le Sun 06 Apr 2014 19:10:15 -0700, a ?crit :
> On Mon, Mar 31, 2014 at 02:23:23PM +0200, Samuel Thibault wrote:
> > This permits to reassign keyboard LEDs to something else than keyboard "leds"
> > state, by adding keyboard led and modifier triggers connected to a series
> > of VT input LEDs, themselves connected to VT input triggers, which
> > per-input device LEDs use by default.  Userland can thus easily change the LED
> > behavior of (a priori) all input devices, or of particular input devices.
> > 
> 
> I still have the same concern that I believe I already mentioned a while
> ago: how do we reconcile the LED control via triggers with LED control
> done through event devices?

I don't remember that raised during the discussion.

> Currently, as far as I can see, they will be
> clashing with each other. I.e. if I remap my capslock led to be the new
> shiftlock and then userspace writes EV_LED/LED_CAPSL it would light up
> my new "shift lock", right?

Well, yes, sure, if you shoot in your foot it will hurt :) (although
here the damage is really small, it is just LED lighting or not).

I don't see why people would both tinker with such triggers and run
userland programs writing to evdev.  Of course it typically happens with
X, but that's not a problem in the usual case: kbd triggers are not
doing anything while on X, so X can play with evdev with no problem.
If the user puts e.g. a heartbeat on some LED and then runs X, the X
events will mix with the heartbeat.  The solution is for the user to
just disable the corresponding LED in the X keyboard configuration.
Do we really want to impose some overriding between VT-generated and
other application-generated events?  AIUI, we don't do this between
applications which would open the same evdev, so I don't see why we
should care more about the VT.

> Also I wonder if we really need to have the multiplexing (VT-level) leds
> in addition to per-device ones.

We do: we want to be able to easily remap all (current and future)
keyboards' LEDs easily.

My goal, at the beginning, was to be able to fix the console-setup
bug.  That was that console-setup wants to use, for the capslock key,
something else than the capslock mechanism hard-wired in the kernel,
so as to get way more fine-grain control over how caps is handled.
But then the capslock LED would not lit any more.  By remapping the
VT-level capslock led to the foo-lock used by console-setup, one gets
back capslock LEDs of all keyboards working back as expected by the
user.  I also use it for getting a group LED, just like I have on X,
to know which keyboard layout group I am in.  People using non-latin
layouts really need that.

Samuel
