From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 20 Jun 2014 16:28:17 -0400
Subject: [PATCH] ARM: mvebu: fix cpuidle implementation to work on
 big-endian systems
In-Reply-To: <1401120849-2164-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1401120849-2164-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140620202817.GH21711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 26, 2014 at 06:14:09PM +0200, Thomas Petazzoni wrote:
> On Marvell Armada XP, when a CPU comes back from deep idle state of
> cpuidle, it restarts its execution at armada_370_xp_cpu_resume(),
> which puts back the CPU into the coherency, and then calls the generic
> cpu_resume() function.
> 
> While this works on little-endian configurations, it doesn't work on
> big-endian configurations because the CPU restarts in little-endian,
> and therefore must be switched back to big-endian to operate
> properly. To achieve this, a 'setend be' instruction must be executed
> in big-endian configurations. However, the ARM_BE8() macro that is
> used to implement nice compile-time conditional for ARM LE vs. ARM BE8
> is not easily usable in inline assembly.
> 
> Therefore, this patch moves the armada_370_xp_cpu_resume() C function,
> which was anyway just a block of inline assembly, into a proper
> pmsu_ll.S file, and adds the appropriate ARM_BE8(setend be)
> instruction.
> 
> Without this patch, an Armada XP big endian configuration with cpuidle
> enabled fails to boot, as it hangs as soon as one of the CPU hits the
> deep idle state.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/Makefile  |  2 +-
>  arch/arm/mach-mvebu/pmsu.c    |  9 ++-------
>  arch/arm/mach-mvebu/pmsu_ll.S | 25 +++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/mach-mvebu/pmsu_ll.S

This fails to apply to v3.16-rc1.  Please rebase and re-submit.

thx,

Jason.
