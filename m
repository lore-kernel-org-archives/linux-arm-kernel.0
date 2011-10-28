From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 28 Oct 2011 11:18:51 -0400 (EDT)
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <4EAA63FA.8050506@stericsson.com>
Message-ID: <Pine.LNX.4.44L0.1110281051090.2175-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Oct 2011, Ulf Hansson wrote:

> The idea with having them as separate functions and something with 
> "runtime" in the name is because it is only when having 
> CONFIG_PM_RUNTIME the functions actually does something.

No, that's off the main point.

In fact, you're not really using these terms properly.  You shouldn't 
think of "runtime suspend" as a single verb -- that is, you shouldn't 
think "Okay, let's runtime-suspend this device now".

The verb is just "suspend", and it means the same thing as "put into a
low-power state".  The "runtime" part refers to _when_ the low-power 
transition takes place: while the rest of the system is running (as 
opposed to while the rest of the system is going to sleep).

Thus, it makes no sense at all for a comment in a suspend_noirq
callback to say "let's runtime-suspend the device".  That's a 
contradiction in terms.  The right way to think about it is more like 
this: "If the device isn't already in a low-power state, let's put it 
in a low-power state now".

In your case, the device already is (or should be) at low power.  A
better way to phrase this might be: "If the device's power hasn't
already been turned off, and the device doesn't need to generate wakeup
requests, turn off the power now".

Alan Stern
