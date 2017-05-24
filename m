From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 24 May 2017 08:29:06 -0700
Subject: [RFC PATCH v2 0/2] Simplify kernel-mode NEON
In-Reply-To: <1495636986-30515-1-git-send-email-Dave.Martin@arm.com>
References: <1495636986-30515-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <CAKv+Gu-QoRkJysYpnzw-=fmEkuajDcFY77T28CLE0JjwogQWnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 May 2017 at 07:42, Dave Martin <Dave.Martin@arm.com> wrote:
> This series aims to simplify kernel-mode NEON.
>
> The main motivation for these changes is that supporting kernel-mode
> NEON alongside SVE is tricky with the current framework: the current
> partial save/restore mechanisms would need additional porting to
> save/restore the extended SVE vector bits, and this renders the cost
> saving of partial save/restore rather doubtful -- even if not all vector
> registers are saved, the save/restore cost will still grow with
> increasing vector length.  We could get the mechanics of this to work in
> principle, but it doesn't feel like the right thing to do.
>
> If we withdraw kernel-mode NEON support for hardirq context, accept some
> extra softirq latency and disable nesting, then we can simplify the code
> by always saving the task context directly into task_struct and
> deferring all restore to ret_to_user.  Previous discussions with Ard
> Biesheuvel suggest that this is a feasible approach and reasonably
> aligned with other architectures.
>
> The main impact on client code is that callers must check that
> kernel-mode NEON is usable in the current context and fall back to a
> non-NEON when necessary.  Ard has already done some work on this. [1]
>
> The interesting changes are all in patch 2: the first patch just adds a
> header inclusion guard that I noted was missing.
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git kernel-mode-neon
>
>
> I've only build-tested so far.
>
> Ard, do you have any suggestions for how to test these changes
> effectively?
>

IIRC, a zd1211 based USB wifi stick will use the mac80211 crypto
routines that execute in softirq context (and I am sure there are
others). If you run a VPN over that, and only enable a single CPU, I
would expect most code paths to get exercised when pushing a lot of
data over that. In userland, you can run something like 'openssl speed
-evp aes-128-ctr' in a loop to exercise the userland part, although it
would be better to check the correctness as well (which 'speed' will
not do for you)


> Dave Martin (2):
>   arm64: neon: Add missing header guard in <asm/neon.h>
>   arm64: neon: Remove support for nested or hardirq kernel-mode NEON
>
>  arch/arm64/include/asm/fpsimd.h       |  14 -----
>  arch/arm64/include/asm/fpsimdmacros.h |  56 -----------------
>  arch/arm64/include/asm/neon.h         |  12 +++-
>  arch/arm64/include/asm/simd.h         |  56 +++++++++++++++++
>  arch/arm64/kernel/entry-fpsimd.S      |  24 -------
>  arch/arm64/kernel/fpsimd.c            | 114 ++++++++++++++++++++++++----------
>  6 files changed, 146 insertions(+), 130 deletions(-)
>  create mode 100644 arch/arm64/include/asm/simd.h
>
> --
> 2.1.4
>
