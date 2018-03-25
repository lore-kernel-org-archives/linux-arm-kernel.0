From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 25 Mar 2018 15:28:40 +0200
Subject: Possible kernel bug in torvalds/linux/master
In-Reply-To: <CAKdteOZLZDkpZ0HMSOVQOc6eRxFzkHyLM=sHm7e0bMV-zeUdVQ@mail.gmail.com>
References: <CAKdteOZLZDkpZ0HMSOVQOc6eRxFzkHyLM=sHm7e0bMV-zeUdVQ@mail.gmail.com>
Message-ID: <CAK8P3a2ud6LxxuPC1K_nf-Swdn86UThUL2676UFcM6X0JSpptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2018 at 3:03 PM, Christophe Lyon
<christophe.lyon@linaro.org> wrote:
> Hi Arnd,
>
> We have a Jenkins jobs that builds the kernel from torvalds/linux
> master branch mutli_v7 defconfig every day, using our last GCC release
> (7.2-2017-11), and boots a beaglebone-black board.
>
> Last week it started to fail, I first suspected a Lava problem, but
> the job now fails every time, and Remi Duraffort from the Lava team
> thinks it's really a kernel problem.
>
> Is this something you are interested in investigating? Or should we
> switch to another "less-edge" branch?
>
> The last successful run:
> https://ci.linaro.org/job/tcwg-buildapp/app=linux+multi_v7,label=tcwg-x86_64-build,target=arm-linux-gnueabihf/75/
> The next one failed:
> https://ci.linaro.org/job/tcwg-buildapp/app=linux+multi_v7,label=tcwg-x86_64-build,target=arm-linux-gnueabihf/76
>
> Build 75 was with this kernel commit:
> Merge branch 'for-4.16-fixes'
> 1b5f3ba415fe4cf8b8b39c8d104ed44cde330658
>
> Build 76 was with:
> Merge tag 'clk-fixes-for-linus'
> 3215b9d57a2c75c4305a3956ca303d7004485200

Hi Christophe,

This branch is certainly the right one to test, thanks for the report!
>From looking at the output above, it seems that the kernel no longer
boots at all, and fails to even print any messages. Between the
two runs, I see the following commits:

3215b9d57a2c Merge tag 'clk-fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
303851e14a8f Merge tag 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
76c0b6a36a12 Merge tag 'scsi-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
645102eac15e Merge tag 'nfsd-4.16-1' of git://linux-nfs.org/~bfields/linux
32d43cd391ba kvm/x86: fix icebp instruction handling
e8980d67d601 RDMA/ucma: Ensure that CM_ID exists prior to access it
68ef3bc31664 nfsd: remove blocked locks on client teardown
80cf79ae4f68 RDMA/verbs: Remove restrack entry from XRCD structure
ed65a4dc2208 RDMA/ucma: Fix use-after-free access in ucma_close
7997f3b2df75 clk: bcm2835: Protect sections updating shared registers
49012d1bf5f7 clk: bcm2835: Fix ana->maskX definitions
2975d5de6428 RDMA/ucma: Check AF family prior resolving address
8a53fc511c5e clk: aspeed: Prevent reset if clock is enabled
d90c76bb6112 clk: aspeed: Fix is_enabled for certain clocks
bd8602ca42f6 infiniband: bnxt_re: use BIT_ULL() for 64-bit bit masks
5388a508479d infiniband: qplib_fp: fix pointer cast
42cea83f9524 IB/mlx5: Fix cleanup order on unload
0c81ffc60d52 RDMA/ucma: Don't allow join attempts for unsupported AF family
7688f2c3bbf5 RDMA/ucma: Fix access to non-initialized CM_ID object
9dea9a2ff61c RDMA/core: Do not use invalid destination in determining port reuse
f3f134f5260a RDMA/mlx5: Fix crash while accessing garbage pointer and
freed memory
c2b37f76485f IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
2c292dbb398e IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
14bc1dff7427 scsi: qla2xxx: Remove FC_NO_LOOP_ID for FCP and FC-NVMe Discovery
318aaf34f117 scsi: libsas: defer ata device eh commands to libata
55c19eee3b47 clk: qcom: msm8916: Fix return value check in
qcom_apcs_msm8916_clk_probe()
9903e41ae1f5 clk: hisilicon: hi3660?Fix potential NULL dereference in
hi3660_stub_clk_probe()
56e1ee353943 Merge branch 'clk-helpers' (early part) into clk-fixes
04bf9ab3359f clk: fix determine rate error with pass-through clock
91584eb51b47 Merge branch 'clk-phase' into clk-fixes
bd13c6cbd3c0 Merge tag 'ti-clk-fixes-4.16' of
https://github.com/t-kristo/linux-pm into clk-fixes
a88bb86d58ce Merge tag 'clk-imx-fixes-4.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
clk-fixes
957a42e8599a Merge tag 'sunxi-clk-fixes-for-4.16' of
https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
clk-fixes
99652a469df1 clk: migrate the count of orphaned clocks at init
7f95beea3608 clk: update cached phase to respect the fact when setting phase
762790b75210 clk: ti: am43xx: add set-rate-parent support for display
clkctrl clock
c083dc5f3738 clk: ti: am33xx: add set-rate-parent support for display
clkctrl clock
49159a9dc3da clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag
a275b315334d clk: imx51-imx53: Fix UART4/5 registration on i.MX50 and i.MX53
5682e268350f clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops

Out of these, All the interesting ones are clk related:

56e1ee353943 Merge branch 'clk-helpers' (early part) into clk-fixes
04bf9ab3359f clk: fix determine rate error with pass-through clock
91584eb51b47 Merge branch 'clk-phase' into clk-fixes
bd13c6cbd3c0 Merge tag 'ti-clk-fixes-4.16' of
https://github.com/t-kristo/linux-pm into clk-fixes
99652a469df1 clk: migrate the count of orphaned clocks at init
7f95beea3608 clk: update cached phase to respect the fact when setting phase
762790b75210 clk: ti: am43xx: add set-rate-parent support for display
clkctrl clock
c083dc5f3738 clk: ti: am33xx: add set-rate-parent support for display
clkctrl clock
49159a9dc3da clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag

I've added the involved parties to Cc. We also see the same thing on
kernelci, where many OMAP based systems now fail to boot, with the
problem starting at the same commit:

https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.16-rc6-431-gbcfc1f455466/

It's possible that this has already been debugged and a fix is being worked on,
but I'm not aware of anything, since I have not followed my email
while travelling.

        Arnd
