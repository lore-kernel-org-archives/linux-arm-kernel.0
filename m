From: keescook@chromium.org (Kees Cook)
Date: Thu, 11 Jan 2018 15:21:09 -0800
Subject: [PATCH 34/38] arm: Implement thread_struct whitelist for hardened
 usercopy
In-Reply-To: <20180111102400.GT17719@n2100.armlinux.org.uk>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
 <1515636190-24061-35-git-send-email-keescook@chromium.org>
 <20180111102400.GT17719@n2100.armlinux.org.uk>
Message-ID: <CAGXu5jKaz_rAi_R2x3V73306fw+1MOBN-6v-nK4_S=PU8_pzhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 2:24 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Jan 10, 2018 at 06:03:06PM -0800, Kees Cook wrote:
>> ARM does not carry FPU state in the thread structure, so it can declare
>> no usercopy whitelist at all.
>
> This comment seems to be misleading.  We have stored FP state in the
> thread structure for a long time - for example, VFP state is stored
> in thread->vfpstate.hard, so we _do_ have floating point state in
> the thread structure.
>
> What I think this commit message needs to describe is why we don't
> need a whitelist _despite_ having FP state in the thread structure.
>
> At the moment, the commit message is making me think that this patch
> is wrong and will introduce a regression.

Yeah, I will improve this comment; it's not clear enough. The places
where I see state copied to/from userspace are all either static sizes
or already use bounce buffers (or both). e.g.:

        err |= __copy_from_user(&hwstate->fpregs, &ufp->fpregs,
                                sizeof(hwstate->fpregs));

I will adjust the commit log and comment to more clearly describe the
lack of whitelisting due to all-static sized copies.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
