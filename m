From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Sep 2013 14:45:16 +0100
Subject: Inte IOP Xscale updates
In-Reply-To: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
References: <CACRpkdZU5mVU15AK=m-BRmpizKJJVAR98JKf3Qcgy2ms+HG+Hw@mail.gmail.com>
Message-ID: <20130903134516.GH6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 02:01:45PM +0200, Linus Walleij wrote:
> Hi XScale folks,
> 
> I haven't really seen any functional patches or confirmation that the
> XScale machines in arch/arm/iop* are even booting since 2010 or
> so.
> 
> Can you confirm that you boot-test these machines regularly?
> 
> I am worried that we maintain code that is not used or even working
> see.
> 
> What are your thought about multiplatform and device tree? I am
> pretty certain that if the iop machines were converted to device tree
> we could collapse these machines into one directory with few files,
> but I may be wrong.

Just because code doesn't get touched doesn't mean it doesn't work.  In
some cases, that means that the code has reached stability.

The IOP platforms are in regular use.  IOP platforms include such
things as TheCUS machines such as the N2100 and others.  The two N2100s
I have here run 3.1.8 and 3.9.5.  3.9.5 did not require any changes to
arch/arm code for it to work - though it did require a minor change
to the IOP watchdog driver so it would build, namely:

diff --git a/drivers/watchdog/iop_wdt.c b/drivers/watchdog/iop_wdt.c
index d964faf..3841120 100644
--- a/drivers/watchdog/iop_wdt.c
+++ b/drivers/watchdog/iop_wdt.c
@@ -234,7 +234,7 @@ static int __init iop_wdt_init(void)
        /* Configure Watchdog Timeout to cause an Internal Bus (IB) Reset
         * NOTE: An IB Reset will Reset both cores in the IOP342
         */
-       write_wdtsr(IOP13XX_WDTCR_IB_RESET);
+//     write_wdtsr(IOP13XX_WDTCR_IB_RESET);
 
        /* Register after we have the device set up so we cannot race
           with an open */
