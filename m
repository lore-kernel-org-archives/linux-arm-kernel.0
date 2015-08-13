From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 Aug 2015 15:24:44 +0100
Subject: [GIT PULL] ARM64: juno: SCPI and dependent drivers for v4.3
In-Reply-To: <20150813124026.GD23581@localhost>
References: <55C1E3FB.5090309@arm.com>
 <20150813124026.GD23581@localhost>
Message-ID: <20150813142444.GA4602@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 13, 2015 at 02:40:26PM +0200, Olof Johansson wrote:
> On Wed, Aug 05, 2015 at 11:22:51AM +0100, Sudeep Holla wrote:
> > Here is the first pull request for SCPI, clock and cpufreq support on
> > ARM64 Juno development platform for v4.3
> 
> I'd like to hear from Catalin and Will on why ARM is doing this. Catalin
> and Will are pushing back very hard at vendors who don't use PSCI for
> CPU power management, and then they have coworkers that are looking to
> merge this directly into the kernel.

Actually, the arm64 CPU power management story is pretty much handled by
Lorenzo and Sudeep in my team, so I trust their judgement ;). But I
agree with you that a better explanation on the reasons behind this is
needed, otherwise we risk confusing messages. I'll try to summarise it
below but Sudeep can reply with more details.

PSCI only covers CPU boot/cpuidle and platform suspend. It does not have
any provisions for DVFS and I'm not sure this could be easily
standardised (or whether we could find enough supporters to get it
adopted).

SCPI is a (standard) interface to a coprocessor handling clocks etc. to
be used with cpufreq. This patchset adds support for cpufreq/dvs which
is not handled by PSCI. So, just to clarify the acronyms:

SCPI - System Control and Power Interface - it's a protocol for
communicating with a System Control Processor (e.g. Cortex-M3) via
mailboxes. It is used in Linux for DVFS but this is *not* a secure/EL3
firmware interface (a.k.a. SMC calls). It indeed a firmware interface
but the firmware runs on a separate coprocessor and not on the CPU itself.

PSCI - Power State Coordination Interface - it is a secure firmware
interface for coordinating the CPU power states (idle, not DVFS). The
firmware may use an SCPI communication channel (e.g. deeper sleep states
where clock changes are needed).

-- 
Catalin
