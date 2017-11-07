From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 7 Nov 2017 12:19:13 +0000
Subject: Performance issues writing to PCIe in a Zynq
In-Reply-To: <1510045454475.74232@axon.tv>
References: <1509636637116.27702@axon.tv>
 <eca01e58-3da1-d5c4-00f7-71dd6a926870@xilinx.com>
 <20171103135457.GA8457@bhelgaas-glaptop.roam.corp.google.com>
 <1509958288489.45871@axon.tv>,
 <20171106173549.GB31930@bhelgaas-glaptop.roam.corp.google.com>
 <1510045454475.74232@axon.tv>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD00B3AB2@AcuExch.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ruben Guerra Marin
> Sent: 07 November 2017 09:04
> > Which PCI host bridge driver are you using?
> Indeed I am using drivers/pci/host/pcie-xilinx.c
> 
> > Can you do any profiling to figure out where the time is going?
> So I did some profiling on the mcap application, and traced the bottleneck in a write call to
> pciutils. I added some debug to pciutils and could trace it that the bottleneck is in a function
> called pwrite, which pretty much does this:
> 
> syscall(SYS_pwrite, fd, buf, size, where);
> 
> until now this is the last part I could trace it to.

Are you doing one pwrite() for each 32-bit word?
If you are trying to write a large fpga image you'll need to use
a single system call.
I'd suspect that needs a special driver....

I'd also check that the driver size isn't doing single word copy_from_user().
That can be completely horrid in recent kernels because of userspace copy
hardening.

	David
