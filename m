From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 18 May 2017 11:59:50 -0700
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Switch AXP20x driver from
 module to built-in
In-Reply-To: <CAOi56cV=UBEFQ6V4LLNrHDaDJgb33mrCA6Z+vj_3VziOpkRcvQ@mail.gmail.com>
References: <937914a68e4e7d6db2d12540cc6253b200978e2d.1486590875.git.rask@formelder.dk>
 <49ad3e66452bd78da7b9e581129f76633c56e609.1486590875.git.rask@formelder.dk>
 <20170210084213.uzf25soh7bl73a6g@lukather>
 <CAOi56cV=UBEFQ6V4LLNrHDaDJgb33mrCA6Z+vj_3VziOpkRcvQ@mail.gmail.com>
Message-ID: <CAOi56cXLo5LaT8CgfwB991gq+gCv4OY3VNkGWviooq43=6Wayg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 10:39 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> On Fri, Feb 10, 2017 at 12:42 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Wed, Feb 08, 2017 at 11:09:31PM +0100, Rask Ingemann Lambertsen wrote:
>>> The AXP20X regulator support is currently built as a module, which means
>>> it's not available until the root fs has been mounted, but the boot loader
>>> might not have enabled the required regulators, so build their drivers
>>> into the kernel.
>>>
>>> Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
>>
>> Queued for 4.12.
>
> Hello, kernelci.org is reporting boot failures on sun5i-r8-chip in
> linux-next[1]  for a few days and with a variety of defconfigs. I
> bisected it[2] down to this patch.
>
> I verified that reverting this patch on top of next-20170310 makes my
> chip board boot again.

FYI... this board is still broken in linux-next (and now in mainline),
and reverting $SUBJECT patch still makes it work.

Is nobody else using mainline on this board?

Kevin

> [1] https://kernelci.org/boot/id/58c2426759b5144a68645535/
> [2]
> $ git bisect log
> git bisect start
> # good: [144c7666b535aa5d402bf37db84df90aebf1f563] Merge tag
> 'pci-v4.11-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git\
> /helgaas/pci
> git bisect good 144c7666b535aa5d402bf37db84df90aebf1f563
> # bad: [5be4921c9958ec02a67506bd6f7a52fce663c201] Add linux-next
> specific files for 20170310
> git bisect bad 5be4921c9958ec02a67506bd6f7a52fce663c201
> # good: [ea6200e84182989a3cce9687cf79a23ac44ec4db] Merge branch
> 'core-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/ker\
> nel/git/tip/tip
> git bisect good ea6200e84182989a3cce9687cf79a23ac44ec4db
> # good: [3bd7db63a841e8c5297bb18ad801df67d5e38ad2] PCI/ASPM: Always
> set link->downstream to avoid NULL dereference on remove
> git bisect good 3bd7db63a841e8c5297bb18ad801df67d5e38ad2
> # good: [8c71fff434e5ecf5ff27bd61db1bc9ac4c2b2a1b] [media] v4l: vsp1:
> Adapt vsp1_du_setup_lif() interface to use a structure
> git bisect good 8c71fff434e5ecf5ff27bd61db1bc9ac4c2b2a1b
> # good: [d825adb48cf9bf9e3f5cb1d927e2827f8c2abee4] xenbus: Remove
> duplicate inclusion of linux/init.h
> git bisect good d825adb48cf9bf9e3f5cb1d927e2827f8c2abee4
> # good: [b600dc879ee45d52a4d4c50c4efb9c0f63495284] Merge
> remote-tracking branch 'drm/drm-next'
> git bisect good b600dc879ee45d52a4d4c50c4efb9c0f63495284
> # bad: [8004c75027be90f2f1b2956f99b2709aa78a8fdb] Merge
> remote-tracking branch 'extcon/extcon-next'
> git bisect bad 8004c75027be90f2f1b2956f99b2709aa78a8fdb
> # bad: [e04b073635205c983891d0d70fb854c7b1871d89] Merge
> remote-tracking branch 'input/next'
> git bisect bad e04b073635205c983891d0d70fb854c7b1871d89
> # bad: [d1ae62f438f26ecf256e5e4dd7cb53884c7dd3ab] Merge
> remote-tracking branch 'sunxi/sunxi/for-next'
> git bisect bad d1ae62f438f26ecf256e5e4dd7cb53884c7dd3ab
> # good: [5956fb6486d7bd2467fe6282a784af4f1cf67bef] Merge
> remote-tracking branch 'drm-misc/for-linux-next'
> git bisect good 5956fb6486d7bd2467fe6282a784af4f1cf67bef
> # good: [a0a68fb6872f545acd49035ea17c52a9f30d07dc] drm/sun4i: Pass
> pointer for underlying backend into layer init
> git bisect good a0a68fb6872f545acd49035ea17c52a9f30d07dc
> # good: [7d55034799cdc9945ce7975d690f944575376e34] ARM: dts: sunxi:
> Remove no longer used pinctrl/sun4i-a10.h header
> git bisect good 7d55034799cdc9945ce7975d690f944575376e34
> # bad: [681cc0445e24fe5cb4e7de960947443de592621c] Merge branches
> 'sunxi/clk-for-4.12', 'sunxi/core-for-4.12', 'sunxi/defconfig-fo\
> r-4.12', 'sunxi/drm-for-4.12' and 'sunxi/dt-for-4.12' into sunxi/for-next
> git bisect bad 681cc0445e24fe5cb4e7de960947443de592621c
> # good: [b0f0daa8fe9e74b85f6360288d38224ad1c2f2f4] clk: sunxi-ng:
> sun5i: Fix mux width for csi clock
> git bisect good b0f0daa8fe9e74b85f6360288d38224ad1c2f2f4
> # bad: [7cae7ef89e360cd3dc139eaac2f480c25bc7bfa1] ARM:
> multi_v7_defconfig: Switch AXP20x driver from module to built-in
> git bisect bad 7cae7ef89e360cd3dc139eaac2f480c25bc7bfa1
> # good: [5741e07b465d32458945d363ce87c0e2b7fd028d] ARM:
> multi_v7_defconfig: Switch sunxi RSB driver from module to built-in
> git bisect good 5741e07b465d32458945d363ce87c0e2b7fd028d
> # good: [f48a203cc44f26921f05911c047db49d2864c797] ARM:
> multi_v7_defconfig: Enable AC100 RTC driver
> git bisect good f48a203cc44f26921f05911c047db49d2864c797
> # first bad commit: [7cae7ef89e360cd3dc139eaac2f480c25bc7bfa1] ARM:
> multi_v7_defconfig: Switch AXP20x driver from module to built\
> -in
