From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Wed, 9 Nov 2016 12:10:43 +0000
Subject: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1555494.4IFvGxvsfe@wuerfel>
References: <1478576829-112707-1-git-send-email-yuanzhichang@hisilicon.com>
 <1478576829-112707-4-git-send-email-yuanzhichang@hisilicon.com>
 <1555494.4IFvGxvsfe@wuerfel>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1F8F1A7A@lhreml507-mbx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: 08 November 2016 16:25
> To: Yuanzhichang
> Cc: catalin.marinas at arm.com; will.deacon at arm.com; robh+dt at kernel.org;
> bhelgaas at google.com; mark.rutland at arm.com; olof at lixom.net; linux-arm-
> kernel at lists.infradead.org; lorenzo.pieralisi at arm.com; linux-
> kernel at vger.kernel.org; Linuxarm; devicetree at vger.kernel.org; linux-
> pci at vger.kernel.org; linux-serial at vger.kernel.org; minyard at acm.org;
> benh at kernel.crashing.org; liviu.dudau at arm.com; zourongrong at gmail.com;
> John Garry; Gabriele Paoloni; zhichang.yuan02 at gmail.com;
> kantyzc at 163.com; xuwei (O)
> Subject: Re: [PATCH V5 3/3] ARM64 LPC: LPC driver implementation on
> Hip06
> 
> On Tuesday, November 8, 2016 11:47:09 AM CET zhichang.yuan wrote:
> > +       /*
> > +        * The first PCIBIOS_MIN_IO is reserved specifically for
> indirectIO.
> > +        * It will separate indirectIO range from pci host bridge to
> > +        * avoid the possible PIO conflict.
> > +        * Set the indirectIO range directly here.
> > +        */
> > +       lpcdev->io_ops.start = 0;
> > +       lpcdev->io_ops.end = PCIBIOS_MIN_IO - 1;
> > +       lpcdev->io_ops.devpara = lpcdev;
> > +       lpcdev->io_ops.pfin = hisilpc_comm_in;
> > +       lpcdev->io_ops.pfout = hisilpc_comm_out;
> > +       lpcdev->io_ops.pfins = hisilpc_comm_ins;
> > +       lpcdev->io_ops.pfouts = hisilpc_comm_outs;
> 
> I have to look at patch 2 in more detail again, after missing a few
> review
> rounds. I'm still a bit skeptical about hardcoding a logical I/O port
> range here, and would hope that we can just go through the same
> assignment of logical port ranges that we have for PCI buses,
> decoupling
> the bus addresses from the linux-internal ones.

The point here is that we want to avoid any conflict/overlap between
the LPC I/O space and the PCI I/O space. With the assignment above
we make sure that LPC never interfere with PCI I/O space.

Thanks

Gab

> 
> 	Arnd
