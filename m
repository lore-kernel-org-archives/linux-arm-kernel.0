From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 10 Jun 2016 10:56:33 +0100
Subject: [PATCH v2 4/9] arm64: Add platform selection for BCM2835.
In-Reply-To: <87h9d1x59s.fsf@eliezer.anholt.net>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-5-git-send-email-kraxel@redhat.com>
 <20160603112721.GC1128@e104818-lin.cambridge.arm.com>
 <87bn3gu3to.fsf@eliezer.anholt.net>
 <20160608091219.GA16322@e104818-lin.cambridge.arm.com>
 <87h9d1x59s.fsf@eliezer.anholt.net>
Message-ID: <20160610095633.GA14961@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 05:21:35PM -0700, Eric Anholt wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Sat, Jun 04, 2016 at 12:55:15PM -0700, Eric Anholt wrote:
> >> Catalin Marinas <catalin.marinas@arm.com> writes:
> >> > On Fri, Jun 03, 2016 at 08:18:23AM +0200, Gerd Hoffmann wrote:
> >> >> +	  This SoC is used in the Raspberry Pi 3 device.
> >> >
> >> > I thought we would just use ARCH_BCM, or is it too generic?
> >> 
> >> Consensus last time around seemed to be to drop adding ARCH_BCM, in
> >> favor of patch 1 of the series.
> >
> > I may have missed that discussion. My point was about consistency with
> > existing ARCH_* definitions in the arm64 Kconfig.platforms. I can see
> > why it's easier for you since some drivers are built based on
> > ARCH_BCM2835. Looking at drivers/clk/bcm/Makefile, there is an
> > inconsistent mix of CLK_BCM_* and ARCH_BCM_*. I would rather have a new
> > CLK_BCM2835 that's selected/enabled accordingly (maybe simply depending
> > on ARCH_BCM).
> 
> So I introduce a new ARCH_BCM here, that selects the just the 283x
> family's core drivers?  That seems strange, but I'm willing if that's
> what you want.

I'll leave this decision to the arm-soc guys. What I want to avoid is
another ARCH_BCM283[89] when some clock or other device changes in a
future revision of this board (RPi4?). I also don't want fine-grained
SoC configuration *within* the arch/arm64 Kconfigs but rather just a
family ARCH_* entry with selectable individual drivers based on the SoC
revision you target (in case you want to avoid single Image).

We should in general try to give drivers their own Kconfig entries
separate from ARCH_* ones (with a "depend on ARCH_*" and default y if
you want it enabled).

-- 
Catalin
