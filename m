From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 27 Oct 2014 13:51:29 +0100
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141024145119.GD3142@lunn.ch>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
 <20141024145119.GD3142@lunn.ch>
Message-ID: <20141027135129.292bd882@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Fri, 24 Oct 2014 16:51:19 +0200, Andrew Lunn wrote:

> > > I'm wondering if this code should be a power driver, living in
> > > drivers/power/reset/.
> > 
> > I'm fine with that, but have you seen the *very* tight interaction
> > between the SoC-specific code and the board-specific code? The problem
> > is that the board-specific code needs to put the SDRAM into
> > self-refresh *right* before shutting down the SoC, and all that while
> > making sure the code doing both of these operations remains in the
> > I-Cache, and does not touch any other location in memory (which has
> > become inaccessible due to being in self-refresh mode).
> > 
> > Look at the mvebu_armada_xp_gp_pm_enter() function: it takes two
> > arguments, received from the SoC-level code. How to handle this thing
> > with a driver in drivers/power/reset/ ?
> 
> It looks like reset drivers can register a notifier block, and you can
> pass this notifier a void * parameter. So you should be able to pass
> parameters. Nobody currently does this, so it might not work....

I had a closer look, but I'm sorry, I don't really see how
drivers/power/reset can help here. In drivers/power/reset, there are
only drivers that handle powering off a platform, or rebooting a
platform. They hook up by setting a value to the pm_power_off and/or
arm_pm_restart function pointers.

But in my case, what's needed is neither a power off nor a reboot, but
an entry to suspend to RAM, which is a different state. I don't see how
the drivers/power/reset driver would get "called" by the suspend/resume
procedure.

I also don't see how notifiers can help here. On which notification
would the drivers/power/reset driver register itself? By creating a new
notification type, specific to the mvebu platform?

I'm fine with reworking the implementation I've proposed, but if you
could shed some more light on what your proposal would look like, it
would be useful, as I currently don't see how drivers/power/reset fits
the need of the Armada XP suspend/resume mechanism.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
