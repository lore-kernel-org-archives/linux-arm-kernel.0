From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 2 Oct 2017 13:09:31 -0700
Subject: 4879b7ae05 ("Merge tag 'dmaengine-4.12-rc1' of .."): WARNING:
 kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value
 000001be
In-Reply-To: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
References: <59d177a7.vsiddgOxdHRIlRvy%fengguang.wu@intel.com>
Message-ID: <CA+55aFz_ijfUxyk2kdLhfzfS1z0_uRBw6eQb9UxFvh=5zOzzaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bringing in Josh on this, because the merge commit gets fingered
because it seems to be an interaction between the new code from the
merge and the ORC unwinder changes. It's probably some almost trivial
code difference that just causes some code generation to change.

And because Josh wasn't implicated in the merge, he didn't get cc'd by
the kernel test robot.

Of course, the stack trace itself seems to be pretty useless, since
that randconfig doesn't have KALLSYMS enabled, so it's just random hex
numbers.

Josh, original email on lkml and a few other mailing lists, see for example:

    https://www.spinics.net/lists/devicetree/msg196692.html

Any ideas?

                Linus

On Sun, Oct 1, 2017 at 4:17 PM, kernel test robot
<fengguang.wu@intel.com> wrote:
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit 4879b7ae05431ebcd228a4ff25a81120b3d85891
>     Merge tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma
>
>     Pull dmaengine updates from Vinod Koul:
>      "This time again a smaller update consisting of:
>
>        - support for TI DA8xx dma controller and updates to the cppi driver
>
>        - updates on bunch of drivers like xilinx, pl08x, stm32-dma, mv_xor,
>          ioat, dmatest"
>
>     * tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma: (35 commits)
>       dmaengine: pl08x: remove lock documentation
>       dmaengine: pl08x: fix pl08x_dma_chan_state documentation
>       dmaengine: pl08x: Use the BIT() macro consistently
>       dmaengine: pl080: Fix some missing kerneldoc
>       dmaengine: pl080: Cut some unused defines
>       dmaengine: dmatest: Add check for supported buffer count (sg_buffers)
>       dmaengine: dmatest: Select DMA_ENGINE_RAID as its needed for the slave_sg test
>       dmaengine: virt-dma: Convert to use list_for_each_entry_safe()
>       dma-debug: use offset_in_page() macro
>       dmaengine: mv_xor: use offset_in_page() macro
>       dmaengine: dmatest: use offset_in_page() macro
>       dmaengine: sun4i: fix invalid argument
>       dmaengine: ioat: use setup_timer
>       dmaengine: cppi41: Fix an Oops happening in cppi41_dma_probe()
>       dmaengine: pl330: remove pdata based initialization
>       dmaengine: cppi: fix build error due to bad variable
>       dmaengine: imx-sdma: add 1ms delay to ensure SDMA channel is stopped
>       dmaengine: cppi41: use managed functions devm_*()
>       dmaengine: cppi41: fix cppi41_dma_tx_status() logic
>       dmaengine: qcom_hidma: pause the channel on shutdown
>       ...
>
> ecc721a72c  Merge tag 'pwm/for-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> be13ec668d  Merge branch 'topic/pl330' into for-linus
> 4879b7ae05  Merge tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> 9e66317d3c  Linux 4.14-rc3
> 1418b85217  Add linux-next specific files for 20170929
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+
> |                                                       | ecc721a72c | be13ec668d | 4879b7ae05 | v4.14-rc3 | next-20170929 |
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+
> | boot_successes                                        | 1009       | 1009       | 909        | 5         | 510           |
> | boot_failures                                         | 0          | 0          | 1          | 4         | 153           |
> | WARNING:kernel_stack                                  | 0          | 0          | 1          | 3         | 111           |
> | BUG:unable_to_handle_kernel                           | 0          | 0          | 0          | 3         | 48            |
> | Oops:#[##]                                            | 0          | 0          | 0          | 3         | 48            |
> | EIP:update_stack_state                                | 0          | 0          | 0          | 3         | 48            |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt | 0          | 0          | 0          | 3         | 48            |
> | invoked_oom-killer:gfp_mask=0x                        | 0          | 0          | 0          | 1         | 16            |
> | Mem-Info                                              | 0          | 0          | 0          | 1         | 16            |
> | EIP:clear_user                                        | 0          | 0          | 0          | 0         | 2             |
> | EIP:copy_page_to_iter                                 | 0          | 0          | 0          | 0         | 1             |
> +-------------------------------------------------------+------------+------------+------------+-----------+---------------+
>
> [   98.541044] random: ubusd: uninitialized urandom read (4 bytes read)
> [   98.541708] random: ubusd: uninitialized urandom read (4 bytes read)
> [   98.549594] random: ubusd: uninitialized urandom read (4 bytes read)
> [   98.550365] random: ubusd: uninitialized urandom read (4 bytes read)
> [  110.395203] sock: process `trinity-main' is using obsolete setsockopt SO_BSDCOMPAT
> [  110.399425] WARNING: kernel stack regs at bd92bc2e in 01-cpu-hotplug:3811 has bad 'bp' value 000001be
> [  110.399428] unwind stack type:0 next_sp:  (null) mask:0x2 graph_idx:0
> [  110.399431] bd92bc2e: 92bc7f00 (0x92bc7f00)
> [  110.399433] bd92bc32: c27041bd (0xc27041bd)
> [  110.399435] bd92bc36: 92bc7fb8 (0x92bc7fb8)
> [  110.399436] bd92bc3a: ffffffbd (0xffffffbd)
>
>                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start v4.12 v4.11 --
> git bisect  bad f3926e4c2a4b53c25a998de168d4eef6d0360369  # 16:26  B    172     1    0   0  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good 677375cef8cb7763ef620e007873117b9bad72a0  # 22:11  G    903     0    0   1  Merge tag 'fscrypt_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/fscrypt
> git bisect  bad 09d79d103371b1b7ea70ea7f9c05ac207ef22f5d  # 23:30  B    663     1    0   1  Merge tag 'docs-4.12-2' of git://git.lwn.net/linux
> git bisect  bad 7fc22f45fef00b55d9517e340650b6a0368faff1  # 02:35  B    503     1    0   0  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
> git bisect good 11fbf53d66ec302fe50b06bd7cb4863dbb98775a  # 07:12  G    910     0    0   5  Merge branch 'work.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect good 0ff4c01b279a590a2826ade9321ad8c7ca5a1b6c  # 10:08  G    905     0    0   0  Merge tag 'armsoc-arm64' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
> git bisect good 28b47809b2171a6cfbab839936b24280639c9f85  # 12:37  G    902     0    0   0  Merge tag 'iommu-updates-v4.12' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> git bisect  bad 4879b7ae05431ebcd228a4ff25a81120b3d85891  # 13:08  B    274     1    0   0  Merge tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> git bisect good ecc721a72c121e8b641d68efd24a225abedb9a30  # 14:57  G    910     0    0   0  Merge tag 'pwm/for-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> git bisect good f23514b1017905c2798224fa07e236471b9ed1e7  # 16:35  G    903     0    0   0  Merge branch 'topic/cppi' into for-linus
> git bisect good dd2b9ff8a9f992b4c85842e8b7c0b6f08f9e7e7c  # 18:08  G    910     0    0   0  Merge branch 'topic/pl08x' into for-linus
> git bisect good 3378e7a49fda9537d48953cd41cf7836c472ba2f  # 19:33  G    910     0    0   0  Merge branch 'topic/qcom' into for-linus
> git bisect good b7b0201a6743c4d9b634da68ad8bb94db28b8e69  # 20:58  G    910     0    0   0  Merge branch 'topic/xilinx' into for-linus
> git bisect good be13ec668d043e5313985014d34735ec6ede074a  # 05:52  G    910     0    0   0  Merge branch 'topic/pl330' into for-linus
> # first bad commit: [4879b7ae05431ebcd228a4ff25a81120b3d85891] Merge tag 'dmaengine-4.12-rc1' of git://git.infradead.org/users/vkoul/slave-dma
> git bisect good ecc721a72c121e8b641d68efd24a225abedb9a30  # 06:03  G   1004     0    0   0  Merge tag 'pwm/for-4.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> git bisect good be13ec668d043e5313985014d34735ec6ede074a  # 06:51  G   1009     0    0   0  Merge branch 'topic/pl330' into for-linus
> # extra tests on HEAD of linux-devel/devel-catchup-201709292214
> git bisect  bad ad260dff250ef395475b3fadb7f751beb283772b  # 06:52  B      7     6    0   2  0day head guard for 'devel-catchup-201709292214'
> # extra tests on tree/branch linus/master
> git bisect  bad 9e66317d3c92ddaab330c125dfe9d06eee268aff  # 07:16  B      6     3    1   1  Linux 4.14-rc3
> # extra tests on tree/branch linux-next/master
> git bisect  bad 1418b852174ad50b3cb4738b8801626aefdc0bd9  # 07:17  B    472   111    0  42  Add linux-next specific files for 20170929
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/lkp                          Intel Corporation
