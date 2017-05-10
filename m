From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 May 2017 21:11:05 +0200
Subject: [GIT PULL] TEE driver infrastructure and OP-TEE drivers
In-Reply-To: <CA+55aFxfBG5tc3ysXF_A_5mvsYk4Y2zdq+OD_oxoaDz0UrXMKA@mail.gmail.com>
References: <CAK8P3a06+bG93H0XzAF1UUN_BbV-Cg3ERpVdR6qLuLpZUmp2Ug@mail.gmail.com>
 <CA+55aFxfBG5tc3ysXF_A_5mvsYk4Y2zdq+OD_oxoaDz0UrXMKA@mail.gmail.com>
Message-ID: <CAK8P3a14wZ5QRPZ-+V-K6Y9KB-50dCmfR14P2Cad+WZciTWd-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 10, 2017 at 8:55 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, May 9, 2017 at 12:05 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > https://lkml.org/lkml/2017/3/10/1277
>
> Oh well, that wasn't very useful right now..

Hopefully it comes back eventually. For now, the same contents are also at

https://lwn.net/Articles/716737/

>> TEE driver infrastructure and OP-TEE drivers
>
> Another note: right now this adds a config question for TEE support,
> but the only actual TEE driver has a
>
>         depends on HAVE_ARM_SMCCC
>
> on it.
>
> Until we get more TEE drivers, might I suggest that we perhaps make
> the TEE config option have
>
>         depends on HAVE_ARM_SMCCC || COMPILE_TEST
>
> so that the generic tee code still gets the compile test coverage, but
> we don't confuse people by asking about infrastructure that they can't
> possibly use..
>
> Hmm?

Yes, good idea. I've added this patch to the arm-soc fixes branch that
already contains a couple of other things you will get in a few days:

>From efd467ff4f611d67e9009de2391ce484f9436054 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 10 May 2017 21:05:16 +0200
Subject: [PATCH] tee: add ARM_SMCCC dependency

For the moment, the tee subsystem only makes sense in combination with
the op-tee driver that depends on ARM_SMCCC, so let's hide the subsystem
from users that can't select that.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
index 2330a4eb4e8b..2824398fc5d6 100644
--- a/drivers/tee/Kconfig
+++ b/drivers/tee/Kconfig
@@ -1,6 +1,7 @@
 # Generic Trusted Execution Environment Configuration
 config TEE
  tristate "Trusted Execution Environment support"
+ depends on HAVE_ARM_SMCCC || COMPILE_TEST # until we have more than one driver
  select DMA_SHARED_BUFFER
  select GENERIC_ALLOCATOR
  help
