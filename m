From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 27 Jun 2014 13:30:04 -0400
Subject: [RFC 1/4] ARM: tegra: Move SoC drivers to drivers/soc/tegra
In-Reply-To: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
References: <1403888329-24755-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53ADAA1C.70407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Arnd, Greg, Catalin and Kumar,

On Friday 27 June 2014 12:58 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> These drivers are closely coupled and need to be moved as a whole. One
> reason for moving them out of arch/arm/mach-tegra is to allow them to be
> shared with 64-bit ARM.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  arch/arm/mach-tegra/Makefile                       | 32 --------
>  arch/arm/mach-tegra/common.h                       |  4 -
>  arch/arm/mach-tegra/io.c                           | 27 +++++-
>  arch/arm/mach-tegra/pmc.h                          | 62 --------------
>  arch/arm/mach-tegra/tegra.c                        |  9 --
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/tegra/Makefile                         | 34 ++++++++
>  .../soc/tegra}/cpuidle-tegra114.c                  |  0
>  .../soc/tegra}/cpuidle-tegra20.c                   |  6 +-
>  .../soc/tegra}/cpuidle-tegra30.c                   |  0
>  .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.c |  0
>  .../arm/mach-tegra => drivers/soc/tegra}/cpuidle.h |  3 -
>  .../mach-tegra => drivers/soc/tegra}/flowctrl.c    |  0
>  .../mach-tegra => drivers/soc/tegra}/flowctrl.h    |  2 -
>  .../arm/mach-tegra => drivers/soc/tegra}/headsmp.S |  0
>  .../arm/mach-tegra => drivers/soc/tegra}/hotplug.c |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h |  0
>  .../arm/mach-tegra => drivers/soc/tegra}/irammap.h |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c   |  1 -
>  {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h   |  6 --
>  .../arm/mach-tegra => drivers/soc/tegra}/platsmp.c |  5 --
>  .../mach-tegra => drivers/soc/tegra}/pm-tegra20.c  |  0
>  .../mach-tegra => drivers/soc/tegra}/pm-tegra30.c  |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c    |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h    |  4 +-
>  {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c   |  0
>  drivers/soc/tegra/pmc.h                            | 35 ++++++++
>  .../mach-tegra => drivers/soc/tegra}/powergate.c   |  0
>  .../soc/tegra}/reset-handler.S                     |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h |  2 -
>  .../soc/tegra}/sleep-tegra20.S                     |  0
>  .../soc/tegra}/sleep-tegra30.S                     |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S |  0
>  {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h |  2 -
>  include/linux/tegra-soc.h                          | 95 ++++++++++++++++++++++
>  36 files changed, 195 insertions(+), 135 deletions(-)
>  delete mode 100644 arch/arm/mach-tegra/common.h
>  delete mode 100644 arch/arm/mach-tegra/pmc.h
>  create mode 100644 drivers/soc/tegra/Makefile
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/flowctrl.h (98%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/headsmp.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/hotplug.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/iomap.h (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irammap.h (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.c (99%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/irq.h (83%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/platsmp.c (98%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra20.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm-tegra30.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pm.h (94%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/pmc.c (100%)
>  create mode 100644 drivers/soc/tegra/pmc.h
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/powergate.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra20.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep-tegra30.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/sleep.h (98%)
> 
NAK for this patch.

You are using drivers/soc/* as a dump yard for your SOC code which
is not the intention we created drivers/soc/.

Its really for subsystem drivers which doesn't have appropriate
home in Linux kernel today. From your above patch ...

>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra114.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra20.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle-tegra30.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/cpuidle.h (91%)
This should go into drivers/idle/*. if you have dependencies, please sort
them out.

>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset-handler.S (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.c (100%)
>  rename {arch/arm/mach-tegra => drivers/soc/tegra}/reset.h (97%)
subsystem: drivers/power/reset/

For tegra/*pm*/, you can use drivers/power or drivers/base/power/

For SMP boot, ARMv8 expecting to have either PSCI based implementation or
device tree based boot scheme. you can move towards that model if possible.

Please find appropriate subsystem to move your SOC code and if you don't
find an appropriate subsystem, we can discuss adding that under drivers/soc.
The drivers/soc/* isn't a dumping ground so please don't abuse it.

regards,
Santosh
