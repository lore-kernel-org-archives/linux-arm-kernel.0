From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Mar 2014 13:04:57 +0100
Subject: [PATCH 60/62] ARM: shmobile: work around CONFIG_PHYLIB=m
In-Reply-To: <20140324013556.GF23924@verge.net.au>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <201403211643.24533.arnd@arndb.de> <20140324013556.GF23924@verge.net.au>
Message-ID: <14100654.IXZcGSFRJS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 March 2014 10:35:56 Simon Horman wrote:
> On Fri, Mar 21, 2014 at 04:43:24PM +0100, Arnd Bergmann wrote:
> > On Thursday 20 March 2014, Simon Horman wrote:
> > > I wonder if Kconfig for koelsch should be tightened up somehow to
> > > ensure that PHYLIB is either unselected or builtin.
> > > 
> > > Also, a minor nit, I would prefer changes for different boards
> > > in different patches. But I can split the patch myself if its
> > > not going to be changed otherwise.
> > 
> > I would prefer to take the entire series directly into arm-soc
> > this time, if you don't mind.
> 
> That I'm happy to go along with though I don't understand the motivation
> for it. And regardless of how the patches go in I'd prefer if they were
> split as I suggested above.

Sorry, I misunderstood you at first. I thought you meant you only split
them up when you apply them yourself. It's no problem for me to split
up this patch as well and then apply it here.

> What I'm not so happy about is us potentially moving a problem from being a
> compile time error, which is easy to observe, to a run-time behavioural
> problem, which may be much less obvious to the beholder.

I agree that it's not nice, but I couldn't come with a better approach,
and we are doing the same thing on other platforms as well.

The problems are:

* leaving the code as it is today prevents me from running all
  'make randconfig' kernels successfully. I use this as an important
  test case for verifying stuff we pull into the arm-soc tree.
  At the moment, I have a 160-patch series that I want to get merged
  upstream over time.

* Using 'select PHYLIB' from the platform is nasty because we want
  to be able to turn off whole subsystems (BLOCK, NET, I2C, ...)
  in Kconfig independent of the board selection. PHYLIB requires
  the network code.

* Using 'depends on' to disable the board option if PHYLIB is
  a module is counterintuitive.

* Makeing PHYLIB always built-in when NETDEVICE is would be a
  bit wasteful.

I don't have any other ideas for solving this.

	Arnd
