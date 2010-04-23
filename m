From: janboe.ye@gmail.com (Janboe Ye)
Date: Fri, 23 Apr 2010 12:26:26 +0800
Subject: [PATCH 0/8] Initial implementation of kdump for ARM
In-Reply-To: <20100423041106.GG3028@esdhcp04058.research.nokia.com>
References: <cover.1271752135.git.ext-mika.1.westerberg@nokia.com>
	<20100422120308.GD26418@gw.healthdatacare.com>
	<20100423030556.GA8012@localhost.localdomain>
	<20100423041106.GG3028@esdhcp04058.research.nokia.com>
Message-ID: <20100423042626.GA2997@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are some other hard code address in some boards.

For example, beagle board boot_params is 0x80000100.

I guest nokia's Nseris does not use atags for transfering params.

When I test my relocated kernel, it blocks at machinee initialization.

Maybe there is other address mapping issue. I will look it tomorrow.

Janboe

On Fri, Apr 23, 2010 at 07:11:06AM +0300, Mika Westerberg wrote:
> On Fri, Apr 23, 2010 at 05:05:56AM +0200, ext Janboe Ye wrote:
> > I am trying this. But it seems need to do a lot work to make kdump
> > to work on other omap3 board.
> 
> You need to have userspace tools (in this case kexec-tools) which load the
> crashkernel into the running kernel. I'm planning to send my kexec-tools
> patches to upstream after the kernel part is accepted (so that they can be
> in sync) but I can provide you the patches if needed.
> 
> For kernel part, I believe only thing that needs to be done is to make sure
> that PHYS_OFFSET of the crashkernel is configured correctly.
> 
> For example in my platform (and I guess all OMAP3s) physical memory starts
> at 0x80000000 and this is the PHYS_OFFSET used by the primary kernel. I decided
> to load crashkernel at physical address 0x84000000.
> 
> So I boot the primary kernel with 'crashkernel=32M at 0x84000000'. Now memory for
> crashkernel is reserved.
> 
> Only thing left is to load the craskernel itself which is done like (with patched
> kexec-tools):
> 
> 	# kexec -p /boot/zImage.crash --command-line="..."
> 
> What kind of problems you are having?
> 
> Thanks,
> MW
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
