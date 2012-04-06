From: davidb@codeaurora.org (David Brown)
Date: Fri, 6 Apr 2012 08:16:10 -0700
Subject: Point-to-point bus in device tree
In-Reply-To: <20120405200829.GA29747@codeaurora.org>
References: <20120405181509.GA28693@codeaurora.org>
 <4F7DF142.5050601@wwwdotorg.org>
 <20120405200829.GA29747@codeaurora.org>
Message-ID: <20120406151610.GA12888@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 05, 2012 at 01:08:29PM -0700, David Brown wrote:
> On Thu, Apr 05, 2012 at 01:23:46PM -0600, Stephen Warren wrote:
> > On 04/05/2012 12:15 PM, David Brown wrote:
> > > Some MSM SoCs have a small serial-type "bus" that is used to
> > > communicate with the PMIC devices.  This interface is always
> > > point-to-point.  I'm doing a device-tree conversion of the driver that
> > > Ken Heitke posted last year <https://lkml.org/lkml/2011/2/17/503>.
> > > 
> > > A naive conversion to device tree, would result in something like
> > > this:
> > > 
> > > 	qcom,ssbi at 500000 {
> > > 		compatible = "qcom,ssbi";
> > > 		reg = <0x500000 0x1000>;
> > > 		qcom,controller-type = "ssbi";
> > > 
> > > 		qcom,pmic8058 at 0 {
> > > 			reg = <0x0 0x01>;
> > > 			...
> > > 		}
> > > 	}
> > > 
> > > There would end up being an extraneous register for the device on the
> > > other end (there are no addresses), and there would need to be code in
> > > the ssbi driver to traverse this small tree to find these nodes.
> > 
> > Isn't that extra code simply:
> > 
> > of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> > 
> > That seems like pretty low overhead.
> 
> True, but it still bothers me to have to have a bogus register.

Ok, not sure where I got that idea, but I don't appear to actually
need a register in the pmic8058 node for of_platform_populate to
create a platform device.  It only needs a compatible field.  So, it
look like that matches just what I need.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
