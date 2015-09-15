From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 19:26:45 +0100
Subject: [PATCH v5 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <20150914083029.GA13963@ermac>
References: <1439973629-19505-1-git-send-email-jens.wiklander@linaro.org>
 <1439973629-19505-2-git-send-email-jens.wiklander@linaro.org>
 <20150819165009.GC10297@arm.com> <20150820113729.GA25962@ermac>
 <20150821092430.GC30930@arm.com> <20150821114331.GA11701@ermac>
 <20150914083029.GA13963@ermac>
Message-ID: <20150915182645.GQ31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 09:30:30AM +0100, Jens Wiklander wrote:
> On Fri, Aug 21, 2015 at 01:43:31PM +0200, Jens Wiklander wrote:
> > On Fri, Aug 21, 2015 at 10:24:30AM +0100, Will Deacon wrote:
> > > On Thu, Aug 20, 2015 at 12:37:29PM +0100, Jens Wiklander wrote:
> > > > On Wed, Aug 19, 2015 at 05:50:09PM +0100, Will Deacon wrote:
> > > > > On Wed, Aug 19, 2015 at 09:40:25AM +0100, Jens Wiklander wrote:
> > > > > > +       mov     x28, x0
> > > > > > +       ldp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > > > > > +       ldp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > > > > > +       ldp     w4, w5, [x28, #SMC_PARAM_W4_OFFS]
> > > > > > +       ldp     w6, w7, [x28, #SMC_PARAM_W6_OFFS]
> > > > > > +       smc     #0
> > > > > > +       stp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > > > > > +       stp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > > > > > +       ldp     x28, x30, [sp], #16
> > > > > > +       ret
> > > > > > +ENDPROC(smccc_call32)
> > > > > 
> > > > > Could we deal with this like we do for PSCI instead? (see
> > > > > __invoke_psci_fn_smc). We could also then rename psci-call.S to fw-call.S
> > > > > and stick this in there too.
> > > > 
> > > > I assume you're referring to when to use "hvc" and "smc".
> > > 
> > > No, I mean use a C prototype to avoid marshalling the parameters in assembly
> > > like this. As Rutland pointed out, the return value is a bit messy, but
> > > the arguments align nicely with the PCS afaict.
> > 
> > If possible I'd like the function to have the same prototype for both
> > arm and arm64. For arm it's not possible to supply more than 4
> > parameters. To fully support SMC Calling Convention we need to be able
> > to pass 8 parameters and have 4 return values. The OP-TEE driver in this
> > patch set depends on this. I don't see how we can avoid the marshalling
> > here.
> > 
> > We could have two versions of the SMCCC functions, one simplified which
> > only uses registers and one complete like this one with marshalling.
> 
> Will, what do think about this?

I still think you should make use of a C prototype to avoid explicit
parameter marshalling in assembly. If you want to maintain a compatible
API between arm and arm64, then you can easily have an intermediate
function in arm64 that sits between the API entry point and the assembly.

Will
