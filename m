From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 21 Jun 2016 19:01:27 +0100
Subject: [PATCH 2/2] arm64: dts: Add device-tree for ARM's AEMv8A-AEMv8A
 FVP Base model
In-Reply-To: <20160620145535.GC9246@leverpostej>
References: <1466424796-13769-1-git-send-email-tixy@linaro.org>
 <1466424796-13769-2-git-send-email-tixy@linaro.org>
 <20160620123906.GC26152@leverpostej> <1466433277.2833.33.camel@linaro.org>
 <20160620145535.GC9246@leverpostej>
Message-ID: <1466532087.2856.66.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-06-20 at 15:55 +0100, Mark Rutland wrote:
> On Mon, Jun 20, 2016 at 03:34:37PM +0100, Jon Medhurst (Tixy) wrote:
> > On Mon, 2016-06-20 at 13:39 +0100, Mark Rutland wrote:
> > > Hi,
> > > 
> > > On Mon, Jun 20, 2016 at 01:13:16PM +0100, Jon Medhurst wrote:
> > > > Fixed Virtual Platform (FVP) Base models are simulations of systems
> > > > that resemble Versatile Express or Juno hardware.
> > > > 
> > > > This adds a device-tree for the model variant that has two clusters of
> > > > Architecture Envelope Model (AEM) v8-A CPUs. The peripheral devices that
> > > > are common to all variants of Base models have been placed in a separate
> > > > file (fvp-base.dtsi) to facilitate creating device-trees for other
> > > > models.
> > > > 
> > > > It is desirable to use simulations for code testing purposes and so it
> > > > is beneficial to include nodes for things that are timing and power
> > > > consumption related, even when these don't otherwise have relevance or
> > > > accuracy. Where these have been included here (e.g. idle-states) entries
> > > > have been copied from real hardware platforms such as Juno.
> > > 
> > > Which firmware are you using,
> > 
> > ARM Trusted Firmware
> > 
> > >  and what precisely does it do w.r.t.
> > > those idle states?
> > 
> > I don't know, will check. Those states are also in the ARM TF
> > device-tree for the Base FVP [2] but I admit I didn't verify they were
> > correct. (Unlike real 'hardware' dt nodes, for which I methodically went
> > through documentation and LISA files to check and fix).
> > 
> > [2] https://github.com/ARM-software/arm-trusted-firmware/blob/master/fdts/fvp-base-gicv3-psci.dts
> > 
> > >  Judging by the FVP ATF pm code [1], those state IDs
> > > aren't valid (though perhaps the comment is wrong, or I've misunderstood
> > > something).
> > 
> > I'm not sure which comment you are referring to, that link [1] doesn't
> > seem to anchor to a particular source line in my web browser, and I
> > don't spot anything relevant scanning by eye.
> 
> Aargh, the web interface appears to have given me a duff URL. Let's try
> again [3]. ;)
> 
> The comments note state-ids 0x01, 0x02, and 0x22, which don't appear to
> match the DT. It might be that I've just misunderstood

That function is only compiled when ARM_RECOM_STATE_ID_ENC is true,
which it isn't when I build TF using "make PLAT=fvp ...." so I think
it's a red herring.

When I boot the FVP with my posted device-tree, the core run state icons
on the CLCD window behave as you would expect for CPUs and whole
clusters powering off/on as CPU's activity changes. So idle _looks_ like
it's working OK.

I also put printfs in ATF's psci_cpu_suspend() function and I can see
the values specified in device-tree being passed in and the code
behaving sensibly. From how it cracks the power_state value [4] it
certainly looks like the numbers have the following meanings:

top byte = 0..3 for the 'level' of the power state
top-but-one byte = 0/1 for Standby/Powerdown

For FVP [5], the level appears to be 0=CPU, 1=Cluster.
This matches what's in the device-tree I posted, where we have
0x00010000 for CPU sleep, and 0x01010000 for cluster sleep.

All of which is a long way of saying that I believe the values that the
firmware guys and Linaro have been using for the past year or two are
correct ;-)

> [3] https://github.com/ARM-software/arm-trusted-firmware/blob/6355f2347aec8bf6ad74867c2b0c996e10546ad4/plat/arm/board/fvp/fvp_pm.c#L53

[4] https://github.com/ARM-software/arm-trusted-firmware/blob/6355f2347aec8bf6ad74867c2b0c996e10546ad4/include/bl31/services/psci.h#L100
[5] https://github.com/ARM-software/arm-trusted-firmware/blob/6355f2347aec8bf6ad74867c2b0c996e10546ad4/plat/arm/board/fvp/fvp_pm.c#L195

-- 
Tixy
