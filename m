From: mmarek@suse.com (Michal Marek)
Date: Thu, 19 Nov 2015 17:21:06 +0100
Subject: [PATCH] ARM: xip: Move XIP linking to a separate file
In-Reply-To: <HK2PR06MB0561F1A746E04D0A205B2DBB8A1B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <1447943047-22427-1-git-send-email-chris.brandt@renesas.com>
 <alpine.LFD.2.20.1511191050080.22569@knanqh.ubzr>
 <HK2PR06MB0561F1A746E04D0A205B2DBB8A1B0@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <564DF6F2.5090808@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-19 17:04, Chris Brandt wrote:
> On Thu, 19 Nov 2015, Michal Marek wrote:
>> Why not have a vmlinux.lds.S and #include a vmlinux-xip.lds.S / 
>> vmlinux-nonxip.lds.S from there? That way, you do not clutter the
>> main Makefile and you can reuse the boilerplate of the linker script.
>>
>> Michal
> 
> On Thu, 19 Nov 2015, Nicolas Pitre wrote:
>> I agree with Michal's suggestion to do the selection locally with an
>> include.
> 
> 
> That's actually how I started out locally, but I thought if I tried submitting that, I'd get a bunch of "Eww, that's ugly".

:-). It arguably is not the most beautiful pattern, but it is still easy
to understand and there is some prior art in the kernel already, where
we include variants of C / asm files from other source files:

arch/arm/mm/fault.c:#include "fsr-3level.c"
arch/arm/mm/fault.c:#include "fsr-2level.c"
arch/m68k/kernel/setup.c:#include "setup_mm.c"
arch/m68k/kernel/setup.c:#include "setup_no.c"
arch/powerpc/kvm/book3s_segment.S:#include "book3s_64_slb.S"
arch/powerpc/kvm/book3s_segment.S:#include "book3s_32_sr.S"
mm/percpu.c:#include "percpu-km.c"
mm/percpu.c:#include "percpu-vm.c"

UM even uses it in its linker script:

arch/um/kernel/vmlinux.lds.S:#include "uml.lds.S"
arch/um/kernel/vmlinux.lds.S:#include "dyn.lds.S"

Michal
