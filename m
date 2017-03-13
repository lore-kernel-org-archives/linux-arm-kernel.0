From: tony@atomide.com (Tony Lindgren)
Date: Mon, 13 Mar 2017 14:47:16 -0700
Subject: [PATCH] ARM: omap2+: Revert omap-smp.c changes resetting CPU1
 during boot
In-Reply-To: <c6d992fc-5468-8124-f1ee-558889147b72@ti.com>
References: <20170313205231.1593-1-tony@atomide.com>
 <c6d992fc-5468-8124-f1ee-558889147b72@ti.com>
Message-ID: <20170313214716.GY20572@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew F. Davis <afd@ti.com> [170313 14:30]:
> On 03/13/2017 03:52 PM, Tony Lindgren wrote:
> > So let's fix the issue reported by Andrew by making CPU1 reset conditional
> > and only do it if CPU1 is configured to boot at an address that is within
> > the booting kernel. In these cases we know for sure that we just overwrote
> > the configured boot_secondary() during booting and that it's invalid.
> 
> One thing that worries me is the false negatives, what happens if the
> boot address register (WAKEUP_NS_PA_ADDR) is pointing outside the new
> kernel (which will most likely be the case as it probably will be
> pointing to the old kernel), but the core is not correctly parked (lets
> say it is in WFI idle loop in old kernel), we will fail to reboot it
> when in this case we should.

Yup this won't handle all the cases for sure. The case you're describing
always happens with u-boot, I think it parks CPU1 to the end of DDR.
And then we just blindly assume CPU1 is properly configured.

For kexec booting, the old parked address will be almost certainly
overlapping with the new kernel and the code gets overwritten. I don't
think the kexec case of WAKEUP_NS_PA_ADDR being outside the booted
kernel can happen without patched kernel. But it probably can with
crashkernel configurations, and properly parking the kernel is the
real fix there.

Or do you have some specific check in mind we could add?

> I think the best way to handle this is to set WAKEUP_NS_PA_ADDR to zero
> when we park it, for all other cases we can assume it is not parked. As
> long as we remember in the bootloader and kernel to zero that register
> when parking it, then we shouldn't have any false positives or any
> failures to reset when we should have.

Yeah makes sense. So for CPU1 hot-unplug, we also need to bring up
CPU1 from idle and park it to bootrom to also prevent CPU1 waking
from idle to a wrong address.

Regards,

Tony
