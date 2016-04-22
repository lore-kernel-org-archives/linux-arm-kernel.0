From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Apr 2016 09:54:31 -0700
Subject: [PATCH v2.1 1/9] dt-binding: remoteproc: Introduce Qualcomm
 WCNSS loader binding
In-Reply-To: <CAL_JsqLgehfMVXgDQdHaC6SJ7MU3oRKFn4ogLbtgp_31keX95g@mail.gmail.com>
References: <1459222625-11440-2-git-send-email-bjorn.andersson@linaro.org>
 <1461259256-28529-1-git-send-email-bjorn.andersson@linaro.org>
 <CAL_JsqLgehfMVXgDQdHaC6SJ7MU3oRKFn4ogLbtgp_31keX95g@mail.gmail.com>
Message-ID: <20160422165431.GC3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 09:22 PDT 2016, Rob Herring wrote:

> On Thu, Apr 21, 2016 at 12:20 PM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> >
> > The document defines the binding for a component that loads firmware for
> > and boots the Qualcomm WCNSS core.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > Rob,
> >
> > I got your Ack on v2, but I would like to make a small amendment before merging
> > this.
> >
> >
> > As we discussed related to the WiFi binding I should reference the mmio
> > registers by a phandle to a DT node specifying the two necessary register
> > blocks (ccu & dxe).
> >
> > These two register blocks are part of the riva/pronto (the two major versions)
> > subsystem, that also contains the "pmu" register block, which is what I access
> > here.
> >
> > Further more, the ccu block contains valuable information for debugging
> > purposes that the implementation of this binding would find useful.
> >
> >
> > I would therefor like to double this node (in the dts) as both the
> > riva/pronto-pil and the target for the mmio phandle reference from the WiFi
> > node.
> >
> > This works fine, but unless using reg-names for defining the order or the regs
> > I get a messy ordering dependency between the two bindings. I do not know which
> > of the other 7-8 register blocks we will add for debugging, but with the below
> > change I can keep them in block order regardless of the order we implement them
> > in.
> 
> You should know based on the compatible string what the number and
> order of register ranges are. reg is not something we want evolving
> over time.
> 

At best I can make an educated guess based on some downstream debug code
on what regs we do have. But I've already found two of the ranges being
incorrect.

> > So, can I update the "reg" and add "reg-names" as below to the binding and
> > depend on reg-names for the ordering of reg? Or should I speculatively add all
> > ranges I know of to keep the order sane?
> 
> I'm okay with using this for convenience of the client not having to
> care which compatible the block is, but the above should still be met.
> 

Okay, I will throw in the 3 I know for now, saying those are required.
And then we add the debug regions as optionals after those, based on
which ones we need. Hopefully I haven't missed any required regions...

> Also, you could add a cell which is the index to the register range you need.
> 

I'm afraid I feel that is just reimplementing reg-names, for the sake of
not using reg-names.


Thanks for your answer, I'll spin the two bindings and send them about
again.

Regards,
Bjorn
