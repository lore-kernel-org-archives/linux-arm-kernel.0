From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 14 May 2018 08:42:27 -0600
Subject: [PATCH v2 05/27] dts: bindings: Document device tree binding for
 CATU
In-Reply-To: <CAL_JsqJsZDPHxWA5tax4_ecBtR7Yvhi+DzxQkyh4bpnu1Za0yg@mail.gmail.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-6-git-send-email-suzuki.poulose@arm.com>
 <20180501131057.GA15706@rob-hp-laptop>
 <CANLsYkwzD0gpAo9be5ii4=+tn8GOL6psHcRA24=EMq=MRAzBoQ@mail.gmail.com>
 <8725a726-0733-b0bc-fcf8-4e22399c0e22@arm.com>
 <CAL_JsqJsZDPHxWA5tax4_ecBtR7Yvhi+DzxQkyh4bpnu1Za0yg@mail.gmail.com>
Message-ID: <20180514144227.GA23293@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2018 at 11:05:56AM -0500, Rob Herring wrote:
> On Tue, May 8, 2018 at 10:40 AM, Suzuki K Poulose
> <Suzuki.Poulose@arm.com> wrote:
> >
> >
> > Rob, Mathieu,
> >
> >
> > On 03/05/18 18:42, Mathieu Poirier wrote:
> >>
> >> On 1 May 2018 at 07:10, Rob Herring <robh@kernel.org> wrote:
> >>>
> >>> On Tue, May 01, 2018 at 10:10:35AM +0100, Suzuki K Poulose wrote:
> >>>>
> >>>> Document CATU device-tree bindings. CATU augments the TMC-ETR
> >>>> by providing an improved Scatter Gather mechanism for streaming
> >>>> trace data to non-contiguous system RAM pages.
> >>>>
> >>>> Cc: devicetree at vger.kernel.org
> >>>> Cc: frowand.list at gmail.com
> >>>> Cc: Rob Herring <robh@kernel.org>
> >>>> Cc: Mark Rutland <mark.rutland@arm.com>
> >>>> Cc: Mathieu Poirier <mathieu.poirier@arm.com>
> >>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>> ---
> >>>>   .../devicetree/bindings/arm/coresight.txt          | 52
> >>>> ++++++++++++++++++++++
> >>>>   1 file changed, 52 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt
> >>>> b/Documentation/devicetree/bindings/arm/coresight.txt
> >>>> index 15ac8e8..cdd84d0 100644
> >>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> >>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> >>>> @@ -39,6 +39,8 @@ its hardware characteristcs.
> >>>>
> >>>>                - System Trace Macrocell:
> >>>>                        "arm,coresight-stm", "arm,primecell"; [1]
> >>>> +             - Coresight Address Translation Unit (CATU)
> >>>> +                     "arm, coresight-catu", "arm,primecell";
> >>>
> >>>
> >>> spurious space               ^
> >
> >
> > Thanks for spotting, will fix it.
> >
> >>>
> >>>>
> >>>>        * reg: physical base address and length of the register
> >>>>          set(s) of the component.
> >>>> @@ -86,6 +88,9 @@ its hardware characteristcs.
> >>>>        * arm,buffer-size: size of contiguous buffer space for TMC ETR
> >>>>         (embedded trace router)
> >>>>
> >>>> +* Optional property for CATU :
> >>>> +     * interrupts : Exactly one SPI may be listed for reporting the
> >>>> address
> >>>> +       error
> >>>
> >>>
> >>> Somewhere you need to define the ports for the CATU.
> >
> >
> > The ports are defined common to all the coresight components. Would you
> > like it to be added just for the CATU ?
> 
> Yeah, that's probably how we got into this problem with the port
> numbering in the first place.
> 
> 
> >>>>   Example:
> >>>>
> >>>> @@ -118,6 +123,35 @@ Example:
> >>>>                };
> >>>>        };
> >>>>
> >>>> +     etr at 20070000 {
> >>>> +             compatible = "arm,coresight-tmc", "arm,primecell";
> >>>> +             reg = <0 0x20070000 0 0x1000>;
> >>>> +
> >>>> +                     /* input port */
> >>>> +                     port at 0 {
> >>>> +                             reg =  <0>;
> >>>> +                             etr_in_port: endpoint {
> >>>> +                                     slave-mode;
> >>>> +                                     remote-endpoint =
> >>>> <&replicator2_out_port0>;
> >>>> +                             };
> >>>> +                     };
> >>>> +
> >>>> +                     /* CATU link represented by output port */
> >>>> +                     port at 1 {
> >>>> +                             reg = <0>;
> >>>
> >>>
> >>> While common in the Coresight bindings, having unit-address and reg not
> >>> match is an error. Mathieu and I discussed this a bit as dtc now warns
> >>> on these.
> >>>
> >>> Either reg should be 1 here, or 'ports' needs to be split into input and
> >>> output ports. My preference would be the former, but Mathieu objected to
> >>> this not reflecting the the h/w numbering.
> >>
> >>
> >> Suzuki, as we discuss this is related to your work on revamping CS
> >> bindings for ACPI.  Until that gets done and to move forward with this
> >> set I suggest you abide to Rob's request.
> >
> >
> > Ok, I can change it to <1>, as we don't expect any other output port for an
> > ETR.
> 
> Better let Mathieu confirm he's okay with the first option because he
> wasn't okay with changing the port reg when we discussed. But maybe
> that was just on existing things like TPIU.

I'm good with this one as it is a new component and doesn't change anything
that people could be relying on.

> 
> Rob
