From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 30 Jun 2014 14:16:26 -0400
Subject: [PATCHv2] ARM: mvebu: fix cpuidle implementation to work on
 big-endian systems
In-Reply-To: <1404130165-3593-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1404130165-3593-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140630181626.GY23978@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 02:09:25PM +0200, Thomas Petazzoni wrote:
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
> Jason, as requested, this version has been rebased on top of
> 3.16-rc3. It should be pushed into the 3.16-rc cycle to fix a big in
> the cpuidle implementation affecting big endian configurations. Tested
> on little endian and big endian configuration on Armada XP GP.
> 
>  arch/arm/mach-mvebu/Makefile  |  2 +-
>  arch/arm/mach-mvebu/pmsu.c    |  9 ++-------
>  arch/arm/mach-mvebu/pmsu_ll.S | 25 +++++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 8 deletions(-)
>  create mode 100644 arch/arm/mach-mvebu/pmsu_ll.S

Applied to mvebu/fixes

thx,

Jason.
