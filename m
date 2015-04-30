From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 30 Apr 2015 23:25:49 +0800
Subject: [PATCH] ARM: imx6: initialize CCM_CLPCR_LPM into RUN mode earlier
In-Reply-To: <CANMBJr47q9uhdEFgogmdwwbLoFzkcX5SnN6oeaEEkXTnXq3PWg@mail.gmail.com>
References: <1430287119-5268-1-git-send-email-shawn.guo@linaro.org>
 <CANMBJr47q9uhdEFgogmdwwbLoFzkcX5SnN6oeaEEkXTnXq3PWg@mail.gmail.com>
Message-ID: <20150430152547.GC20956@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 01:43:39PM -0700, Tyler Baker wrote:
> On 28 April 2015 at 22:58, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Commit 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> > moves imx6_set_lpm() from clock init function into
> > imx6_pm_common_init().  This causes a hang when cpuidle support is
> > enabled.  The reason for that is ARM core clock is shut down
> > unexpectedly by WAIT mode.  It happens with the following call stack:
> >
> >     cpuidle_register_governor()
> >         cpuidle_switch_governor()
> >             cpuidle_uninstall_idle_handler()
> >                 synchronize_sched()
> >                     wait_rcu_gp()
> >                         wait_for_completion()
> >
> > When wait_for_completion() is called as above, all cores are idle/WFI.
> > Hence, the reset value of CCM_CLPCR_LPM - WAIT mode, will trigger a
> > hardware shutdown of the ARM core clock.
> >
> > To fix the regression, we need to ensure that CCM_CLPCR_LPM is
> > initialized into RUN mode earlier than cpuidle governor registration,
> > which is a postcore_initcall.  This patch creates function
> > imx6_pm_ccm_init() to map CCM block and initialize CCM_CLPCR_LPM into
> > RUN mode, and have the function called from machine .init_irq hook,
> > which should be early enough.
> >
> > Reported-by: Kevin Hilman <khilman@kernel.org>
> > Fixes: 4631960d26da ("ARM: imx6: set initial power mode in pm function")
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Tested-by: Tyler Baker <tyler.baker@linaro.org>
> 
> I have applied this patch on top of next-20150429[1] and build/boot
> tested it with the kernelci.org farm. With these results[2], I can
> confirm the IMX6 boot regression reported is fixed by this patch.

Thanks for testing, Tyler.  I added your test tag to the patch.

Shawn
