From: rtivy@ti.com (Tivy, Robert)
Date: Sat, 1 Dec 2012 02:11:28 +0000
Subject: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
 OMAP-L138 DSP
In-Reply-To: <50B88F7C.5000705@ti.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-5-git-send-email-rtivy@ti.com> <50AB76FA.1050505@ti.com>
 <13514BD7FAEBA745BBD7D8A672905C14311F952B@DFLE08.ent.ti.com>
 <50B88F7C.5000705@ti.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311FAC29@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

> -----Original Message-----
> From: Nori, Sekhar
> Sent: Friday, November 30, 2012 2:51 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support for
> OMAP-L138 DSP
> 
> Hi Rob,
> 
> On 11/29/2012 7:08 AM, Tivy, Robert wrote:
> > Hi Sekhar,
> >
> > Please see comments and noob questions below...
> >
> >> -----Original Message-----
> >> From: Nori, Sekhar
> >> Sent: Tuesday, November 20, 2012 4:27 AM
> >> To: Tivy, Robert
> >> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> >> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark
> >> Subject: Re: [PATCH v3 5/6] ARM: davinci: remoteproc board support
> >> for
> >> OMAP-L138 DSP
> >>
> >> On 11/14/2012 6:03 AM, Robert Tivy wrote:
> >>> Requires CMA services.
> >>>
> >>> New 'clk_reset()' API added so that the DSP's reset state can be
> >>> toggled separately from its enable/disable operation.
> >>
> >> But we cannot add a private clk_ API without it being defined in
> >> include/linux/clk.h. So, this requires wider alignment.
> >>
> >> And I am not sure clock API should be extended to support reset
> since
> >> "resetting a clock" does not make a lot of sense. On DaVinci, clock
> >> gating and reset are handled by the same module, but that need not
> >> always be the case.
> >>
> >> What you need is a way to reset an IP. I do not know of an existing
> >> framework to do this; likely a new API needs to be created. I am
> >> guessing this never existed so far because most of the IPs can be
> >> reset internally (by writing a bit within its own register space). I
> >> guess DSP is different since its actually a co-processor and may not
> >> have such a bit.
> >>
> >> How about simulating a reset by making the DSP jump to its reset
> >> address. While I am sure its not quite the same as resetting the DSP
> >> using PSC, may be it could be used while you wait for consensus
> >> around handling module reset in kernel?
> >
> > Since the ARM can't write the DSP's program counter I suspect such a
> temporary solution is not possible.
> 
> Okay. I think the way forward on this is to start a separate thread
> including the ARM list, LKML and the remoteproc folks to see if it
> makes sense to create a reset API in kernel. You can describe the
> usecase you have.

Instead of fighting that fight, I thought of another way.  The da8xx_dsp platform_device has private data registered in its device struct.  This private data can contain a function pointer for a "DSP reset" function, and davinci_remoteproc.c can call the registered function.  Does that sound OK?

Regards,

- Rob
