From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 15:51:58 +0200
Subject: [PATCH 12/39] ARM: u300: set up board power from device tree
In-Reply-To: <CACRpkdYXfm4xzqn2Kb0fw2_+BSSXBoNXye2zu3fpv1sPQcHO9w@mail.gmail.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
 <6621177.ZgrPQ48FXE@wuerfel>
 <CACRpkdYXfm4xzqn2Kb0fw2_+BSSXBoNXye2zu3fpv1sPQcHO9w@mail.gmail.com>
Message-ID: <4270774.6CqcMSP3z0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 13:33:45 Linus Walleij wrote:
> Mark remarked on the first iteration that:
> 
> > I would expect this to be bound based on the board name that appears in
> > the device tree which (given the way this stuff mostly works) I'd expect
> > to have a device node available.
> 
> This is what I'm trying to do here.
> 
> The root node which actually contains the compatible-string
> for the board itself can *not* be used, as the OF platform core
> code does not create a platform device for this node, and it
> cannot reference anything either.
> 
> So a single board node directly in the root was the best
> I could come up with, other suggestions welcome...

I think I would actually put this into a machine_desc callback for a
machine that matches just this one board: If this is truly board
specific, this is where it belongs.

Of course we try to have a single machine_desc work with any board
normally, but the machine_desc is also the abstraction we already
have for boards. There is a device_node for '/', but as you say
there is no 'struct device' attached to it.

If it is not really a property of a particular board, but something
that you would need for other boards as well, it could perhaps
be tied to the syscon functionality, or to ab3100:

ab3100_regulators_probe() could itself set up the the supply
and then set the syscon bit. Basically you just move all of 
arch/arm/mach-u300/regulator.c into drivers/regulator/ab3100.c

	Arnd
