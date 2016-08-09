From: linux@roeck-us.net (Guenter Roeck)
Date: Tue, 9 Aug 2016 09:12:08 -0700
Subject: "Failed to create /dev/root: -14" after commit e6978e4bf1 ("ARM:
 save and reset the address limit when entering an exception")
In-Reply-To: <87eg5y3rsk.fsf@free-electrons.com>
References: <57A15C41.6000804@roeck-us.net>
 <20160803083822.GI1041@n2100.armlinux.org.uk>
 <57A20896.30300@roeck-us.net>
 <20160804100748.GP1041@n2100.armlinux.org.uk>
 <87eg5y3rsk.fsf@free-electrons.com>
Message-ID: <20160809161208.GA11747@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 05:06:51PM +0200, Gregory CLEMENT wrote:
> Hi Russell King,
>  
>  On jeu., ao?t 04 2016, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> 
> > On Wed, Aug 03, 2016 at 08:07:02AM -0700, Guenter Roeck wrote:
> >> On 08/03/2016 01:38 AM, Russell King - ARM Linux wrote:
> >> >On Tue, Aug 02, 2016 at 07:51:45PM -0700, Guenter Roeck wrote:
> >> >>Hi,
> >> >>
> >> >>I see the following crash when running a qemu arm 'kzm' runtime test with
> >> >>the current mainline.
> >> >>...
> >> >>Failed to create /dev/root: -14
> >> >>
> >> >>[ followed by panic ]
> >> >>
> >> >>A complete log file is at [1].
> >> >
> >> >I think it's because of those undefined instructions you're hitting
> >> >with the hw-breakpoint code... can you try the patch below please?
> >> >
> >> >  arch/arm/kernel/entry-armv.S | 1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> >diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> >> >index bc5f50799d75..9f157e7c51e7 100644
> >> >--- a/arch/arm/kernel/entry-armv.S
> >> >+++ b/arch/arm/kernel/entry-armv.S
> >> >@@ -295,6 +295,7 @@ __und_svc_fault:
> >> >  	bl	__und_fault
> >> >
> >> >  __und_svc_finish:
> >> >+	get_thread_info tsk
> >> >  	ldr	r5, [sp, #S_PSR]		@ Get SVC cpsr
> >> >  	svc_exit r5				@ return from exception
> >> >   UNWIND(.fnend		)
> >> >
> >> 
> >> Yes, that fixes the problem.
> >> 
> >> Assuming you'll create a patch:
> >> 
> >> Tested-by: Guenter Roeck <linux@roeck-us.net>
> >> 
> >> Does that need to be addressed in qemu, or is it a Linux bug ?
> >
> > It's a Linux bug provoked by qemu not implementing the hardware
> > breakpoints.  Well worth fixing in Linux.
> 
> The Armada XP base platform were hit by the same bug as we can see on
> kernlci:
> https://storage.kernelci.org/mainline/v4.8-rc1/arm-mvebu_v7_defconfig/lab-baylibre-seattle/boot-armada-xp-openblocks-ax3-4.html
> 
> Your patch solves the issue too.
> 
> Will you push this patch for v4.8-rc2 ?
> 
> Also I wonder if it is something expected to have this issue on a "real"
> hardware.
> 

It would be expected if hardware breakpoint implementation is optional
and not all real CPUs implement it.

Guenter
