From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 24 May 2015 21:34:04 +0200
Subject: [BUG] Read-Only THP causes stalls (commit 10359213d)
Message-ID: <20150524193404.GD16910@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I noticed a regression on my arm64 APM X-Gene system a couple
of weeks back.  I would occassionally see the system lock up and see RCU
stalls during the caching phase of kernbench.  I then wrote a small
script that does nothing but cache the files
(http://paste.ubuntu.com/11324767/) and ran that in a loop.  On a known
bad commit (v4.1-rc2), out of 25 boots, I never saw it get past 21
iterations of the loop.  I have since tried to run a bisect from v3.19 to
v4.0 using 100 iterations as my criteria for a good commit.

This resulted in the following first bad commit:

10359213d05acf804558bda7cc9b8422a828d1cd
(mm: incorporate read-only pages into transparent huge pages, 2015-02-11)

Indeed, running the workload on v4.1-rc4 still produced the behavior,
but reverting the above commit gets me through 100 iterations of the
loop.

I have not tried to reproduce on an x86 system.  Turning on a bunch
of kernel debugging features *seems* to hide the problem.  My config for
the XGene system is defconfig + CONFIG_BRIDGE and
CONFIG_POWER_RESET_XGENE.

Please let me know if I can help test patches or other things I can
do to help.  I'm afraid that by simply reading the patch I didn't see
anything obviously wrong with it which would cause this behavior.

Thanks,
-Christoffer
