From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 11 Nov 2014 10:39:32 -0800
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <20141111115959.GY24004@x1>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
 <20141111115959.GY24004@x1>
Message-ID: <20141111183815.GF16980@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 11 Nov 03:59 PST 2014, Lee Jones wrote:

> On Mon, 10 Nov 2014, Bjorn Andersson wrote:
> 
> > Some regulators are used to power e.g. PLLs that clocks the core we're
> > running on, so we can't turn them off directly; but we do want them off
> > when the core is powered down. To handle this the Qualcomm SoC provides
> > a means to specify a "sleep state" for RPM resources that can be
> > triggered by the hardware when the cores are brought down.
> > 
> > Resources of this type should be considered always-on while the CPU(s)
> > are running and we can utilize the "sleep state" functionality to defer
> > disabling them until the CPU(s) go to sleep, if not used by other
> > peripherals at that time.
> > 
> > Other properties are kept in sync between the states, so that if the
> > CPU(s) go to sleep with a particular regulator still enabled there will
> > be no change.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++
> 
> Please place this into a seperate patch.
> 
> See: Documentation/devicetree/bindings/submitting-patches.txt
> 

Yes, I'm aware. As you probably remember we still haven't gotten an ack on the
original file, so given the outcome of the discussion of the design of this I
plan to fold it into the original patch and send out a new version.

> >  drivers/regulator/qcom_rpm-regulator.c             |   68 +++++++++++++++-----
> >  2 files changed, 79 insertions(+), 17 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > index 4264021..4671eef 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > @@ -112,6 +112,13 @@ of valid subnodes that can operate on these resources.
> >  	Definition: select that the power supply should operate in hysteretic
> >  		    mode, instead of the default pwm mode
> >  
> > +- qcom,rpm-assisted-disable:
> > +	Usage: optional
> > +	Value type: <empty>
> > +	Definition: select that the regulator is supplying the active CPU(s)
> > +		    and can only be disabled with the assistans from the RPM
> > +		    after going to sleep
> > +
> 
> This requires a DT Ack.
> 

The entire file still requires a dt ack, but the "sleep state" will change the
binding so let's see where this RFC takes us.

I would have preferred if someone gave me the "sleep state" feedback once we
had this out for review, but it didn't reach the right people at Qualcomm at
the time.

> >  Standard regulator bindings are used inside switch mode power supply subnodes.
> >  Check Documentation/devicetree/bindings/regulator/regulator.txt for more
> >  details.
> > @@ -160,6 +167,13 @@ details.
> >  						qcom,rpm-pm8921-nldo,
> >  						qcom,rpm-pm8921-nldo1200
> >  
> > +- qcom,rpm-assisted-disable:
> > +	Usage: optional
> > +	Value type: <empty>
> > +	Definition: select that the regulator is supplying the active CPU(s)
> > +		    and can only be disabled with the assistans from the RPM
> > +		    after going to sleep
> > +
> 
> Eh?  I think I'm seeing double.
> 

You're right, it would make sense to move this to a "common subnode properties"
section.

Regards,
Bjorn
