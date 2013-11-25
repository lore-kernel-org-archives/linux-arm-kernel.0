From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 25 Nov 2013 17:09:51 +0000
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <alpine.LFD.2.10.1311251142390.9667@knanqh.ubzr>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
 <alpine.LFD.2.10.1311251142390.9667@knanqh.ubzr>
Message-ID: <20131125170951.GB2302@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 11:44:45AM -0500, Nicolas Pitre wrote:
> On Mon, 25 Nov 2013, Dave Martin wrote:
> 
> > This patch implements the power_down_finish() method for TC2, to
> > enable the kernel to confirm when CPUs are safely powered down.
> > 
> > The information required for determining when a CPU is parked
> > cannot be obtained from any single place, so a few sources of
> > information must be combined:
> > 
> >   * mcpm_cpu_power_down() must be pending for the CPU, so that we
> >     don't get confused by false STANDBYWFI positives arising from
> >     CPUidle.  This is detected by waiting for the tc2_pm use count
> >     for the target CPU to reach 0.
> > 
> >   * Either the SPC must report that the CPU has asserted
> >     STANDBYWFI, or the TC2 tile's reset control logic must be
> >     holding the CPU in reset.
> > 
> >     Just checking for STANDBYWFI is not sufficient, because this
> >     signal is not latched when the the cluster is clamped off and
> >     powered down: the relevant status bits just drop to zero.  This
> >     means that STANDBYWFI status cannot be used for reliable
> >     detection of the last CPU in a cluster reaching WFI.
> > 
> > This patch is required in order for kexec to work with MCPM on TC2.
> > 
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > Acked-by: Pawel Moll <pawel.moll@arm.com>
> 
> I thought I provided it before, but here it is again:
> 
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Hmm, I may have lost that somewhere ... apologies if so.

To avoid extra noise, I will leave it the committer to add this if they
want (unless I need to repost for some other reason).

> > Since there is now an interface break, it would be good if this patch
> > can be merged as a fix in the 3.13 cycle.  This code is specific to
> > vexpress TC2 and won't affect any other platform.
> 
> I agree to this as well.

Thanks
---Dave
