From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 May 2017 10:39:14 +0100
Subject: [PATCH] ARM: MCPM: ensure not to enter __hyp_soft_restart from
 loopback and cpu_power_down
In-Reply-To: <1495099592-10439-1-git-send-email-sudeep.holla@arm.com>
References: <1495099592-10439-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170518093913.GM22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 10:26:32AM +0100, Sudeep Holla wrote:
> Commit 9da5ac236de6 ("ARM: soft-reboot into same mode that we entered
> the kernel") added support to enter the new kernel in the same processor
> mode as the previous one when we soft-reboot from one kernel into
> another by pass a flag to cpu_reset() so it knows what to do exactly.
> 
> However it missed to make similar changes in MCPM code. Due to the
> missing flag, the CPUs enter HYP mode which is not supported with MCPM.
> MCPM works only in secure mode as it manages CCI.
> 
> This patch aligns the cpu_reset call in MCPM with other changes in the
> above mentioned commit.

I could say... welcome to why casts are bad!  The casts in this code
have hidden the change of function prototype, which is why it's not been
picked up by any of the build check systems.

Please change typedef to this:

typedef typeof(cpu_reset) *phys_reset_t;

so phys_reset_t at least follows the prototype of cpu_reset().

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
