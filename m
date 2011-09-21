From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 21 Sep 2011 17:01:17 +0100
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
	<CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
Message-ID: <1316620877.4611.647.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-09-21 at 15:57 +0100, Grant Likely wrote:
> On Wed, Sep 21, 2011 at 7:24 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On 09/21/2011 04:19 AM, Dave Martin wrote:
> >>       * arm,amba-bus -- widely used by other boards and patchsets, but
> >>         seems not to be documented.
> >>
> >
> > This should be dropped. There's not really any bus component to an amba
> > bus. All the probing info is within the primecell peripherals.
> 
> No, if it is an AMBA bus, then it is entirely appropriate to declare
> it as an amba bus, but to also be compatible with "simple-bus".  In
> fact, it would be better to use a compatible string that specifies the
> specific implementation of AMBA bus since there are several versions
> of the spec.

Dave asked me about details of the VE implementation. It's
sort-of-complicated... ;-)

1. Core talks to Static Memory Controller via AMBA (AXI)

   SOC { core --AXI--> SMC }

2. SMC generates transaction on Static Memory Bus talking to the IO FPGA

   tile/motherboard connector { SMC --SMB--> IOFPGA }

3. Now, depending on the device being accessed:

a) Transactions accessing SMSC9118, ISP1761, NOR Flash and PSRAM are
routed directly to the devices

   IOFPGA { SMB --> SMSC9118 et al. }

b) The rest of the traffic is converted back to AMBA (AHB/APB)
transactions and sent to the devices connected to internal AMBA matrix.

   IOFPGA { SMB --> AHB/APB bus master --AHB/APB--> PL180 }

I don't believe, though, that the DTS must reflect such level of
details. That's why I think that:

+       motherboard {
+               compatible = "simple-bus";

and

+               peripherals at 7,00000000 {
+                       compatible = "arm,amba-bus", "simple-bus";

is the best description of the reality :-)

Cheers!

Pawe?
