From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 01 Apr 2011 23:27:55 +0200
Subject: kirkwood build failure on mainline
Message-ID: <87r59lr7ac.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks to kautobuild, I've noticed that -rc1 is not building on kirkwood
with following error [1]:

arch/arm/kernel/built-in.o: In function `cpu_suspend':
io.c:(.text+0x4544): undefined reference to `cpu_feroceon_do_suspend'
io.c:(.text+0x4554): undefined reference to `cpu_feroceon_suspend_size'
arch/arm/kernel/built-in.o: In function `cpu_resume':
io.c:(.data+0x1e8): undefined reference to `cpu_feroceon_do_resume'

After looking at other build logs, there are other platform failing with
similar error. I guess it's failing since commit
f6b0fa02e8b0708d17d631afce456524eadf87ff "ARM: pm: add generic CPU
suspend/resume support". In fact, I would say that this commit only
shows that there's a problem and is not really the cause.
A naive explanation would be that ARCH_SUSPEND_POSSIBLE is selected for
theses systems even if suspend is not supported. Adding a "depends on
!CPU_FEROCEON" is making the kernel build.

Would a patch disabling ARCH_SUSPEND_POSSIBLE for all cpu failing to
build with similar error be accepted/welcome or it's just a really
stupid idea ? In case of it being a stupid idea, what would be the right
approach to fix that given that implementing suspend for all failing SoC
is excluded ?

Thanks,
Arnaud

[1]
http://armlinux.simtec.co.uk/kautobuild/2.6.39-rc1-git2/kirkwood_defconfig/zimage.log
[2] for instance:
http://armlinux.simtec.co.uk/kautobuild/2.6.39-rc1-git2/pxa910_defconfig/zimage.log
