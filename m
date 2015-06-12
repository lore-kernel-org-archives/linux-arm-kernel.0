From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Jun 2015 15:10:30 -0700
Subject: [PATCH v2 6/6] regulator: qcom-spmi: Add vendor specific
 configuration
In-Reply-To: <CAL_JsqL6R5jz1Xhgav0a0SeWqcRT200sofP-G_zQLfDVeqwarA@mail.gmail.com>
References: <1434069427-3642-1-git-send-email-sboyd@codeaurora.org>
 <1434069427-3642-7-git-send-email-sboyd@codeaurora.org>
 <CAL_JsqL6R5jz1Xhgav0a0SeWqcRT200sofP-G_zQLfDVeqwarA@mail.gmail.com>
Message-ID: <20150612221030.GA7854@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11, Rob Herring wrote:
> On Thu, Jun 11, 2015 at 7:37 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > Add support for over current protection (OCP), pin control
> > selection, soft start and soft start strength, auto-mode, input
> > current limiting, and pull down.
> >
> > Cc: <devicetree@vger.kernel.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >
> > Changes from v1:
> > * New patch split from original SPMI regulator driver
> >
> >  .../bindings/regulator/qcom,spmi-regulator.txt     |  62 +++++
> >  drivers/regulator/qcom_spmi-regulator.c            | 298 ++++++++++++++++++++-
> >  2 files changed, 358 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > index 75b4604bad07..ab01a152e930 100644
> > --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.txt
> > @@ -99,6 +99,68 @@ see regulator.txt - with additional custom properties described below:
> >                     soft start are active all the time. 0 = Set initial mode to
> >                     low power mode (LPM).
> >
> > +- qcom,auto-mode-enable:
> 
> Auto regulator modes are fairly common. Can't we have a common property here?
> 
> > +       Usage: optional
> > +       Value type: <u32>
> 
> This can be bool. Unless we want to have a mode property with "auto"
> being one possible value.

>From what I can tell we use this property as qcom,auto-mode-enable = <0>.
Put another way, that's qcom,auto-mode-disable. Should we have two
properties? Or is it better to mark all regulators explicitly with
either auto-mode-enable or the absence of such a property? The bindings
take an approach of giving all these "boolean" properties a 0 or 1 value
so that the absence of the property indicates that we should use the
default value in the hardware.

> 
> > +       Description: 1 = Enable automatic hardware selection of regulator
> > +                        mode (HPM vs LPM); not available on boost type
> > +                        regulators. 0 = Disable auto mode selection.
> > +
> > +- qcom,ocp-enable:
> > +       Usage: optional
> > +       Value type: <u32>
> > +       Description: 1 = Allow over current protection (OCP) to be enabled for
> > +                    voltage switch type regulators so that they latch off
> > +                    automatically when over current is detected. OCP is
> > +                    enabled when in HPM or auto mode.  0 = Disable OCP.
> 
> This seems common too.

Ok. I'll make up another patch for this one. Perhaps call it
regulator-over-current-protection?

> 
> > +
> > +- qcom,ocp-max-retries:
> > +       Usage: optional
> > +       Value type: <u32>
> > +       Description: Maximum number of times to try toggling a voltage switch
> > +                    off and back on as a result of consecutive over current
> > +                    events.
> > +
> > +- qcom,ocp-retry-delay:
> > +       Usage: optional
> > +       Value type: <u32>
> > +       Description: Time to delay in milliseconds between each voltage switch
> > +                    toggle after an over current event takes place.
> 
> These 2 are perhaps less common. I hope I don't have a device that does this. :)
> 

:)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
