From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 21 Feb 2011 15:56:57 +0530
Subject: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
In-Reply-To: <AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-15-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTik-hj+-ZPnfVKLCH0h-QeyziH4H-j6EE+_QHHCU@mail.gmail.com>
Message-ID: <6176616fe77333f80f0cfaae4fc8aff3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jean Pihet [mailto:jean.pihet at newoldbits.com]
> Sent: Monday, February 21, 2011 3:49 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; linux-arm-
> kernel at lists.infradead.org; Rajendra Nayak
> Subject: Re: [PATCH 14/17] omap4: cpuidle: Add MPUSS RET OFF states
>
> Hi Santosh,
>
[...]

>
> > + * cpuidle CORE retention support.
> > + * Currently only MPUSS latency numbers are added based on
> > + * measurements done internally. The numbers for MPUSS are
> > + * not board dependent and hence set directly here instead of
> > + * passing it from board files.
> > + */
> > ?static struct cpuidle_params cpuidle_params_table[] = {
> > - ? ? ? /* C1 */
> > - ? ? ? {1, 2, 2, 5},
> > + ? ? ? /* C1 - CPU0 WFI + CPU1 ON/OFF + MPU ON ? + CORE ON */
> > + ? ? ? {1, ? ? 2, ? ? ?2, ? ? ?5},
> > + ? ? ? /* C2 - CPU0 ON + CPU1 OFF + MPU ON ?+ CORE ON */
> > + ? ? ? {1, ? ? 140, ? ?160, ? ?300},
> > + ? ? ? /* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
> > + ? ? ? {1, ? ? 200, ? ?300, ? ?700},
> > + ? ? ? /* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
> > + ? ? ? {1, ? ? 1400, ? 600, ? ?5000},
> > ?};
> >
> > +DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
> > +
> > +static int omap4_idle_bm_check(void)
> > +{
> > + ? ? ? /* FIXME: Populate this with CORE retention support */
> > + ? ? ? return 0;
> > +}
> > +
> > ?/**
> > ?* omap4_enter_idle - Programs OMAP4 to enter the specified state
> > ?* @dev: cpuidle device
> > @@ -57,7 +92,9 @@ static struct cpuidle_params
> cpuidle_params_table[] = {
> > ?static int omap4_enter_idle(struct cpuidle_device *dev,
> > ? ? ? ? ? ? ? ? ? ? ? ?struct cpuidle_state *state)
> > ?{
> > + ? ? ? struct omap4_processor_cx *cx =
> cpuidle_get_statedata(state);
> > ? ? ? ?struct timespec ts_preidle, ts_postidle, ts_idle;
> > + ? ? ? u32 cpu1_state;
> >
> > ? ? ? ?/* Used to keep track of the total time in idle */
> > ? ? ? ?getnstimeofday(&ts_preidle);
> > @@ -65,28 +102,74 @@ static int omap4_enter_idle(struct
> cpuidle_device *dev,
> > ? ? ? ?local_irq_disable();
> > ? ? ? ?local_fiq_disable();
> >
> > - ? ? ? cpu_do_idle();
>
> I think the piece of code below is rather difficult to read and
> understand. Based on the patch description and the comment here
> below
> I do not see the relation with the code.
>
There is relation. The comments are as per the conditions. And
The hardware constraint is back-ground behind the conditions.

> " On OMAP4 because of hardware constraints, no low power states are
>  targeted when both CPUs are online and in SMP mode. The low power
>  states are attempted only when secondary CPU gets offline to OFF
>  through hotplug infrastructure. "
> The test below does not seem to match this comment.
>
> > + ? ? ? /*
> > + ? ? ? ?* Special hardware/software considerations:
> > + ? ? ? ?* 1. Do only WFI for secondary CPU(non-boot - CPU1).
> > + ? ? ? ?* ? ?Secondary cores are taken down only via hotplug
> path.
> The comment looks contradictory. Which one is taken OFF using this
> code, which one from hotplug?
> Does this correspond to the condition '(dev->cpu)' in the test
> below?

Yes.
>
> > + ? ? ? ?* 2. Do only a WFI as long as in SMP mode.
> Does this correspond to the condition '(num_online_cpus() > 1)' in
> the
> test below? If so it this one triggering the low power mode for
> cpu0?
yes
>
> > + ? ? ? ?* 3. Continue to do only WFI till CPU1 hits OFF state.
> > + ? ? ? ?* ? ?This is necessary to honour hardware recommondation
> > + ? ? ? ?* ? ?of triggeing all the possible low power modes once
> CPU1 is
> > + ? ? ? ?* ? ?out of coherency and in OFF mode.
> Does this correspond to the condition '(cpu1_state !=
> PWRDM_POWER_OFF)' in the test below?
>
Yes

> > + ? ? ? ?* Update dev->last_state so that governor stats reflects
> right
> > + ? ? ? ?* data.
> > + ? ? ? ?*/
> > + ? ? ? cpu1_state = pwrdm_read_pwrst(cpu1_pd);
> > + ? ? ? if ((dev->cpu) || (num_online_cpus() > 1) ||
> > + ? ? ? ? ? ? ? ? ? ? ? (cpu1_state != PWRDM_POWER_OFF)) {
> Are '||' correct here?
Yes.

> Sorry if the code behaves correctly, the remarks are about
> readability especially in the comments.
>
You got all three correct. Instead of having three If's doing
same thing I have merged them and added comments above.

And you got all of them correctly.

Regards,
Santosh
