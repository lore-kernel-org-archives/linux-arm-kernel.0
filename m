From: tony@atomide.com (Tony Lindgren)
Date: Sun, 25 Mar 2018 08:39:27 -0700
Subject: Possible kernel bug in torvalds/linux/master
In-Reply-To: <20180325151904.GA5700@atomide.com>
References: <CAKdteOZLZDkpZ0HMSOVQOc6eRxFzkHyLM=sHm7e0bMV-zeUdVQ@mail.gmail.com>
 <CAK8P3a2ud6LxxuPC1K_nf-Swdn86UThUL2676UFcM6X0JSpptg@mail.gmail.com>
 <20180325151904.GA5700@atomide.com>
Message-ID: <20180325153927.GB5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [180325 15:20]:
> Hi,
> 
> * Arnd Bergmann <arnd@arndb.de> [180325 13:30]:
> > On Sun, Mar 25, 2018 at 3:03 PM, Christophe Lyon
> > <christophe.lyon@linaro.org> wrote:
> > > Hi Arnd,
> > >
> > > We have a Jenkins jobs that builds the kernel from torvalds/linux
> > > master branch mutli_v7 defconfig every day, using our last GCC release
> > > (7.2-2017-11), and boots a beaglebone-black board.
> > >
> > > Last week it started to fail, I first suspected a Lava problem, but
> > > the job now fails every time, and Remi Duraffort from the Lava team
> > > thinks it's really a kernel problem.
> > >
> > > Is this something you are interested in investigating? Or should we
> > > switch to another "less-edge" branch?
> > >
> > > The last successful run:
> > > https://ci.linaro.org/job/tcwg-buildapp/app=linux+multi_v7,label=tcwg-x86_64-build,target=arm-linux-gnueabihf/75/
> > > The next one failed:
> > > https://ci.linaro.org/job/tcwg-buildapp/app=linux+multi_v7,label=tcwg-x86_64-build,target=arm-linux-gnueabihf/76
> > >
> > > Build 75 was with this kernel commit:
> > > Merge branch 'for-4.16-fixes'
> > > 1b5f3ba415fe4cf8b8b39c8d104ed44cde330658
> > >
> > > Build 76 was with:
> > > Merge tag 'clk-fixes-for-linus'
> > > 3215b9d57a2c75c4305a3956ca303d7004485200
> > 
> > Hi Christophe,
> > 
> > This branch is certainly the right one to test, thanks for the report!
> > From looking at the output above, it seems that the kernel no longer
> > boots at all, and fails to even print any messages. Between the
> > two runs, I see the following commits:
> > 
> > 3215b9d57a2c Merge tag 'clk-fixes-for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> > 303851e14a8f Merge tag 'for-linus' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
> > 76c0b6a36a12 Merge tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > 645102eac15e Merge tag 'nfsd-4.16-1' of git://linux-nfs.org/~bfields/linux
> > 32d43cd391ba kvm/x86: fix icebp instruction handling
> > e8980d67d601 RDMA/ucma: Ensure that CM_ID exists prior to access it
> > 68ef3bc31664 nfsd: remove blocked locks on client teardown
> > 80cf79ae4f68 RDMA/verbs: Remove restrack entry from XRCD structure
> > ed65a4dc2208 RDMA/ucma: Fix use-after-free access in ucma_close
> > 7997f3b2df75 clk: bcm2835: Protect sections updating shared registers
> > 49012d1bf5f7 clk: bcm2835: Fix ana->maskX definitions
> > 2975d5de6428 RDMA/ucma: Check AF family prior resolving address
> > 8a53fc511c5e clk: aspeed: Prevent reset if clock is enabled
> > d90c76bb6112 clk: aspeed: Fix is_enabled for certain clocks
> > bd8602ca42f6 infiniband: bnxt_re: use BIT_ULL() for 64-bit bit masks
> > 5388a508479d infiniband: qplib_fp: fix pointer cast
> > 42cea83f9524 IB/mlx5: Fix cleanup order on unload
> > 0c81ffc60d52 RDMA/ucma: Don't allow join attempts for unsupported AF family
> > 7688f2c3bbf5 RDMA/ucma: Fix access to non-initialized CM_ID object
> > 9dea9a2ff61c RDMA/core: Do not use invalid destination in determining port reuse
> > f3f134f5260a RDMA/mlx5: Fix crash while accessing garbage pointer and
> > freed memory
> > c2b37f76485f IB/mlx5: Fix integer overflows in mlx5_ib_create_srq
> > 2c292dbb398e IB/mlx5: Fix out-of-bounds read in create_raw_packet_qp_rq
> > 14bc1dff7427 scsi: qla2xxx: Remove FC_NO_LOOP_ID for FCP and FC-NVMe Discovery
> > 318aaf34f117 scsi: libsas: defer ata device eh commands to libata
> > 55c19eee3b47 clk: qcom: msm8916: Fix return value check in
> > qcom_apcs_msm8916_clk_probe()
> > 9903e41ae1f5 clk: hisilicon: hi3660?Fix potential NULL dereference in
> > hi3660_stub_clk_probe()
> > 56e1ee353943 Merge branch 'clk-helpers' (early part) into clk-fixes
> > 04bf9ab3359f clk: fix determine rate error with pass-through clock
> > 91584eb51b47 Merge branch 'clk-phase' into clk-fixes
> > bd13c6cbd3c0 Merge tag 'ti-clk-fixes-4.16' of
> > https://github.com/t-kristo/linux-pm into clk-fixes
> > a88bb86d58ce Merge tag 'clk-imx-fixes-4.16' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
> > clk-fixes
> > 957a42e8599a Merge tag 'sunxi-clk-fixes-for-4.16' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux into
> > clk-fixes
> > 99652a469df1 clk: migrate the count of orphaned clocks at init
> > 7f95beea3608 clk: update cached phase to respect the fact when setting phase
> > 762790b75210 clk: ti: am43xx: add set-rate-parent support for display
> > clkctrl clock
> > c083dc5f3738 clk: ti: am33xx: add set-rate-parent support for display
> > clkctrl clock
> > 49159a9dc3da clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag
> > a275b315334d clk: imx51-imx53: Fix UART4/5 registration on i.MX50 and i.MX53
> > 5682e268350f clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
> > 
> > Out of these, All the interesting ones are clk related:
> > 
> > 56e1ee353943 Merge branch 'clk-helpers' (early part) into clk-fixes
> > 04bf9ab3359f clk: fix determine rate error with pass-through clock
> > 91584eb51b47 Merge branch 'clk-phase' into clk-fixes
> > bd13c6cbd3c0 Merge tag 'ti-clk-fixes-4.16' of
> > https://github.com/t-kristo/linux-pm into clk-fixes
> > 99652a469df1 clk: migrate the count of orphaned clocks at init
> > 7f95beea3608 clk: update cached phase to respect the fact when setting phase
> > 762790b75210 clk: ti: am43xx: add set-rate-parent support for display
> > clkctrl clock
> > c083dc5f3738 clk: ti: am33xx: add set-rate-parent support for display
> > clkctrl clock
> > 49159a9dc3da clk: ti: clkctrl: add support for CLK_SET_RATE_PARENT flag
> > 
> > I've added the involved parties to Cc. We also see the same thing on
> > kernelci, where many OMAP based systems now fail to boot, with the
> > problem starting at the same commit:
> > 
> > https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v4.16-rc6-431-gbcfc1f455466/
> > 
> > It's possible that this has already been debugged and a fix is being worked on,
> > but I'm not aware of anything, since I have not followed my email
> > while travelling.
> 
> I've confirmed that omap2plus_defconfig boots on bbb while
> multi_v7_defconfig fails to boot with the following:
> 
> l4_wkup_cm:clk:0010:0: failed to disable
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa30e054
> pgd = 4b21228f
> [fa30e054] *pgd=48211452(bad)
> Internal error: : 1028 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.16.0-rc6-00075-g3215b9d57a2c #709
> Hardware name: Generic AM33XX (Flattened Device Tree)
> PC is at _update_sysc_cache+0x2c/0x88
> LR is at _enable+0x19c/0x274
> pc : [<c032a844>]    lr : [<c032afc8>]    psr: 40000013
> sp : db0adea0  ip : 00000003  fp : 00000000
> r10: c144997c  r9 : 00000157  r8 : 00000003
> r7 : c151d30c  r6 : 00000000  r5 : c1678ef4  r4 : c151b2f0
> r3 : fa30e054  r2 : c151b360  r1 : 00000054  r0 : c151b2f0
> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 80204019  DAC: 00000051
> Process swapper/0 (pid: 1, stack limit = 0x2ddf0754)
> Stack: (0xdb0adea0 to 0xdb0ae000)
> dea0: c151b2f0 c032afc8 00000000 a0000013 c1504c48 c151b2f0 c151b314 c1504c48
> dec0: c151b328 c1311c78 a0000013 c0c15ec4 00000011 edaa6d91 c131297c c151b2f0
> dee0: c150ce28 c131297c ffffe000 c1312a68 c1504c48 00000000 c131297c c0302730
> df00: dfdffb06 dfdffafa c1250ecc 00000100 00000157 c0361f34 c124f400 c10cc358
> df20: 00000000 00000002 00000002 c10dec28 00000000 c1504c48 c10eeca0 c10dec9c
> df40: 00000000 dfdffb06 00000000 edaa6d91 00000000 c1677700 c1677700 c13cf824
> df60: c13cf83c 00000003 00000157 c144997c 00000000 c1300e2c 00000002 00000002
> df80: 00000000 c13005c0 00000000 c0d96788 00000000 00000000 00000000 00000000
> dfa0: 00000000 c0d96790 00000000 c03010e8 00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 d5370d56 dcffd777
> [<c032a844>] (_update_sysc_cache) from [<c032afc8>] (_enable+0x19c/0x274)
> [<c032afc8>] (_enable) from [<c1311c78>] (_setup.part.16+0xd8/0x418)
> [<c1311c78>] (_setup.part.16) from [<c1312a68>] (__omap_hwmod_setup_all+0xec/0x100)
> [<c1312a68>] (__omap_hwmod_setup_all) from [<c0302730>] (do_one_initcall+0x54/0x18c)
> [<c0302730>] (do_one_initcall) from [<c1300e2c>] (kernel_init_freeable+0x144/0x1d0)
> [<c1300e2c>] (kernel_init_freeable) from [<c0d96790>] (kernel_init+0x8/0x110)
> [<c0d96790>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
> Exception stack(0xdb0adfb0 to 0xdb0adff8)
> dfa0:                                     00000000 00000000 00000000 00000000
> dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> Code: e31c0c01 e5903048 e0833001 1a00000a (e5933000)
> 
> Tero, it might be some timing related clock issue?

Looks like git bisect points to commit c083dc5f3738 ("clk: ti: am33xx:
add set-rate-parent support for display clkctrl clock"). I also verified
reverting it makes bbb boot again.

Regards,

Tony
