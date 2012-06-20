From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Jun 2012 15:55:08 +0000
Subject: [PATCH] ARM: Orion5x - Restore parts of io.h
In-Reply-To: <20120620154617.GU4799@lunn.ch>
References: <1340172410-11229-1-git-send-email-andrew@lunn.ch>
 <201206201514.37618.arnd@arndb.de> <20120620154617.GU4799@lunn.ch>
Message-ID: <201206201555.09091.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 June 2012, Andrew Lunn wrote:
> > 
> > So if you need 1 MB per bus, why do you make the limit 4GB? Also,
> > the __io function does not actually point to the IO window at all,
> > which also appears to be horribly wrong.
> > 
> > My guess is that you actually want this to be
> > 
> > #define IO_SPACE_LIMIT SZ_2MB
> > #define __io(a)       ((void __iomem *)ORION5X_PCI_IO_VIRT_BASE + a)
> > 
> > Your patch otherwise would make the kernel build again, but has
> > no chance of doing the right thing.
> 
> My patch simply puts back what was removed. Please see:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=4d5fc58dbe34b78157c05b319669bb3e064ba8bd#patch20
> 
> It was probably broken before. It is probably broken now. It probably
> never did the right thing. However, we don't have any hardware to test
> with and we think it is probably never used in real life.
> 
> Is it worth doing more than putting back the original code?

Well, the broken version has significant side-effects, e.g. you cannot
access /dev/port or load a device driver that pokes at the PCI
I/O space without crashing the kernel. I think it's better to put
something in place that has a chance of working than something that
is known to be broken.

That said, we probably should not have done the change that broke
the kernel further than it was broken already: The assumption back
then was that we'd only remove the files that are known to be
incorrect, be we did not consider the side-effects.

Now that we're broken already, we have the choice between either
putting it back to the state it was in before, or trying to fix
it for real. Right now, I'm leaning towards fixing it because
there is still some time before the 3.5 release. If you can try
the version that I suggested above and verify that it fixes the
problem that was introduced in 4d5fc58dbe3, I'd prefer merging
that.

	Arnd
