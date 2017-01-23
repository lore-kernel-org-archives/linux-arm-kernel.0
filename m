From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 23 Jan 2017 10:16:04 +0000
Subject: [PATCH v10 7/8] arm/arm64: vgic: Implement
 KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO ioctl
In-Reply-To: <20170120195338.GH13531@cbox>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-8-git-send-email-vijay.kilari@gmail.com>
 <20170120195338.GH13531@cbox>
Message-ID: <CAFEAcA8bZUPC2YTBYTVY3oB4MJFJcKOgT77PN3vkp5gPjVRPgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2017 at 19:53, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> So last time we had a discussion about whether or not the API should
> support any random order of restoring the registers, but I cannot see
> how we can support that, because how can we tell the difference between
> the following two scenarios without knowing if an interrupt is
> edge-triggered or level triggered:
>
>   (1) Clearing the line_level for an edge-triggered interrupt after
>       having set it to pending, which means it should stay pending.

This is userspace doing:
 * set pending-latch to 1
 * set linelevel to 0

right? The pending state is pending-latch | (linelevel & ~edge_trigger),
and you can recalculate that when userspace updates either of the
pending-latch state or linelevel. (It will be temporarily wrong
before userspace has told the kernel about all the state, but
that's fine because we won't try to run the VM until we've finished
loading everything.)

>   (2) Clearing the line_level for a level-triggered interrupt when the
>       state is already pending for some reason, but the soft_pending
>       (latch) state is not set, in which case the pending state should
>       be removed.

This is userspace doing
 * set pending-latch to 0
 * set line_level to 0

and thus the pending state goes to 0 (same calculation as above).

pending is always a pure logical function of pending-latch,
linelevel and edge-trigger bits, so as long as you recalculate
it at the right time then it shouldn't matter which order userspace
tells you about the three things in.

thanks
-- PMM
