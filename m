From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 09:51:38 +0000
Subject: kernel NULL pointer dereference in pxa_pm_enter (2.6.38-rc2)
In-Reply-To: <1295861380.2044.26.camel@sven>
References: <1295861380.2044.26.camel@sven>
Message-ID: <20110124095138.GC16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 10:29:39AM +0100, Sven Neumann wrote:
> I am still trying to get our Raumfeld platform working with kernels
> newer than 2.6.36 and this morning I've updated to 2.6.38-rc2 to see if
> any of the remaining problems with 2.6.37 have been fixed. Kernel boots
> fine, but it crashes on suspend:

It seems that aae8224d is wrong:

@@ -225,9 +201,6 @@ static int pxa3xx_cpu_pm_valid(suspend_state_t state)
 }

 static struct pxa_cpu_pm_fns pxa3xx_cpu_pm_fns = {
-       .save_count     = SLEEP_SAVE_COUNT,
-       .save           = pxa3xx_cpu_pm_save,
-       .restore        = pxa3xx_cpu_pm_restore,
        .valid          = pxa3xx_cpu_pm_valid,
        .enter          = pxa3xx_cpu_pm_enter,
 };

whereas the generic code does this:

        /* skip registers saving for standby */
        if (state != PM_SUSPEND_STANDBY) {
                pxa_cpu_pm_fns->save(sleep_save);

so, pxa_cpu_pm_fns->save is now a NULL pointer, hence the PC address in
the oops of 0x0.
