From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 17 May 2014 10:23:37 +0100
Subject: [PATCH] ARM: remove ARM710 specific assembler code
In-Reply-To: <20140516125545.GO3693@n2100.arm.linux.org.uk>
References: <1364507176.1345.45.camel@x61.thuisdomein>
 <8309592.drxAj71PnZ@wuerfel> <1400059550.31197.12.camel@x220>
 <4305975.PvMXZQ020k@wuerfel> <1400232598.20342.16.camel@x220>
 <20140516125545.GO3693@n2100.arm.linux.org.uk>
Message-ID: <20140517092337.GA67711@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 01:55:46PM +0100, Russell King - ARM Linux wrote:
> There was a CPU called the ARM710, it was ARMv3 and it had no Thumb support.
> 
> There is also a CPU called the ARM710T, which is ARMv4 and has Thumb support.
> 
> These are two completely different CPUs, the former was removed along with
> the removal of ARMv3 support.  The latter remains because we still support
> ARMv4.

BTW, while clearly this patch was removing code for the wrong reasons, I
think we should set a longer term timeline for getting rid of some of
old features. Let's say in 10 years time we remove everything ARMv4,
another 10 years ARMv5 and so on. We could make these milestones shorter
but it really depends on what people use, we should not force them out
of the kernel if still in use.

We can start with ARM core and SoC code that we suspect people haven't
used in a while (or at least not with mainline). We should not remove
them straight away but give some advanced warning. My proposal is to add
a CONFIG_DEPRECATED option and update it with a 2 year cadence. Code
that we want to remove will depend on DEPRECATED and explicitly not
covered by defconfig. This way we can get interested parties sending
patches to remove the DEPRECATED dependency. Something like this:

config DEPRECATED
	bool "Enable deprecated kernel features"
	help
	  Kernel features no longer in use are marked as DEPRECATED for
	  two years and removed at the end of this period. This option
	  should only be enabled explicitly and must not be included in
	  defconfig files. If you think a DEPRECATED kernel feature is
	  still needed, please contact the corresponding maintainers to
	  remove the DEPRECATED dependency.

	  The next scheduled DEPRECATED code removal is planned for 2016.

It would be even better if we make such option across the whole kernel,
especially since we have significant ARM SoC code into drivers.
Otherwise calling it ARM_DEPRECATED would work as well.

-- 
Catalin
