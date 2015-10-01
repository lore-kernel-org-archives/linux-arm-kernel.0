From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Oct 2015 14:02:32 +0100
Subject: Undefined instruction error on Cortex A57 (aarch64) in init
 process
In-Reply-To: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
References: <CADTbHxpXCJZdK=iQc+FUxW27-vv1_kHXCeespDXR2fJ8UkfCCg@mail.gmail.com>
Message-ID: <20151001130231.GE6963@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2015 at 01:02:46PM +0530, Pankaj Jangra wrote:
> In android system, after system is running for long time say 10 hour,
> some time i am hitting below
> traces:
> 
>  init[1]: undefined instruction: pc=0000000000401624
> Code: 1a9f00c2 aa1703e0 2a1603e1 9400e1bf (6b1f001f)
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004
[...]
>  401624:       6b1f001f        cmp     w0, wzr

Hard to tell. What I can see is that the instruction opcode as read (via
the D-cache) looks fine. I suspect some form of corruption in the
I-cache. Other things like temporary TLB corruption are possible, though
I would expect to see them on the D side as well.

One thing to try is disabling the deeper CPU idle states, only leave
WFI. I've seen failures in the past caused by insufficient TLB or cache
maintenance in firmware.

-- 
Catalin
