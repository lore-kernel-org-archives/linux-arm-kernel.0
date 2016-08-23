From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 11:57:20 -0700
Subject: [PATCH v2 1/4] dt-binding: remoteproc: Introduce ADSP loader
 binding
In-Reply-To: <20160823183121.GA13010@rob-hp-laptop>
References: <1471931866-3107-1-git-send-email-bjorn.andersson@linaro.org>
 <20160823183121.GA13010@rob-hp-laptop>
Message-ID: <20160823185720.GD15161@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 23 Aug 11:31 PDT 2016, Rob Herring wrote:

> On Mon, Aug 22, 2016 at 10:57:43PM -0700, Bjorn Andersson wrote:
> > This document defines the binding for a component that loads firmware
> > and control the life cycle of the Qualcomm ADSP core.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Added platform names to compatibility
> > 
> >  .../devicetree/bindings/remoteproc/qcom,adsp.txt   | 70 ++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > new file mode 100644
> > index 000000000000..3820151ce3e9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.txt
> > @@ -0,0 +1,70 @@
> > +Qualcomm ADSP Peripheral Image Loader
> > +
> > +This document defines the binding for a component that loads and boots firmware
> > +on the Qualcomm ADSP core.
> 
> ADSP is for Audio DSP? So there is another driver for the audio 
> functions? Why doesn't it do the firmware loading? I'm still confused 
> why this binding is separate? If you had one common interface (a rproc) 
> to load and boot various other blocks like ADSP and Venus, then this 
> would make sense. Or does every accel block have some separate control 
> uC associated with it?
> 

The ADSP is a general purpose CPU [1] mainly running services related to
audio handling - including controlling audio paths, driving the audio
blocks, audio effects, audio codec decoding.

On some platforms it also sports services for sensor batch offloading
(or whatever Google calls it) and video decoding for certain codecs.

All these services show up in a semi-probable fashion on other buses;
often on SMD, APR, QRTR.


There are a few blocks that share mechanism with the remoteproc, that
does not have a separate uC - with a destinct life cycle - I'm still
investigating how to describe these, but most likely those cases will
not show up in DT at all.

On msm8916 you have the following additional uCs; RPM, Hexagon, Wireless
and Venus; the RPM is always-on.

On msm8960 we have the following uCs; RPM, Hexagon for audio, DSPS (ARM
for sensor processing), two(?) Hexagons for modem, WCNSS (ARM core for
wireless), Venus (seems to be another ARM core) and an optional ARM core
for GPS if you don't have the modem Hexagons.

So, we have between 4 and 8 extra uCs in these SoCs; most are controlled
in a very similar fashion, but requires different resources and some
tweaks to the steps of bringing them up, down and handling crashes.

Downstream this is handled by having a "rproc" driver that's completely
generic, DT provides lists of resources controlling each step and a
callback mechanism is used to extend the rproc drivers with specific
functionality - it took me months to figure out how to boot the WCNSS
because the logic and resources are scattered throughout.

[1] https://en.wikipedia.org/wiki/Qualcomm_Hexagon

Regards,
Bjorn
