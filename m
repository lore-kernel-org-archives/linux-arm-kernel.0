From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 17 Apr 2014 10:59:33 +0100
Subject: [PATCH 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAM4voa=-29EsNRCebri1C9D5cWopTT4Ux_0UPGAvdjP60ADZZQ@mail.gmail.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111426510.980@knanqh.ubzr>
 <20140414104116.GA3844@e103592.cambridge.arm.com>
 <CAM4voa=-29EsNRCebri1C9D5cWopTT4Ux_0UPGAvdjP60ADZZQ@mail.gmail.com>
Message-ID: <20140417095925.GA18864@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 12:41:22AM +0530, Abhilash Kesavan wrote:

[...]

> > The fact that there is no C interface for enabling ACE ports is
> > deliberate.  For CPUs connected to ACE and managed via MCPM,
> > it is incorrect to enable CCI via C code, since the safe window
> > is the window during which all outbound CPUs have reached CLUSTER_DOWN
> > and all inbound CPUs have not turned their MMU on yet (and thus cannot
> > execute any general Linux C code).
> >
> > There might be scenarios involving GPUs and other non-CPU devices
> > connected to ACE ports where the device cannot enable CCI snoops
> > for itself -- but this would require a holding-pen protocol to enable
> > the device to wait and signal a CPU to enable CCI snoops on the device's
> > behalf before the device proceeds.  It is not the correct solution for
> > CPU clusters attached to ACE, precisely because we can be more efficient
> > in that case.
> >
> > In fact, because you implement a power_up_setup method that calls
> > cci_enable_port_for_self, CCI snoops are actually enabled twice, making
> > the above code appear redundant.   Have I missed something?
> When a cluster is being turned off the snoops for both the clusters
> are being turned off. When the other cluster comes back the snoops are
> being turned on for the incoming cluster via power_up_setup and here
> for the other cluster. As previously mentioned, I will be dropping
> this change.

That's a fair point.  If there is only one cluster alive, turning off
snoops for it should be safe, because there is no second cluster for
it to maintain coherency with.

I don't know whether CCI would ever send a snoop back to the same cluster
that requested it, so it is unclear to me whether turning off snoops for
the last cluster would provide significant power/latency benefits.  But
it could be worth investigating.  Have you done any measurements?

If you have a coherent DMA/CLCD controller or GPU connected to an
ACE-Lite support on CCI however, you would need to leave the last
cluster's snoops enabled to that the other coherent masters can contine
to shoop the cluster's caches.

It might be worth thinking about addressing some of these issues as
future generic improvement, but I suggest to leave it out of your
current patches for simplicity.

Cheers
---Dave
