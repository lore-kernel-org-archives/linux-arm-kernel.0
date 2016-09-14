From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 14 Sep 2016 11:27:00 +0100
Subject: [PATCH v3 0/7] arm64: Privileged Access Never using TTBR0_EL1
 switching
In-Reply-To: <CAKv+Gu-zHmExwk-YqXVg2ZuVi1M8L4BbJb6-iARxQ7b_2eH-rA@mail.gmail.com>
References: <1473788797-10879-1-git-send-email-catalin.marinas@arm.com>
 <CAKv+Gu-zHmExwk-YqXVg2ZuVi1M8L4BbJb6-iARxQ7b_2eH-rA@mail.gmail.com>
Message-ID: <20160914102659.GC14330@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 11:13:33AM +0100, Ard Biesheuvel wrote:
> On 13 September 2016 at 18:46, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > This is the third version of the arm64 PAN emulation using TTBR0_EL1
> > switching.
 
> Given that every __get_user() call now incurs the PAN switch overhead,
> I wonder if it would be worth it to stash the real TTBR0_EL1 value in,
> e.g., TPIDRRO_EL0 rather than load it from memory each time. We'd have
> to reload the real value of TPIDRRO_EL0 at kernel exit every time, but
> only for compat tasks, and not nearly as often, obviously.

FWIW, my plan for vmap'd stacks involves clobbering TPIDRRO_EL0 early
upon kernel entry to reliably detect/handle stack overflow (as we need
to free up GPR to detect overflow, and we need to detect that before we
try to store to the stack).

For non-compat tasks we must restore zero, so either way we'll end up
with a load (to determine compat-ness or to load the precise value).

Thanks,
Mark.
