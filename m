From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 21 Apr 2014 22:11:07 -0400 (EDT)
Subject: [PATCH 5/5] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAM4voamiJ-HZqz8Rgc-RTCjNRDaw5VQbs6GVfxPDxqCKKhm6XA@mail.gmail.com>
References: <1397239311-27717-1-git-send-email-a.kesavan@samsung.com>
 <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>
 <alpine.LFD.2.11.1404111426510.980@knanqh.ubzr>
 <20140414104116.GA3844@e103592.cambridge.arm.com>
 <alpine.LFD.2.11.1404140956060.980@knanqh.ubzr>
 <20140415083615.GC3596@e103592.cambridge.arm.com>
 <CAM4voamo5iiOQ5P1JyO8kekU6cuxoj4oAT+VpS14LNvWqw_T4g@mail.gmail.com>
 <20140417100302.GB18864@e103592.cambridge.arm.com>
 <CAM4voamiJ-HZqz8Rgc-RTCjNRDaw5VQbs6GVfxPDxqCKKhm6XA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1404212207210.980@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Apr 2014, Abhilash Kesavan wrote:

> Hi Dave,
> 
> On Thu, Apr 17, 2014 at 3:33 PM, Dave Martin <Dave.Martin@arm.com> wrote:
> > On Thu, Apr 17, 2014 at 12:41:31AM +0530, Abhilash Kesavan wrote:
> >> The polling loop in the above function was added to ensure that the
> >> cluster is switched on before we power on the individual cores in
> >> exynos_power_up. This is only required when the first man comes up.
> >
> > Is this only required on power-up, not power-down?  I don't see a call
> > to exynos_cluster_power_control(..., 0), but maybe I'm looking in the
> > wrong place.
> No, you have not missed it. As of now, we are turning on both the L2s
> for 8 core bring-up and then not turning it off (if all 4 cores in the
> clusters are down). Turning the L2 off (A15 L2 mainly) brings in
> significant power savings and I will be looking at adding support for
> this next.

Good.  Please add a comment in the code to that effect in the mean time.

> > I wonder whether this is needed, though.  It imposes a requirement on
> > the OS to waste time polling for the cluster to come online.  Can the
> > hardware not cope with a CPU poweron request being pending already before
> > the cluster is powered on?  If that were possible, there would be no need
> > for an extra poll.
> No, we need to ensure that the cluster L2 is turned On before we can
> turn the core on, the hardware does not handle it.
> >
> > How long do you expect to need to poll for?
> In internal testing when we are turning the cluster on from an off
> state, I have seen the loop being executed 3-4 times occasionally
> during ageing tests. Generally, the status returns as being powered ON
> immediately.

Looping 3-4 times is pretty reasonable.  We certainly can live with 
that.


Nicolas
