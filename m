From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Aug 2015 22:30:29 +0100
Subject: [PATCH v5 1/5] arm/arm64: add smccc ARCH32
In-Reply-To: <20150820113729.GA25962@ermac>
References: <1439973629-19505-1-git-send-email-jens.wiklander@linaro.org>
 <1439973629-19505-2-git-send-email-jens.wiklander@linaro.org>
 <20150819165009.GC10297@arm.com> <20150820113729.GA25962@ermac>
Message-ID: <20150820213029.GA1426@svinekod>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 12:37:29PM +0100, Jens Wiklander wrote:
> On Wed, Aug 19, 2015 at 05:50:09PM +0100, Will Deacon wrote:
> > On Wed, Aug 19, 2015 at 09:40:25AM +0100, Jens Wiklander wrote:
> > > Adds helpers to do SMC based on ARM SMC Calling Convention.
> > > CONFIG_HAVE_SMCCC is enabled for architectures that may support
> > > the SMC instruction. It's the responsibility of the caller to
> > > know if the SMC instruction is supported by the platform.

[...]

> > > +       mov     x28, x0
> > > +       ldp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > > +       ldp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > > +       ldp     w4, w5, [x28, #SMC_PARAM_W4_OFFS]
> > > +       ldp     w6, w7, [x28, #SMC_PARAM_W6_OFFS]
> > > +       smc     #0
> > > +       stp     w0, w1, [x28, #SMC_PARAM_W0_OFFS]
> > > +       stp     w2, w3, [x28, #SMC_PARAM_W2_OFFS]
> > > +       ldp     x28, x30, [sp], #16
> > > +       ret
> > > +ENDPROC(smccc_call32)
> > 
> > Could we deal with this like we do for PSCI instead? (see
> > __invoke_psci_fn_smc). We could also then rename psci-call.S to fw-call.S
> > and stick this in there too.
> 
> I assume you're referring to when to use "hvc" and "smc".

I assume he's on about passing the values in registers rather than a struct.

>From the looks of the SMC Calling Convention documentation, it's valid to have
return values in registers r0-r3, which necessitates the use of a struct (at
least for the return values).

Thanks,
Mark.
