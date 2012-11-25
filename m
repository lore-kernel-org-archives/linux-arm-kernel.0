From: robherring2@gmail.com (Rob Herring)
Date: Sun, 25 Nov 2012 12:46:55 -0600
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121122113401.GC3113@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
Message-ID: <50B2679F.3070107@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2012 05:34 AM, Will Deacon wrote:
> Hi Rob,


> As an aside, you also need to make the asm block volatile in
> __my_cpu_offset -- I can see it being re-ordered before the set for
> secondary CPUs otherwise.

I don't think that is right. Doing that means the register is reloaded
on every access and you end up with code like this (from handle_IRQ):

c000eb4c:       ee1d2f90        mrc     15, 0, r2, cr13, cr0, {4}
c000eb50:       e7926003        ldr     r6, [r2, r3]
c000eb54:       ee1d2f90        mrc     15, 0, r2, cr13, cr0, {4}
c000eb58:       e7821003        str     r1, [r2, r3]
c000eb5c:       eb006cb1        bl      c0029e28 <irq_enter>

I don't really see where there would be a re-ordering issue. There's no
percpu var access before or near the setting that I can see.

Rob
