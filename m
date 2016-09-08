From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Sep 2016 13:51:24 +0100
Subject: [PATCH v2 0/7] arm64: Privileged Access Never using TTBR0_EL1
 switching
In-Reply-To: <CAGXu5j++0LgDEv=m1yQb4hB57MQ2MYVCpeex9TFTRmQpNYhNsQ@mail.gmail.com>
References: <1472828533-28197-1-git-send-email-catalin.marinas@arm.com>
 <CAGXu5j++0LgDEv=m1yQb4hB57MQ2MYVCpeex9TFTRmQpNYhNsQ@mail.gmail.com>
Message-ID: <20160908125123.ypkye5nclsi5vx4f@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 04:20:55PM -0700, Kees Cook wrote:
> On Fri, Sep 2, 2016 at 8:02 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > This is the second version of the arm64 PAN emulation by disabling
> > TTBR0_EL1 accesses. The major change from v1 is the use of a thread_info
> > member to store the real TTBR0_EL1 value. The advantage is slightly
> > simpler assembler macros for uaccess_enable with the downside that
> > switch_mm() must always update the saved ttbr0 even if there is no mm
> > switch.
> 
> Is arm64 thread_info attached to the kernel stack? (i.e. is this
> introducing a valuable target for stack-based attacks?)

Currently yes, thread_info is on the kernel stack. At some point we'll
decouple it in a similar way to what x86 are doing/planning.

If thread_info on the stack can be corrupted, ttbr0 is not our only
worry but I agree it adds to the existing ones (addr_limit, task_struct
pointer).

That said, I don't have a strong preference for thread_info vs per-CPU
variable for the shadow TTBR0. The latter feels a bit more natural to me
since TTBR0 can be seen as a CPU state (that's what I did in v1).
However, using thread_info saves us couple of instructions in the asm
code for uaccess_enable.

-- 
Catalin
