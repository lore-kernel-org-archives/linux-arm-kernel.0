From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Sep 2011 13:19:54 -0400 (EDT)
Subject: Git pull request: mach/vmalloc.h removal,
	and ioremap optimizations
In-Reply-To: <4E8495D9.2030009@gmail.com>
References: <alpine.LFD.2.00.1109230908410.12663@xanadu.home>
	<4E8495D9.2030009@gmail.com>
Message-ID: <alpine.LFD.2.02.1109291302450.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Sep 2011, Rob Herring wrote:

> Nicolas,
> 
> On 09/23/2011 08:32 AM, Nicolas Pitre wrote:
> > Russell, please pull
> > 
> > 	git://git.linaro.org/people/nico/linux vmalloc
> > 
> > This patch series removes all instances of mach/vmalloc.h in order to
> > have a more unified memory map across all ARM architectures.  To do so,
> > the static mappings are moved inside the vmalloc area.  And finally this
> > allows for a generic optimization to ioremap where static mappings are
> > reused whenever possible, using common code instead of having this
> > duplicated in a couple places.
> 
> I've found that this breaks on versatile (ab and pb) under QEMU. The
> commit causing it is:
> 
> commit e0438e2f333005c217a2f65aacab23a39261c64c
> Author: Nicolas Pitre <nicolas.pitre@linaro.org>
> Date:   Thu Aug 25 00:35:59 2011 -0400
> 
>     ARM: move iotable mappings within the vmalloc region
> 
>     In order to remove the build time variation between different SOCs with
>     regards to VMALLOC_END, the iotable mappings are now allocated inside
>     the vmalloc region.  This allows for VMALLOC_END to be identical across
>     all machines.
> 
>     The value for VMALLOC_END is now set to 0xff000000 which is right where
>     the consistent DMA area starts.
> 
>     To accommodate all static mappings on machines with possible highmem
> usage,
>     the default vmalloc area size is changed to 240 MB so that VMALLOC_START
>     is no higher than 0xf0000000 by default in that case.
> 
>     Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> 
> It dies after "Data cache writeback" with BUG at vmalloc.c:1139.

Interesting.  Looks like Versatile might have overlapping map_desc 
entries.

Could you add the following line at the top of vm_area_add_early() in 
mm/vmalloc.c to display the area being added:

  printk("%s: called with addr=%p size=0x%lx\n", __func__, vm->addr, vm->size);

This should help determine which entry is wrong.


Nicolas
