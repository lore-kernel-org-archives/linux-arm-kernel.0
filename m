From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 14 Jun 2016 16:45:07 +0100
Subject: Why MSI is limited to 32 MSI's per device
In-Reply-To: <loom.20160614T164843-937@post.gmane.org>
References: <loom.20160614T164843-937@post.gmane.org>
Message-ID: <20160614154507.GA14781@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 02:58:36PM +0000, valmiki wrote:
> Hi,
> 
> Why MSI interrupts are limited to 32 per device ?
> We have 16 bit data, with which we can have 2^16 combinaitons of different
> data, which in turn those many MSI vectors.

I assume you're specifically asking w.r.t. PCI.
 
Conventional PCI allowed devices to have up to 32 MSIs, no more. PCI
devices are only permitted to choose up to the low 5 bits of an MSI
payload. The remaining bits are shared by all MSIs.

> Other than increase in number interrupts to 2048 in MSI-X, what advantage we
> get by using MSI-X over MSI.

As alluded to below, MSI-X allows MSIs to be targeted at different
doorbell addresses, and provides full control of the payload of each
MSI.

There may be other gains that I am not aware of.

> I read MSI-X interrupts can be targeted to different CPU's in an SMP system.
> why can't MSI interrupts can be targeted to different processors ?  

Conventional PCI has a single doorbell address per device. I believe
that x86 had a doorbell per-cpu, and hence all MSIs for a device
targeted the same CPU. I'm not entirely certain on that, nor whether
things have changed.

Whether or not that holds elsewhere depends on your MSI controller and
IRQ controllers.

Thanks,
Mark.
