From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 24 Oct 2014 16:51:19 +0200
Subject: [PATCH 12/17] ARM: mvebu: Armada XP GP specific suspend/resume
 code
In-Reply-To: <20141024162824.67f9ce3d@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-13-git-send-email-thomas.petazzoni@free-electrons.com>
 <20141024142044.GB3142@lunn.ch>
 <20141024162824.67f9ce3d@free-electrons.com>
Message-ID: <20141024145119.GD3142@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 04:28:24PM +0200, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Fri, 24 Oct 2014 16:20:44 +0200, Andrew Lunn wrote:
> 
> > Does Marvell mandate this PIC and gpio interface? Or is a board
> > designer free to implement it some other way? It seems to me, this
> > should be considered specific to the Marvell reference design.
> 
> They don't mandate this interface, it's really a board-specific
> decision, which is why I've split my implementation between:
> 
>  * SoC-specific code, in mach-mvebu/pm.c.
> 
>  * Board-specific code, in mach-mvebu/pm-board.c.
> 
> > I'm wondering if this code should be a power driver, living in
> > drivers/power/reset/.
> 
> I'm fine with that, but have you seen the *very* tight interaction
> between the SoC-specific code and the board-specific code? The problem
> is that the board-specific code needs to put the SDRAM into
> self-refresh *right* before shutting down the SoC, and all that while
> making sure the code doing both of these operations remains in the
> I-Cache, and does not touch any other location in memory (which has
> become inaccessible due to being in self-refresh mode).
> 
> Look at the mvebu_armada_xp_gp_pm_enter() function: it takes two
> arguments, received from the SoC-level code. How to handle this thing
> with a driver in drivers/power/reset/ ?

It looks like reset drivers can register a notifier block, and you can
pass this notifier a void * parameter. So you should be able to pass
parameters. Nobody currently does this, so it might not work....

	    Andrew
