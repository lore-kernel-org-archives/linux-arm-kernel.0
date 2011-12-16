From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 16 Dec 2011 14:34:44 +0900
Subject: [PATCH 23/23] ARM: move VMALLOC_END down temporarily for shmobile
In-Reply-To: <1321422521-1138-24-git-send-email-nico@fluxnic.net>
References: <1321422521-1138-1-git-send-email-nico@fluxnic.net>
 <1321422521-1138-24-git-send-email-nico@fluxnic.net>
Message-ID: <CANqRtoQZqZykFCFU9t_Oh55oXEUZhe8O6VPvwdJG2i6Yhr_EDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 2:48 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
>
> THIS IS A TEMPORARY HACK. ?The purpose of this is _only_ to avoid a
> regression on an existing machine while a better fix is implemented.
>
> On shmobile the consistent DMA memory area was set to 158MB in commit
> 28f0721a79 with no explanation. ?The documented size for this area should
> vary between 2MB and 14MB, and none of the other ARM targets exceed that.
>
> The included #warning is therefore meant to be noisy on purpose to get
> shmobile maintainers attention and this commit reverted once this
> consistent DMA size conflict is resolved.
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---

Hi Nicolas,

Thanks for your work on this! Please excuse the slow progress. I have
now gotten around to remove the special mach-shmobile behavior.

The change is included in the unfortunately mangled patch below. Where
would you like me to submit the patch?

Thanks,

/ magnus

From: Magnus Damm <damm@opensource.se>

Update mach-shmobile code to use standard 2MiB
coherent DMA memory size instead of 158MiB.

The 158MiB memory area was used to support HD
resolution multimedia workloads using the same
legacy memory allocating solution as on SH.

There are no in-tree kernel dependencies on the
158MiB setting, and future development should
reserve and allocate memory using some other
method like for instance CMA.

Signed-off-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/mach-shmobile/board-ag5evm.c   |    2 --
 arch/arm/mach-shmobile/board-ap4evb.c   |    2 --
 arch/arm/mach-shmobile/board-g3evm.c    |    2 --
 arch/arm/mach-shmobile/board-g4evm.c    |    2 --
 arch/arm/mach-shmobile/board-mackerel.c |    2 --
 5 files changed, 10 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ag5evm.c
+++ work/arch/arm/mach-shmobile/board-ag5evm.c  2011-12-16
14:04:50.000000000 +0900
@@ -500,8 +500,6 @@ static struct map_desc ag5evm_io_desc[]
 static void __init ag5evm_map_io(void)
 {
        iotable_init(ag5evm_io_desc, ARRAY_SIZE(ag5evm_io_desc));
-       /* DMA memory at 0xf6000000 - 0xffdfffff */
-       init_consistent_dma_size(158 << 20);

        /* setup early devices and console here as well */
        sh73a0_add_early_devices();
--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c  2011-12-16
14:04:12.000000000 +0900
@@ -1213,8 +1213,6 @@ static struct map_desc ap4evb_io_desc[]
 static void __init ap4evb_map_io(void)
 {
        iotable_init(ap4evb_io_desc, ARRAY_SIZE(ap4evb_io_desc));
-       /* DMA memory at 0xf6000000 - 0xffdfffff */
-       init_consistent_dma_size(158 << 20);

        /* setup early devices and console here as well */
        sh7372_add_early_devices();
--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c   2011-12-16
14:05:32.000000000 +0900
@@ -261,8 +261,6 @@ static struct map_desc g3evm_io_desc[] _
 static void __init g3evm_map_io(void)
 {
        iotable_init(g3evm_io_desc, ARRAY_SIZE(g3evm_io_desc));
-       /* DMA memory at 0xf6000000 - 0xffdfffff */
-       init_consistent_dma_size(158 << 20);

        /* setup early devices and console here as well */
        sh7367_add_early_devices();
--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c   2011-12-16
14:05:05.000000000 +0900
@@ -275,8 +275,6 @@ static struct map_desc g4evm_io_desc[] _
 static void __init g4evm_map_io(void)
 {
        iotable_init(g4evm_io_desc, ARRAY_SIZE(g4evm_io_desc));
-       /* DMA memory at 0xf6000000 - 0xffdfffff */
-       init_consistent_dma_size(158 << 20);

        /* setup early devices and console here as well */
        sh7377_add_early_devices();
--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c        2011-12-16
14:04:04.000000000 +0900
@@ -1402,8 +1402,6 @@ static struct map_desc mackerel_io_desc[
 static void __init mackerel_map_io(void)
 {
        iotable_init(mackerel_io_desc, ARRAY_SIZE(mackerel_io_desc));
-       /* DMA memory@0xf6000000 - 0xffdfffff */
-       init_consistent_dma_size(158 << 20);

        /* setup early devices and console here as well */
        sh7372_add_early_devices();
