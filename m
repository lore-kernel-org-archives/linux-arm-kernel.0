From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 23 Apr 2016 12:33:51 -0500
Subject: [PATCH 1/8] dt/bindings: firmware: Add Qualcomm SCM binding
In-Reply-To: <CAL_JsqK0LYCozBohs5QCvuPRR-3s2SMHf7DgwSyVe4Vyeyw9ew@mail.gmail.com>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-2-git-send-email-andy.gross@linaro.org>
 <CAL_JsqK0LYCozBohs5QCvuPRR-3s2SMHf7DgwSyVe4Vyeyw9ew@mail.gmail.com>
Message-ID: <20160423173351.GA3246@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 23, 2016 at 11:56:50AM -0500, Rob Herring wrote:
> On Fri, Apr 22, 2016 at 5:17 PM, Andy Gross <andy.gross@linaro.org> wrote:
> > This patch adds the device tree support for the Qualcomm SCM firmware.
> >
> > Signed-off-by: Andy Gross <andy.gross@linaro.org>
> > ---
> >  .../devicetree/bindings/firmware/qcom,scm.txt      | 31 ++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/firmware/qcom,scm.txt
> >
> > diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> > new file mode 100644
> > index 0000000..57b9b3a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
> > @@ -0,0 +1,31 @@
> > +QCOM Secure Channel Manager (SCM)
> > +
> > +Qualcomm processors include an interface to communicate to the secure firmware.
> > +This interface allows for clients to request different types of actions.  These
> > +can include CPU power up/down, HDCP requests, loading of firmware, and other
> > +assorted actions.
> > +
> > +Required properties:
> > +- compatible: must contain one of the following:
> > + * "qcom,scm-apq8064" for APQ8064
> > + * "qcom,scm-apq8084" for MSM8084
> > + * "qcom,scm-msm8916" for MSM8916
> > + * "qcom,scm-msm8974" for MSM8974
> > +- clocks: One to three clocks may be required based on compatible.
> > + * Only core clock required for "qcom,scm-apq8064"
> > + * Core, iface, and bus clocks required for all other compatibles.
> > +- clock-names: Must contain "core" for the core clock, "iface" for the interface
> > +  clock and "bus" for the bus clock per the requirements of the compatible.
> > +
> > +Example for MSM8916:
> > +
> > +       firmware {
> > +               compatible = "simple-bus";
> 
> Firmware is a bus? Really? Let's not put hacks in the DT just so you
> get automatic probing.

So something like:

        firmware {
                compatible = "qcom,scm-apq8084";
                clocks = <&gcc GCC_CE1_CLK> , <&gcc GCC_CE1_AXI_CLK>, <&gcc GCC_CE1_AHB_CLK>;
                clock-names = "core", "bus", "iface";
        };

Seems to work fine.

> > +
> > +               scm {
> > +                       compatible = "qcom,scm-msm8916";
> > +                       clocks = <&gcc GCC_CRYPTO_CLK> , <&gcc GCC_CRYPTO_AXI_CLK>, <&gcc GCC_CRYPTO_AHB_CLK>;
> > +                       clock-names = "core", "bus", "iface";
> 
> Generally, /firmware defines an interface to firmware. I don't think
> clocks belong here. This implies that non-secure world can turn off
> clocks to secure world?

The caller into the SCM is on the hook for making sure the clocks are turned on.
The firmware people decided to not manage the clocks.  In a perfect world, they
would turn on their own clocks and it would all be self contained.  Sadly, it
isn't going to change.

The alternative is every device that makes scm calls needs to manage the clocks
for the firmware.
