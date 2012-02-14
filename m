From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Feb 2012 02:03:15 +0000
Subject: [PATCH 13/15] ARM: make mach/io.h include optional
In-Reply-To: <20120213223653.GF25655@n2100.arm.linux.org.uk>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-14-git-send-email-robherring2@gmail.com>
 <20120213223653.GF25655@n2100.arm.linux.org.uk>
Message-ID: <201202140203.15360.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 February 2012, Russell King - ARM Linux wrote:
> On Mon, Feb 13, 2012 at 03:43:26PM -0600, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > Add a kconfig option NEED_MACH_IO_H to conditionally include mach/io.h.
> > 
> > Basing this on CONFIG_PCI and CONFIG_ISA doesn't quite work. Most ISA
> > platforms don't need mach/io.h, but ebsa110 does.
> 
> This is architecturally wrong.  If you have ISA, and your __io() macro
> is essentially a 1:1 translation, you're asking for ISA drivers to
> scribble on whatever is at virtual address 0-64K.  Too bad if that
> happens to be where your CPU vectors are stored, you'll lose control
> of the CPU in that case.

Right. I still think it should be conditional on PCI || ISA || PCMCIA,
not introducing a new kconfig symbol, and the next step should be to
unify the __io() implementations for the platforms that need them.

> So, I think this patch series moves things in the wrong direction.

I would very much like to see a lot of the series get merged as it
brings us closer to the single zimage, but I agree we have to be
careful not to add extra complexity (or bugs, for that matter).

	Arnd
