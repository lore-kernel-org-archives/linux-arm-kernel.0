From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 18 Aug 2015 16:28:58 +0800
Subject: [PATCH] ARM: keystone: add a work around to handle asynchronous
 external abort
In-Reply-To: <20150818081334.GK7557@n2100.arm.linux.org.uk>
References: <1439320409-20084-1-git-send-email-m-karicheri2@ti.com>
 <55CDF579.4050408@ti.com>	<20150814140934.GX7557@n2100.arm.linux.org.uk>
 <55CE05EC.4040909@oracle.com>	<55CE633C.10402@ti.com>
 <20150814215617.GA7557@n2100.arm.linux.org.uk>	<55D25C64.3090107@ti.com>
 <55D2A1DD.9000007@oracle.com>	<20150818081334.GK7557@n2100.arm.linux.org.uk>
Message-ID: <20150818162858.42035da0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Aug 2015 09:13:34 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Mon, Aug 17, 2015 at 08:09:17PM -0700, santosh.shilimkar at oracle.com wrote:
> > From the logs this seems to be mostly clock related issue for some
> > peripheral. If the bootloader clock enable all hack still exists,
> > may be you can try that out.
> > 
> > Another way to debug this is to start disabling peripheral drivers
> > from the kernel 1 by 1 and see if the issue goes away.
> 
> Highly unlikely to make any difference.  As the failure happens soo early
> with the patch applied, the kernel hasn't had much of a chance to touch
> the hardware - about the only things are the decompressor and the kernel
> touching the early console.  As they seem to be working, it suggests
> that's not the cause.
> 
> It seems to be pointing towards something in the boot loader...
> 
> Normally, uboot will hook itself into the vectors to report errors, but
> I wonder whether uboot enables asynchronous aborts while it's running.
> Don't forget to make sure that the aborts are disabled again prior to
> calling the kernel.
> 

Another possible cause: trustzone software.

we root caused such kind of asynchronous external abort on Marvell Berlin SoCs
to a trustzone bug. I'm not sure whether keystone linux is running at normal
world or not.
