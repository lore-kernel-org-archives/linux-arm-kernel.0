From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Sun, 3 Oct 2010 20:02:52 +0900
Subject: [PATCH] scatterlist: define SG chain for arm architecture
In-Reply-To: <20101001163958.GA22533@n2100.arm.linux.org.uk>
References: <1285950521-8093-1-git-send-email-x0095840@ti.com>
	<20101001163958.GA22533@n2100.arm.linux.org.uk>
Message-ID: <20101003195758B.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Oct 2010 17:39:58 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Oct 01, 2010 at 11:28:41AM -0500, Fernando Guzman Lugo wrote:
> > Define SG chain for ARM architecture in order to work
> > with big buffers. This patch is needed in order to
> > iovmm users can pass a big buffer to map it and ARM
> > architecture has not issues using SG chain.
> > 
> > This change was suggested by FUJITA Tomonori.
> 
> Have you audited all places where SG lists are used in the ARM
> architecture to ensure that SG chain support is safe?  (That
> goes for ARM generic code and ARM specific drivers.)

As far as I know, only SCSI actually uses SG chain feature (that is,
sending chained scatter lists). All SCSI drivers were converted when
we added SG chain feature. So what you need to care about is the dma
code.

There are only several files that actually use scatter list under
arch/arm.


>From bogus@does.not.exist.com  Sat Oct  2 09:29:56 2010
From: bogus@does.not.exist.com ()
Date: Sat, 02 Oct 2010 13:29:56 -0000
Subject: No subject
Message-ID: <mailman.0.1286103837.18775.linux-arm-kernel@lists.infradead.org>

arch/arm/common/dmabounce.c, arch/arm/kernel/dma.c, and
arch/arm/include/asm/dma-mapping.h looks fine.

arm/mach-imx/dma-v1.c also looks like to use chained sg API properly
(but this isn't used with SCSI, right?).

Seems that arch/arm/plat-omap/iovmm.c can handle the chained SG
too. It doesn't allocate the chained SG now though.
