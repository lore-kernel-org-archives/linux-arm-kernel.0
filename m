From: will.deacon@arm.com (Will Deacon)
Date: Mon, 26 Nov 2012 11:13:37 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <50B2679F.3070107@gmail.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
 <50B2679F.3070107@gmail.com>
Message-ID: <20121126111337.GA13312@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Sun, Nov 25, 2012 at 06:46:55PM +0000, Rob Herring wrote:
> On 11/22/2012 05:34 AM, Will Deacon wrote:
> > As an aside, you also need to make the asm block volatile in
> > __my_cpu_offset -- I can see it being re-ordered before the set for
> > secondary CPUs otherwise.
> 
> I don't think that is right. Doing that means the register is reloaded
> on every access and you end up with code like this (from handle_IRQ):
> 
> c000eb4c:       ee1d2f90        mrc     15, 0, r2, cr13, cr0, {4}
> c000eb50:       e7926003        ldr     r6, [r2, r3]
> c000eb54:       ee1d2f90        mrc     15, 0, r2, cr13, cr0, {4}
> c000eb58:       e7821003        str     r1, [r2, r3]
> c000eb5c:       eb006cb1        bl      c0029e28 <irq_enter>
> 
> I don't really see where there would be a re-ordering issue. There's no
> percpu var access before or near the setting that I can see.

Well my A15 doesn't boot with your original patch unless I make that thing
volatile, so something does need tweaking...

The issue is on bringing up the secondary core, so I assumed that a lot
of inlining goes on inside secondary_start_kernel and then the result is
shuffled around, placing a cpu-offset read before we've done the set.

Unfortunately, looking at the disassembly I can't see this happening at
all, so I'll keep digging. The good news is that I've just reproduced the
problem on the model, so I've got more visibility now (although both cores
are just stuck in spinlocks...).

Will
