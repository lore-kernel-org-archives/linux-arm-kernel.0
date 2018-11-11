From: robh@kernel.org (Rob Herring)
Date: Sat, 10 Nov 2018 19:40:03 -0600
Subject: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
In-Reply-To: <a4c9f0f8-d7c7-2756-cfdf-b67ce9f1ca3b@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-2-elder@linaro.org>
 <CABGGiswmpmSUmg9jEW7GnNtL2uXAN7jJOqFO5kG8adq71GuZpw@mail.gmail.com>
 <a4c9f0f8-d7c7-2756-cfdf-b67ce9f1ca3b@linaro.org>
Message-ID: <CAL_JsqL=CZR-SMwkk43hfZXcts0FYnsuZASg-RdyzASyMBCGmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 9, 2018 at 4:38 PM Alex Elder <elder@linaro.org> wrote:
>
> On 11/7/18 8:59 AM, Rob Herring wrote:
> > On Tue, Nov 6, 2018 at 6:33 PM Alex Elder <elder@linaro.org> wrote:
> >>
> >> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
> >> device tree nodes.
> >>
> >> Signed-off-by: Alex Elder <elder@linaro.org>
> >> ---
> >>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
> >>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
> >>  2 files changed, 151 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >> new file mode 100644
> >> index 000000000000..d4d3d37df029
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> >> @@ -0,0 +1,136 @@
> >> +Qualcomm IPA (IP Accelerator) Driver
> >
> > Bindings are for h/w not drivers.
>
> OK.  I'll drop " Driver".
>
> >> +
> >> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
> >> +certain network processing tasks (e.g. filtering, routing, and NAT) from
> >> +the main processor.  The IPA currently serves only as a network interface,
> >> +providing access to an LTE network available via a modem.
> >> +
> >> +The IPA sits between multiple independent "execution environments,"
> >> +including the AP subsystem (APSS) and the modem.  The IPA presents
> >> +a Generic Software Interface (GSI) to each execution environment.
> >> +The GSI is an integral part of the IPA, but it is logically isolated
> >> +and has a distinct interrupt and a separately-defined address space.
> >> +
> >> +    ----------   -------------   ---------
> >> +    |        |   |G|       |G|   |       |
> >> +    |  APSS  |===|S|  IPA  |S|===| Modem |
> >> +    |        |   |I|       |I|   |       |
> >> +    ----------   -------------   ---------
> >> +
> >> +See also:
> >> +  bindings/interrupt-controller/interrupts.txt
> >> +  bindings/interconnect/interconnect.txt
> >> +  bindings/soc/qcom/qcom,smp2p.txt
> >> +  bindings/reserved-memory/reserved-memory.txt
> >> +  bindings/clock/clock-bindings.txt
> >> +
> >> +All properties defined below are required.
> >> +
> >> +- compatible:
> >> +       Must be one of the following compatible strings:
> >> +               "qcom,ipa-sdm845-modem_init"
> >> +               "qcom,ipa-sdm845-tz_init"
> >
> > Normal order is <vendor>,<soc>-<ipblock>."
>
> I'll use "qcom,sdm845-ipa-modem-init" and "qcom,sdm845-ipa-tz-init".
> (Or just "qcom,sdm845-ipa", depending on the outcome of the discussion
> below.)
>
> > Don't use '_'.
>
> OK.
>
> > What's the difference between these 2? It can't be detected somehow?
>
> There is some early initialization, including loading some firmware,
> that must be done by trusted code.  That can be done by either Trust
> Zone or the modem.  If it's done by the modem, there is an additional
> step required during initialization so the modem can tell the AP
> that it has done its part, and the AP can finish IPA initialization.
>
> There  is no way of detecting (e.g. by probing hardware) which is
> in effect so we use DT.  I discussed this with Bjorn, who said that
> this was a situation seen elsewhere and that using compatible strings
> was the way he suggested to address it.

Okay. However, if this is common for QCom blocks maybe we should
reconsider. I think compatible makes sense if the programming model
changes.

> > This might be better expressed as a property. Then if Trustzone
> > initializes things, it can just add a property.
>
> A Boolean property to distinguish them would be fine as well, but
> I would like to address this "common" problem consistently.
>
> Bjorn, would you please weigh in?
>
> >> +
> >> +-reg:
> >> +       Resources specyfing the physical address spaces of the IPA and GSI.
> >
> > typo
> >
> >> +
> >> +-reg-names:
> >> +       The names of the address space ranges defined by the "reg" property.
> >> +       Must be "ipa" and "gsi".
> >> +
> >> +- interrupts-extended:
> >
> > Use 'interrupts' here and describe what they are and the order. What
> > they are connected to (and the need for interrupts-extended) is
> > outside the scope of this binding.
>
> I used interrupts-extended because there were two interrupt parents
> (a "normal" interrupt controller and the interrupt controller implemented
> for SMP2P input).  A paragraph here:
>     bindings/interrupt-controller/interrupts.txt
> recommends "interrupts-extended" in that case.
>
> I have no objection to using just "interrupts" but can you tell me what
> I misunderstood?  It seems like I need to do "interrupts-extended".

Yes, in the dts you should use interrupts-extended. However, for
documentation purposes that aspect is not important. So we just use
interrupts most everywhere.

Rob
