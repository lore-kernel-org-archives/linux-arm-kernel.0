From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 Jun 2011 00:01:20 +0200
Subject: [GIT PULL] scalable TWD localtimer
Message-ID: <BANLkTik0TVpfax1Fe8c_6A9SFUNzfDbxyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

please consider pulling this for the -rc series since I see this as a
horrible bug that Thomas just fixed the infrastructure to properly
counter the week before the merge window.

You probably know the story but basically there is one clockline
into the ARM-supplied MPCore thing, and it inevitably also clocks
the TWD. Sadly that includes the localtimer, which will make all
clockevents scale in both directions, firing too late or too early
as compared to desired wall-clock time (or system clocksource) as
the clock speed of the core is changed. Right now there is no
compensation whatsoever for this so to run the system reliably
on v3.0-rc1, cpufreq has to be disabled.

Thomas and Colin did the grunt work, I added a scaling smp_twd
clock reflecting the Ux500 cpufreq changes, and now it is rock solid
as far as I can tell.

I couldn't test this in next since it messes around in your tree,
if you don't think this is -rc material please consider pulling into
the devel branch so we get early testing of it in -next as an
alternative route to mainline.

The following changes since commit 55922c9d1b84b89cb946c777fddccb3247e7df2c:

  Linux 3.0-rc1 (2011-05-29 17:43:36 -0700)

are available in the git repository at:
 git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
twd-clockevents

Colin Cross (1):
      ARM: smp_twd: Reconfigure clockevents after cpufreq change

Linus Walleij (1):
      mach-ux500: register a clock for the SMP TWD

 arch/arm/kernel/smp_twd.c   |   90 ++++++++++++++++++++++++++++++++++++++++---
 arch/arm/mach-ux500/clock.c |   48 +++++++++++++++++++++++
 2 files changed, 132 insertions(+), 6 deletions(-)
