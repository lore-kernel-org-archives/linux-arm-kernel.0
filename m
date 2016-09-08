From: keescook@chromium.org (Kees Cook)
Date: Thu, 8 Sep 2016 08:50:39 -0700
Subject: [PATCH v2 0/7] arm64: Privileged Access Never using TTBR0_EL1
 switching
In-Reply-To: <20160908125123.ypkye5nclsi5vx4f@localhost>
References: <1472828533-28197-1-git-send-email-catalin.marinas@arm.com>
 <CAGXu5j++0LgDEv=m1yQb4hB57MQ2MYVCpeex9TFTRmQpNYhNsQ@mail.gmail.com>
 <20160908125123.ypkye5nclsi5vx4f@localhost>
Message-ID: <CAGXu5jKCZmZSJHK-EFunNtbqbxBT1KsLE31VygapwgZX9XmFAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 5:51 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Sep 07, 2016 at 04:20:55PM -0700, Kees Cook wrote:
>> On Fri, Sep 2, 2016 at 8:02 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
>> > This is the second version of the arm64 PAN emulation by disabling
>> > TTBR0_EL1 accesses. The major change from v1 is the use of a thread_info
>> > member to store the real TTBR0_EL1 value. The advantage is slightly
>> > simpler assembler macros for uaccess_enable with the downside that
>> > switch_mm() must always update the saved ttbr0 even if there is no mm
>> > switch.
>>
>> Is arm64 thread_info attached to the kernel stack? (i.e. is this
>> introducing a valuable target for stack-based attacks?)
>
> Currently yes, thread_info is on the kernel stack. At some point we'll
> decouple it in a similar way to what x86 are doing/planning.

Okay, cool. As long as this is on the horizon, that's cool. :)

> If thread_info on the stack can be corrupted, ttbr0 is not our only
> worry but I agree it adds to the existing ones (addr_limit, task_struct
> pointer).
>
> That said, I don't have a strong preference for thread_info vs per-CPU
> variable for the shadow TTBR0. The latter feels a bit more natural to me
> since TTBR0 can be seen as a CPU state (that's what I did in v1).
> However, using thread_info saves us couple of instructions in the asm
> code for uaccess_enable.

I would opt for the safer (in per-CPU area), but I have clear biases.
;) Getting this emulation at all closes a huge exploitation method, so
on balance, the new exposure (which as you say is already not the only
target on the stack) is worth it. :)

Thanks!

-Kees

-- 
Kees Cook
Nexus Security
