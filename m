From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 15 Jun 2015 15:38:10 +0200
Subject: [PATCH v2 1/2] ARM: Add cpu_resume_arm() for firmwares that
 resume in ARM state
In-Reply-To: <20150615110136.GJ7557@n2100.arm.linux.org.uk>
References: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
 <1433272378-8470-2-git-send-email-sboyd@codeaurora.org>
 <20150615063324.GY18985@pengutronix.de>
 <20150615110136.GJ7557@n2100.arm.linux.org.uk>
Message-ID: <20150615133810.GA19996@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Mon, Jun 15, 2015 at 12:01:36PM +0100, Russell King - ARM Linux wrote:
> On Mon, Jun 15, 2015 at 08:33:25AM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > > +	.arm
> > > +ENTRY(cpu_resume_arm)
> > > + THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
> > > + THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
> > > + THUMB(	.thumb			)	@ switch to Thumb now.
> > > + THUMB(1:			)
> > >  ENTRY(cpu_resume)
> > >  ARM_BE8(setend be)			@ ensure we are in BE mode
> > >  #ifdef CONFIG_ARM_VIRT_EXT
> > this patch is in next as 51ac91b7f6b11b0da55ac93885ee7b864865bcb1 and
> > breaks efm32_defconfig. The exact error message is:
> > 
> >   AS      arch/arm/kernel/sleep.o
> > arch/arm/kernel/sleep.S: Assembler messages:
> > arch/arm/kernel/sleep.S:121: Error: selected processor does not support ARM opcodes
> > arch/arm/kernel/sleep.S:123: Error: bad instruction `badr r9,1f'
> > arch/arm/kernel/sleep.S:124: Error: attempt to use an ARM instruction on a Thumb-only processor -- `bx r9'
> > scripts/Makefile.build:294: recipe for target 'arch/arm/kernel/sleep.o' failed
> > make[3]: *** [arch/arm/kernel/sleep.o] Error 1
> 
> Don't get me wrong, the build testing which goes on is really great, but
> there's now a problem with all this.
> 
> There needs to be coordination between the people doing the build tests
> to ensure that we don't "tire out" those who read the emails with different
> groups of people reporting the same problem days after it was first
> discovered, and even worse, days after it's been fixed.
> 
> The worst thing to do is to report build regressions on Monday for a tree
> which was created on Thursday - by the time Monday comes around, projects
> such as the 0-day builder have had plenty of time to find them.
> 
> Remember, the linux-next tree which is published on Friday (Austrailian
> time) is a result of git trees snapshotted around midnight on Thursday.
> 
> So, if you're going to build an old linux-next tree, before you report any
> problems, please check whether other build systems have already reported
> them.  If you've gone to the trouble of tracking down the commit which
> caused it, and therefore the likely git tree, check whether a fix has
> already been merged.  Or maybe wait until the post-weekend linux-next is
> published...
> 
> (The problem you're referring to was fixed and pushed out on Friday -
> which seems to be a regular thing that happens with problems you've
> reported on Mondays...)
I consulted Google (asking for the commit id) and checked the
linux-arm-kernel list for reports which usually works well enough.

But I understand your complaint, last time I introduced a build
regression I got two automatic reports and three times the same fix into
my mailbox. So I will try to be more careful in the future.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
