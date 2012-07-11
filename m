From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2012 16:18:46 +0100
Subject: [PATCH 1/9] ARM: vexpress: remove automatic errata workaround
 selection
In-Reply-To: <4FFD956D.7020901@gmail.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-2-git-send-email-pawel.moll@arm.com>
 <4FFD956D.7020901@gmail.com>
Message-ID: <20120711151846.GE13498@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 04:02:05PM +0100, Rob Herring wrote:
> On 07/11/2012 08:36 AM, Pawel Moll wrote:
> > From: Will Deacon <will.deacon@arm.com>
> > 
> > The vexpress Kconfig setup tries to be clever^Whelpful and selects some
> > errata workarounds for certain revisions of the Cortex-A9 and PL310,
> > which may be required depending on the coretile.
> > 
> > Since the mach-vexpress can support A5, A7 and A15 coretiles, let's
> > defer errata workaround selection to the user and instead propose
> > recommended workarounds in the defconfig. Note that the use of the
> > savedefconfig target removed some unrelated, redundant entries from the
> > file.
> 
> Most workarounds are runtime conditioned or don't have significant
> impact, so why not leave them enabled? For a single kernel image, we're
> going to have to basically turn on every errata work-around. Perhaps we
> should only have config options if they are not runtime enabled and have
> significant performance impact. I think having the settings in the
> defconfig is error prone, not mention if threats from Linus to remove
> all defconfigs actually happened it would be lost. In general, I don't
> think end users have enough information to determine what needs to be
> turned on. You need the errata list as well which is not public. Some of
> the errata help text says "rXpY and all later revisions" which changes
> when a new core revision comes out.

The problem I have with the current scheme for vexpress is that you can't
disable the workarounds when you know they are not needed. The Kconfig
*forces* them to be enabled -- that's certainly not right. Of the
workarounds in question, ARM_ERRATA_720789 is not runtime enabled and I
would like to deselect if when running on my A5, A7 or A15 cores. The
description clearly states it's an A9 erratum, so I don't think users will
have any difficulty knowing that they don't need it for other cores
(although I agree that it should be enabled for single zimage).

The defconfig changes were just a courtesy to reflect the change in the
Kconfig, I'm happy for them to be dropped.

Will
