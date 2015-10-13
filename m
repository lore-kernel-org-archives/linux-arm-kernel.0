From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 13 Oct 2015 08:55:35 +0200 (CEST)
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <561CA58C.2060207@huawei.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos> <5618D3EC.6050501@huawei.com>
 <20151010110942.52d34a4b@arm.com> <alpine.DEB.2.11.1510111150270.6097@nanos>
 <20151011120331.09093ffc@arm.com> <alpine.DEB.2.11.1510111335150.6097@nanos>
 <561CA58C.2060207@huawei.com>
Message-ID: <alpine.DEB.2.11.1510130842070.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Majun,

On Tue, 13 Oct 2015, majun (F) wrote:
> ? 2015/10/12 0:45, Thomas Gleixner ??:
> > So now in the mbigen case this looks like this:
> > 
> >     [MSI-BUS] ----- [MBIGEN]<-------------------[Device interrupt]
> > 
> > Again, you have a 'wire' from the device to the MSI unit (MBIGEN) and
> > we do not care about that 'wire' either. What we care about is how we
> > find the MSI (mbigen) configuration registers for a particular
> > device. So we need a DT/ACPI entry which describes those configuration
> > registers and whatever supplementary information is required. That
> > will make the mbigen driver extremly simple.
> > 
> 
> According to your suggestions, I tried to make the hardware structure likes below:
> 
> device(8250 uart) -> mbigne -> ITS-pMSI --> ITS --> GIC

I'm not sure whether mbigen should be connected to ITS-pMSI (I assume
you mean ITS-PCI-MSI).

mbigen is a seperate MSI domain, so it should connect to ITS, but I
leave that to Marc.
 
> And  8250 uart dts node is:
> 
>  8250_uart {
> 	compatible = "xxx";
> 	msi-parent = < &mbigen>;
> 	config_addr = <xxxxx> ; /* configuration register */
> 	interrupts = <x>;
> 	interrupt-parent = ?
> }
> 
> My question is what's the interrupt-parent should be?

There is no interrupt parent for 8250_uart. Why would you want that?
I'm really not a DT expert, but I think you want something like this:

  8250_uart {
 	compatible = "xxx";
 	msi-parent = < &mbigen_node5>;
 	interrupt-map = <&mbigen5 0>;
  };

and then have

  mbigen_node5 {
  	...
	reg = <....>;
  };

So the other devices which are connected to mbigen_node5 have the same
msi-parent. But then again, please discuss that with Marc and the DT
wizards.

Thanks,

	tglx
