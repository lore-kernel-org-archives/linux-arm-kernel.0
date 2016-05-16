From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 16 May 2016 18:17:46 +0100
Subject: Juno r0 fails to boot with linux-next 20160516
Message-ID: <20160516171745.GB26180@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

I was trying to boot linux-next 20150516 today on Juno r0 and it gets stuck
after printing the message:

Serial: AMBA PL011 UART driver

Bisecting shows commit d02e8a63733ff9121 as the culprit:

commit d02e8a63733ff912128c04a091c0de75be8df1ab
Author: Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Sun Oct 18 16:50:48 2015 -0600

    coresight: Add support for Juno platform
    
    This patch adds support for ARM's juno platform.  More
    specifically it has definitions for the A53/57 tracers,
    the A53/57 cluster funnels, the main funnel and the ETF
    in circular buffer mode.
    
    Support for all the other coresight IP blocks is not
    addressed.
    
    Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Juno r1 is not affected as you are modifying only the juno.dts file. Also,
if I have the DSTREAM unit connected to the boot core the kernel boots fine,
which leads me to believe that there is some power domain issue at play (?).
Also, reverting the patch gets r0 to boot again.

This is the bisection log:

$ git bisect start HEAD v4.6-rc7
Bisecting: 5755 revisions left to test after this (roughly 13 steps)
[027e278cc4d21e4718be4ea5bb14e360ff259174] Merge remote-tracking branch 'crypto/master'
$ git bisect good
Bisecting: 2836 revisions left to test after this (roughly 12 steps)
[b14343bae9270c97b7b6b4652157577d2786c591] Merge remote-tracking branch 'tip/auto-latest'
$ git bisect good
Bisecting: 1350 revisions left to test after this (roughly 11 steps)
[98efb6a2745524fc404211e266f54bf409063364] Merge remote-tracking branch 'staging/staging-next'
$ git bisect good
Bisecting: 687 revisions left to test after this (roughly 9 steps)
[ecf549d34f211f9bae0dfab98f994825b0891648] Merge remote-tracking branch 'pwm/for-next'
$ git bisect good
Bisecting: 343 revisions left to test after this (roughly 9 steps)
[fb86798c5cdd615f5c9780eca36a232434f4d63b] nilfs2: fix white space issue in nilfs_mount()
$ git bisect good
Bisecting: 158 revisions left to test after this (roughly 8 steps)
[ae82fd28e602ddab3381d76603a0af9e87a5e2aa] Merge remote-tracking branch 'coresight/next'
$ git bisect bad
Bisecting: 92 revisions left to test after this (roughly 7 steps)
[98b8525abb7f0d9a5ab942a2e044011d7e635490] clk: sunxi: Add display and TCON0 clocks driver
$ git bisect good
Bisecting: 51 revisions left to test after this (roughly 6 steps)
[6d9122078097233dbfc4ad3a45512393cddf8540] Merge branch 'for-4.7/core' into for-next
$ git bisect good
Bisecting: 25 revisions left to test after this (roughly 5 steps)
[25d894772abc89f78512cf640250514be87a3b46] coresight: tmc: introducing new header file
$ git bisect bad
Bisecting: 12 revisions left to test after this (roughly 4 steps)
[63f09f1d779856b615768a97c641ab26126c9183] coresight: no need to do the forced type conversion
$ git bisect bad
Bisecting: 6 revisions left to test after this (roughly 3 steps)
[0cce003868b664547d9e5dd1f586b902cca43784] coresight: etm4x: unlocking tracers in default arch init
$ git bisect bad
Bisecting: 2 revisions left to test after this (roughly 2 steps)
[dd7ebddfdad8d379887f9e2f74d0ba207b59cb77] coresight: etm4x: adding config and traceid registers
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 1 step)
[d03196055ea8b535a346239307dfa797bc4059d2] coresight: etm4x: moving sysFS entries to a dedicated file
$ git bisect bad
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[d02e8a63733ff912128c04a091c0de75be8df1ab] coresight: Add support for Juno platform


Best regards,
Liviu

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
