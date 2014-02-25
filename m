From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Feb 2014 19:32:13 +0100
Subject: [PATCH] ARM: move __fixup_smp out of init section
In-Reply-To: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
References: <1393352193-31717-1-git-send-email-robherring2@gmail.com>
Message-ID: <22591791.dKqiiVNNOv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 12:16:33 Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> With large kernel builds such as allyesconfig exceeding maximum relative
> branch offsets, the init section will be too far away to branch to
> directly. This causes veneers to be added by the compiler, but veneers
> don't work before the MMU is enabled. Fix this by moving __fixup_smp to
> the .head.text section as it is not very big.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

This looks good to me, but I have some related questions:

* I needed to use -mlong-calls for large kernels. Did you manage without?

* Do you (or anyone) know how to force the use of a veneer? I see a problem
  with some driver calling __do_div_asm from IIRC an init section, and that
  creates a link error when the kernel gets too big

* If FUNCTION_TRACER is enabled, we get calls from every function using
 'bl __gnu_mcount_nc'. Do you think it's possible to fix those?

* Same thing but simpler for svc_preempt calling preempt_schedule_irq
  and lookup_processor_type calling __lookup_processor_type. In those
  cases I guess we should be able to trivially rewrite the assembly
  to jump through an extra register.

The complete patch I have is at http://pastebin.com/5yVaUC4u, but it's
likely that it's completely broken ;-)

	Arnd
