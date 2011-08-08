From: robherring2@gmail.com (Rob Herring)
Date: Mon, 08 Aug 2011 13:49:31 -0500
Subject: 3.1-rc1 link failure
Message-ID: <4E402FBB.2070401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

This commit is causing some link failures:

    ARM: vmlinux.lds: move discarded sections to beginning

    Rather than scattering the discarded sections throughout the linker
    file, move them to the start.

    Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
    Tested-by: Stephen Boyd <sboyd@codeaurora.org>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

The error is this:

`.exit.text' referenced in section `.alt.smp.init' of
drivers/built-in.o: defined in discarded section `.exit.text' of
drivers/built
-in.o
`.exit.text' referenced in section `.alt.smp.init' of net/built-in.o:
defined in discarded section `.exit.text' of net/built-in.o

I traced the one in net/ to CONFIG_SMP_ON_UP=y and CONFIG_DCB=y.
dcbnl_exit calls dcb_flushapp which contains a spinlock. dcb_flushapp is
getting inlined into dcbnl_exit.

Rob
