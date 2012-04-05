From: davidb@codeaurora.org (David Brown)
Date: Thu, 5 Apr 2012 11:15:09 -0700
Subject: Point-to-point bus in device tree
Message-ID: <20120405181509.GA28693@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some MSM SoCs have a small serial-type "bus" that is used to
communicate with the PMIC devices.  This interface is always
point-to-point.  I'm doing a device-tree conversion of the driver that
Ken Heitke posted last year <https://lkml.org/lkml/2011/2/17/503>.

A naive conversion to device tree, would result in something like
this:

	qcom,ssbi at 500000 {
		compatible = "qcom,ssbi";
		reg = <0x500000 0x1000>;
		qcom,controller-type = "ssbi";

		qcom,pmic8058 at 0 {
			reg = <0x0 0x01>;
			...
		}
	}

There would end up being an extraneous register for the device on the
other end (there are no addresses), and there would need to be code in
the ssbi driver to traverse this small tree to find these nodes.

Another approach would be to make the pmic driver the actual device,
and just have it use the ssbi code as a library.  Something like:

	qcom,pmic8058 at 500000 {
		compatible = "qcom,pmic8058";
		reg = <0x500000 0x1000>;
		qcom,ssbi-type = "ssbi";
		...
	}

This is a lot cleaner, takes less code, but doesn't technically
represent how the hardware is really structured.

Does anyone have strong (or weak) feelings about this?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
