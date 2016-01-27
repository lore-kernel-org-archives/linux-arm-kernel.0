From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 27 Jan 2016 09:52:31 +0100
Subject: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <000001d1585e$8097d7e0$81c787a0$@samsung.com>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
 <000001d1585e$8097d7e0$81c787a0$@samsung.com>
Message-ID: <56A8854F.3030209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,
On 01/26/2016 06:25 PM, Pavel Fedin wrote:
>  Hello!
>  I'd like just to clarify some things for myself and better wrap my head around it...
> 
>> On x86 all accesses to the 1MB PA region [FEE0_0000h - FEF0_000h] are directed
>> as interrupt messages: accesses to this special PA window directly target the
>> APIC configuration space and not DRAM, meaning the downstream IOMMU is bypassed.
> 
>  So, this is effectively the same as always having hardwired 1:1 mappings on all IOMMUs, isn't it ?
>  If so, then we can't we just do the same, just by forcing similar 1:1 mapping? This is what i tried to do in my patchset. All of
> you are talking about a situation which arises when we are emulating different machine with different physical addresses layout. And
> e. g. if our host has MSI at 0xABADCAFE, our target could have valid RAM at the same location, and we need to handle it somehow,
> therefore we have to move our MSI window out of target's RAM. But how does this work on a PC then? What if our host is PC, and we
> want to emulate some ARM board, which has RAM at FE00 0000 ? Or does it mean that PC architecture is flawed and can reliably handle
> PCI passthrough only for itself ?
Alex answered to this I think:
"
x86 isn't problem-free in this space.  An x86 VM is going to know that
the 0xfee00000 address range is special, it won't be backed by RAM and
won't be a DMA target, thus we'll never attempt to map it for an iova
address.  However, if we run a non-x86 VM or a userspace driver, it
doesn't necessarily know that there's anything special about that range
of iovas.  I intend to resolve this with an extension to the iommu info
ioctl that describes the available iova space for the iommu.  The
interrupt region would simply be excluded.
"

I am not sure I've addressed this requirement yet but it seems more
future proof to have an IOMMU mapping for those addresses.

For the ARM use case I think Marc gave guidance:
"
We want userspace to be in control of the memory map, and it
is the kernel's job to tell us whether or not this matches the HW
capabilities or not. A fixed mapping may completely clash with the
memory map I want (think emulating HW x on platform y), and there is no
reason why we should have the restrictions x86 has.
"

That's the rationale behind respining that way.

Waiting for other comments & discussions, I am going to address the iova
and dma_addr_t kbuilt reported compilation issues. Please apologize for
those.

Best Regards

Eric


> 
> Kind regards,
> Pavel Fedin
> Senior Engineer
> Samsung Electronics Research center Russia
> 
> 
