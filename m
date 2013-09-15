From: grant.likely@linaro.org (Grant Likely)
Date: Sun, 15 Sep 2013 13:43:25 +0100
Subject: [PATCH] memory: add a basic OF-based memory driver
In-Reply-To: <CAOesGMj=b5c_1v-nAejUzuOMfx44AHr2=yfoPepHYsh0=t0wOQ@mail.gmail.com>
References: <1378863781-4235-1-git-send-email-emilio@elopez.com.ar>
 <1379032225-6425-1-git-send-email-emilio@elopez.com.ar>
 <CAOesGMiUMniKRLRgGPsimR0bXWQFbx+SL5dUJXOb8t0JfEcHsg@mail.gmail.com>
 <52326ADC.8040703@elopez.com.ar>
 <CAL_JsqJACEtSRaDg0TcYODzhpsHFGa4mFSYa_R3qspypEKH+hQ@mail.gmail.com>
 <CAOesGMj=b5c_1v-nAejUzuOMfx44AHr2=yfoPepHYsh0=t0wOQ@mail.gmail.com>
Message-ID: <20130915124325.B1DF2C42C5C@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Sep 2013 08:49:06 -0700, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Sep 13, 2013 at 7:00 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On Thu, Sep 12, 2013 at 8:31 PM, Emilio L??pez <emilio@elopez.com.ar> wrote:
> >> Hi Olof,
> >>
> >> El 12/09/13 21:57, Olof Johansson escribi??:
> >>
> >>> On Thu, Sep 12, 2013 at 5:30 PM, Emilio L??pez <emilio@elopez.com.ar>
> >>> wrote:
> >>>>
> >>>> This driver's only job is to claim and ensure the necessary clock
> >>>> for memory operation on a DT-powered machine remains enabled.
> >>>>
> >>>> Signed-off-by: Emilio L??pez <emilio@elopez.com.ar>
> >>>> ---
> >>>>
> >>>> I believe this new patch should resolve all the concerns raised; as
> >>>> always, all feedback is welcome :)
> >>>
> >>>
> >>> I think you're going about this the wrong way.
> >>>
> >>> If you have a problem with a clock not staying on, shouldn't you just
> >>> marking it appropriately in the clock table instead, making sure it's
> >>> initialized with at least one reference to it?
> >>
> >>
> >> If by "the clock table" you mean the tree as handled by the common clock
> >> framework, there is no such flag available as of today; see Mike's reply for
> >> more information.
> >>
> >> Personally I feel that if the general case can solve our problems (in this
> >> case, having a consumer who prepares and enables the clock), we should avoid
> >> adding special cases to the framework.
> >>
> >>
> >>> I believe that is how
> >>> some of the other platforms handle this, and it's a lot cleaner than
> >>> adding a fake binding and a fake driver just to grab a single clock.
> >>
> >>
> >> The binding doesn't have to be fake; it is actually describing the memory
> >> controller hardware:
> >>
> >> mc: mc at 0123000 {
> >>         compatible = "simple-memory-controller";
> >>         reg = <0x0123000 0x400>;
> >>         clocks = <&pll5 1>;
> >> };
> >>
> >> If one day we get docs and/or have any special features we may need from the
> >> controller, we can use something like
> >>
> >> mc: mc at 0123000 {
> >>         compatible = "vendor,awesome-mc", "simple-memory-controller";
> >>         reg = <0x0123000 0x400>;
> >>         clocks = <&pll5 1>;
> >> };
> >
> > Better, but this is still wrong. DT describes the hardware. There is
> > no such h/w as a simple-memory-controller. The fact that you have a
> > simple-memory-ctrlr kernel driver is a kernel
> > feature/artifact/limitation. Describe the h/w with a meaningful
> > compatible string and put that string in the simple memory controller
> > driver match table. If someday we have a real driver for said memory
> > controller, then it is only a kernel change to use a different driver.
> 
> 
> We discussed this over IRC last night -- I still think it makes more
> sense to make the clock driver for sunxi aware of this and just add a
> reference to the clock at init time.
> 
> This is never going to differ from board to board (today the clock
> name is the same on all sunxi platforms -- pll5_ddr. And the need will
> likewise be there for all platforms at this time.
> 
> If and when it changes in the future, we can reevaluate. But this
> doesn't have to be driven by device tree at this time, it seems to
> just make things overly complicated and contrived.

I agree. Creating a new platform driver + device tree binding just to
claim a clock that must not be disables does not look like the right
approach to me either.

g.
