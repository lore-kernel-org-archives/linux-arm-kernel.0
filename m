From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 27 Nov 2012 17:02:24 -0500 (EST)
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <50B525AE.8010001@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <alpine.LFD.2.02.1211271157150.4576@xanadu.home> <50B5168A.3080309@gmail.com>
 <50B525AE.8010001@gmail.com>
Message-ID: <alpine.LFD.2.02.1211271652330.4576@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Nov 2012, Rob Herring wrote:

> On 11/27/2012 01:37 PM, Rob Herring wrote:
> > On 11/27/2012 11:19 AM, Nicolas Pitre wrote:
> >> On Sat, 10 Nov 2012, Rob Herring wrote:
> >>
> >>> From: Rob Herring <rob.herring@calxeda.com>
> >>>
> >>> Use the previously unused TPIDRPRW register to store percpu offsets.
> >>> TPIDRPRW is only accessible in PL1, so it can only be used in the kernel.
> >>>
> >>> This saves 2 loads for each percpu variable access which should yield
> >>> improved performance, but the improvement has not been quantified.
> >>>
> >>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> >>
> >> I've just got around to wrap my brain around this patch and the 
> >> discussion that ensued.
> >>
> >> Isn't your patch lacking the preserving and restoring of the TPIDRPRW in 
> >> the suspend and resume paths.
> > 
> > Why yes, you are right. And I noticed the v6 save/restore is missing the
> > user thread ID for v6K as well. I haven't looked closer, but perhaps it
> > is never used.
> 
> Moving the setup from secondary_start_kernel to cpu_init will address
> this. cpu_init is called for both secondary boot and resume of the boot
> cpu. There is no need to save it, we can just reinitialize.

Hmmm.  Agree on not having to save it.  However cpu_init is called a bit 
late in secondary_start_kernel and probably that ought to be moved 
earlier.  It seems to me that a lot of stuff called prior cpu_init has 
the potential to use per CPU variables somewhere.


Nicolas
