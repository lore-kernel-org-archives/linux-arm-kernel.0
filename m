From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Feb 2016 10:48:18 +0000
Subject: [PATCH v5sub1 7/8] arm64: move kernel image to base of vmalloc
 area
In-Reply-To: <20160217101803.GB32714@e104818-lin.cambridge.arm.com>
References: <56BDFC86.5010705@arm.com>
 <20160212160652.GL31665@e104818-lin.cambridge.arm.com>
 <56C1E072.2090909@virtuozzo.com>
 <20160215185957.GB19413@e104818-lin.cambridge.arm.com>
 <56C31D1D.50708@virtuozzo.com>
 <CAKv+Gu8WE=fTZF0Pou24FKDocgshWu8dJRbaC5SJ11E-6T=2Hw@mail.gmail.com>
 <56C34204.60605@virtuozzo.com> <20160216164245.GC8022@leverpostej>
 <56C43A23.1020301@virtuozzo.com>
 <20160217101803.GB32714@e104818-lin.cambridge.arm.com>
Message-ID: <20160217104817.GA26303@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 10:18:03AM +0000, Catalin Marinas wrote:
> On Wed, Feb 17, 2016 at 12:15:15PM +0300, Andrey Ryabinin wrote:
> > On 02/16/2016 07:42 PM, Mark Rutland wrote:
> > > FWIW with the below patch I don't see any "screwed shadow mapping"
> > > warnings on my board, and still later see a tonne of KASAN splats in the
> > > scheduler.
> > 
> > It is possible that I missed something, but I think it means that
> > shadow is alright.
> > 
> > I wonder whether this happens on 4.4. If not, than something in
> > 4.5-rc1 caused this, and the obvious suspect here is irq stack.
> 
> It doesn't seem to happen on 4.4, it starts somewhere before 4.5-rc1. I
> tested the arm64 branch that we pushed upstream with the irq stack
> changes but it didn't trigger. It could as well be a combination of
> multiple change or just something else.
> 
> We'll do some bisecting, though it's not that fun going through the
> merging window commits, especially since many are based on 4.4-rcX (we
> could try on merges only first, there are fewer).

FWIW I did that bisect last night, and that fingered commit
f11aef69b235bc30 ("Merge branch 'pm-cpuidle'") as the first bad commit.

Either there's some subtle interaction, or it's less reproducible than I
thought and the "good" commits are only "possibly-good". I'll try to dig
into that.

FWIW, my bisect log is:

git bisect start
# bad: [92e963f50fc74041b5e9e744c330dca48e04f08d] Linux 4.5-rc1
git bisect bad 92e963f50fc74041b5e9e744c330dca48e04f08d
# good: [afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc] Linux 4.4
git bisect good afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc
# good: [4dffbfc48d65e5d8157a634fd670065d237a9377] arm64/efi: mark UEFI reserved regions as MEMBLOCK_NOMAP
git bisect good 4dffbfc48d65e5d8157a634fd670065d237a9377
# good: [1289ace5b4f70f1e68ce785735b82c7e483de863] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect good 1289ace5b4f70f1e68ce785735b82c7e483de863
# good: [984065055e6e39f8dd812529e11922374bd39352] Merge branch 'drm-next' of git://people.freedesktop.org/~airlied/linux
git bisect good 984065055e6e39f8dd812529e11922374bd39352
# good: [6d1c244803f2c013fb9c31b0904c01f1830b73ab] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 6d1c244803f2c013fb9c31b0904c01f1830b73ab
# bad: [0a13daedf7ffc71b0c374a036355da7fddb20d6d] Merge branch 'for-4.5/lightnvm' of git://git.kernel.dk/linux-block
git bisect bad 0a13daedf7ffc71b0c374a036355da7fddb20d6d
# bad: [278e5acae1321978686e85ca92906054a36aa19b] Merge tag 'for-4.5' of git://git.osdn.jp/gitroot/uclinux-h8/linux
git bisect bad 278e5acae1321978686e85ca92906054a36aa19b
# good: [f9cd69fe5eb6347b4de56458d0378bc0fa44bce9] Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good f9cd69fe5eb6347b4de56458d0378bc0fa44bce9
# good: [9638685e32af961943b679fcb72d4ddd458eb18f] Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect good 9638685e32af961943b679fcb72d4ddd458eb18f
# good: [fa8bb4518771b19460a318fbab3eb36c81db3a50] Merge branch 'pm-devfreq'
git bisect good fa8bb4518771b19460a318fbab3eb36c81db3a50
# bad: [30f05309bde49295e02e45c7e615f73aa4e0ccc2] Merge tag 'pm+acpi-4.5-rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect bad 30f05309bde49295e02e45c7e615f73aa4e0ccc2
# good: [5bb1729cbdfbe974ad6385be94b14afbac97e19f] cpuidle: menu: Avoid pointless checks in menu_select()
git bisect good 5bb1729cbdfbe974ad6385be94b14afbac97e19f
# bad: [db2b52f75250c88ee3c6ba3d91bef38f3f1a1e8c] Merge branch 'pm-tools'
git bisect bad db2b52f75250c88ee3c6ba3d91bef38f3f1a1e8c
# good: [38cb76a307821f76c7f9dff7449f73aeb014d5cc] cpupower: Fix build error in cpufreq-info
git bisect good 38cb76a307821f76c7f9dff7449f73aeb014d5cc
# bad: [f11aef69b235bc30c323776d75ac23b43aac45bb] Merge branch 'pm-cpuidle'
git bisect bad f11aef69b235bc30c323776d75ac23b43aac45bb
# first bad commit: [f11aef69b235bc30c323776d75ac23b43aac45bb] Merge branch 'pm-cpuidle'

Thanks,
Mark.
