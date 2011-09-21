From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 21 Sep 2011 17:28:14 +0100
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <CA+wbFdcOSC6YfsmLndM9CCg2WC9GbQqHmgzk3r8JKs71Bsn8Xg@mail.gmail.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
	<4E79E588.6010703@gmail.com>
	<CACxGe6sTYYXbpXvPb4C+y4JX0eRxLvwjbFycXA8Mjc-XWS1QUA@mail.gmail.com>
	<1316620877.4611.647.camel@hornet.cambridge.arm.com>
	<CA+wbFdcOSC6YfsmLndM9CCg2WC9GbQqHmgzk3r8JKs71Bsn8Xg@mail.gmail.com>
Message-ID: <1316622494.4611.657.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Dave asked me about details of the VE implementation. It's
> > sort-of-complicated... ;-)
> >
> > 1. Core talks to Static Memory Controller via AMBA (AXI)
> >
> >   SOC { core --AXI--> SMC }
> >
> > 2. SMC generates transaction on Static Memory Bus talking to the IO FPGA
> >
> >   tile/motherboard connector { SMC --SMB--> IOFPGA }
> >
> > 3. Now, depending on the device being accessed:
> >
> > a) Transactions accessing SMSC9118, ISP1761, NOR Flash and PSRAM are
> > routed directly to the devices
> >
> >   IOFPGA { SMB --> SMSC9118 et al. }
> >
> > b) The rest of the traffic is converted back to AMBA (AHB/APB)
> > transactions and sent to the devices connected to internal AMBA matrix.
> >
> >   IOFPGA { SMB --> AHB/APB bus master --AHB/APB--> PL180 }
> >
> > I don't believe, though, that the DTS must reflect such level of
> > details. That's why I think that:
> >
> > +       motherboard {
> > +               compatible = "simple-bus";
> >
> > and
> >
> > +               peripherals at 7,00000000 {
> > +                       compatible = "arm,amba-bus", "simple-bus";
> >
> > is the best description of the reality :-)
> 
> I wonder whether an OS will ever need to know this detail.

Which one of the details you mean? Exact architecture describing what I
said above? I don't think so.

The compatible = "arm,amba-bus" for CS7? Probably not, but I think it's
good to have it there as it answers the question "so how can AMBA device
like PL180 be connected to a static memory bus?!?".

> Am I right in understanding that these buses are just interconnect
> logic, with no OS-visible control/configuration interface?

Definitely nothing publicly specified :-)

Cheers!

Pawe?
