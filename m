From: labbott@redhat.com (Laura Abbott)
Date: Wed, 23 Dec 2015 13:26:14 -0800
Subject: [PATCH v2] ARM: mm: flip priority of CONFIG_DEBUG_RODATA
In-Reply-To: <20151223201529.GX8644@n2100.arm.linux.org.uk>
References: <20151202202725.GA794@www.outflux.net>
 <20151223201529.GX8644@n2100.arm.linux.org.uk>
Message-ID: <567B1176.4000106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2015 12:15 PM, Russell King - ARM Linux wrote:
> On Wed, Dec 02, 2015 at 12:27:25PM -0800, Kees Cook wrote:
>> The use of CONFIG_DEBUG_RODATA is generally seen as an essential part of
>> kernel self-protection:
>> http://www.openwall.com/lists/kernel-hardening/2015/11/30/13
>> Additionally, its name has grown to mean things beyond just rodata. To
>> get ARM closer to this, we ought to rearrange the names of the configs
>> that control how the kernel protects its memory. What was called
>> CONFIG_ARM_KERNMEM_PERMS is really doing the work that other architectures
>> call CONFIG_DEBUG_RODATA.
>
> Kees,
>
> There is a subtle problem with the kernel memory permissions and the
> DMA debugging.
>
> DMA debugging checks whether we're trying to do DMA from the kernel
> mappings (text, rodata, data etc).  It checks _text.._etext.  However,
> when RODATA is enabled, we have about one section between _text and
> _stext which are freed into the kernel's page pool, and then become
> available for allocation and use for DMA.
>
> This then causes the DMA debugging sanity check to fire.
>
> So, I think I'll revert this change for the time being as it seems to
> be causing many people problems, and having this enabled is creating
> extra warnings when kernel debug options are enabled along with it.
>
> Sorry.
>

in include/asm-generic/sections.h:

/*
  * Usage guidelines:
  * _text, _data: architecture specific, don't use them in arch-independent code
  * [_stext, _etext]: contains .text.* sections, may also contain .rodata.*
  *                   and/or .init.* sections


So based on that comment it seems like the dma-debug should be checking for
_stext not _text since only _stext is guaranteed across all architectures.
I'll submit a patch to dma-debug.c if this seems appropriate or if you
haven't done so already.

Thanks,
Laura
