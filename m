From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 00:17:21 -0700
Subject: [PATCH v4] drivers/firmware: psci_checker: stash and use
 topology_core_cpumask for hotplug tests
In-Reply-To: <1532515689-31806-1-git-send-email-sudeep.holla@arm.com>
References: <1532515689-31806-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180726071721.mjv4qn7di4zoay2h@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2018 at 11:48:09AM +0100, Sudeep Holla wrote:
> Commit 7f9545aa1a91 ("arm64: smp: remove cpu and numa topology
> information when hotplugging out CPU") updates the cpu topology when
> the CPU is hotplugged out. However the PSCI checker code uses the
> topology_core_cpumask pointers for some of the cpu hotplug testing.
> Since the pointer to the core_cpumask of the first CPU in the group
> is used, which when that CPU itself is hotpugged out is just set to
> itself, the testing terminates after that particular CPU is tested out.
> But the intention of this tests is to cover all the CPU in the group.
> 
> In order to support that, we need to stash the topology_core_cpumask
> before the start of the test and use that value instead of pointer to
> a cpumask which will be updated on CPU hotplug.
> 
> Fixes: 7f9545aa1a91a9a4 ("arm64: smp: remove cpu and numa topology
> 	information when hotplugging out CPU")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/psci_checker.c | 83 ++++++++++++++++++++++++-----------------
>  1 file changed, 49 insertions(+), 34 deletions(-)
> 
> Hi ARM SoC,
> 
> Though the fixes tag points to a commit in arm64/for-next/core,
> it shouldn't be any issue to take this via ARM SoC for v4.19
> Will suggested the same.

Ok, applied to our next/drivers branch now. Thanks!


-Olof
