From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 30 Sep 2018 08:42:18 -0700
Subject: [PATCH v3 8/9] jump_table: move entries into ro_after_init region
In-Reply-To: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
 <20180919065144.25010-9-ard.biesheuvel@linaro.org>
Message-ID: <20180930154218.GA9917@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 18, 2018 at 11:51:43PM -0700, Ard Biesheuvel wrote:
> The __jump_table sections emitted into the core kernel and into
> each module consist of statically initialized references into
> other parts of the code, and with the exception of entries that
> point into init code, which are defused at post-init time, these
> data structures are never modified.
> 
> So let's move them into the ro_after_init section, to prevent them
> from being corrupted inadvertently by buggy code, or deliberately
> by an attacker.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch results in build failures when trying to build s390
images.

s390-linux-ld:./arch/s390/kernel/vmlinux.lds:41: syntax error

Bisect log is attached.

Guenter

---
# bad: [4794a36bf08dfa89fe636e5080db9d8350e255dd] Add linux-next specific files for 20180928
# good: [6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84] Linux 4.19-rc5
git bisect start 'HEAD' 'v4.19-rc5'
# good: [d5b0eb1f139e00e8fd18329d446688b19859755e] Merge remote-tracking branch 'crypto/master'
git bisect good d5b0eb1f139e00e8fd18329d446688b19859755e
# bad: [d9c3085241c16503e659c2d7f43578f297bf30dc] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad d9c3085241c16503e659c2d7f43578f297bf30dc
# good: [db9825c95498280718c4687fcf712016f5b6f5f6] Merge tag 'drm-intel-next-2018-09-21' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good db9825c95498280718c4687fcf712016f5b6f5f6
# good: [b22777af06f425911c85d8a2c6b4ed929d4e829f] Merge remote-tracking branch 'mmc/next'
git bisect good b22777af06f425911c85d8a2c6b4ed929d4e829f
# bad: [14cb9d65a396c00eb44e1af967f1c393593f3a4c] Merge branch 'x86/microcode'
git bisect bad 14cb9d65a396c00eb44e1af967f1c393593f3a4c
# good: [c6b5da093a8ba740b71dd0052f3846016986fd21] perf intel-pt: Add decoder flags for trace begin / end
git bisect good c6b5da093a8ba740b71dd0052f3846016986fd21
# bad: [441a6b5c97e0136b416a2c12a0c361423a47c717] Merge branch 'sched/core'
git bisect bad 441a6b5c97e0136b416a2c12a0c361423a47c717
# bad: [d43b23bddade094b1a64a087bc5626a065c3c6e5] Merge branch 'locking/core'
git bisect bad d43b23bddade094b1a64a087bc5626a065c3c6e5
# good: [fa70f0d2ce96a892b38fbbaa60584af536f21f97] Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core
git bisect good fa70f0d2ce96a892b38fbbaa60584af536f21f97
# bad: [ecf89ab872e94999366834689198c436c06ab68f] Merge branch 'core/core'
git bisect bad ecf89ab872e94999366834689198c436c06ab68f
# good: [9fc0f798ab8a6c042d811e45086260eb59be45c1] x86/jump_label: Switch to jump_entry accessors
git bisect good 9fc0f798ab8a6c042d811e45086260eb59be45c1
# good: [19483677684b6ca01606f58503cb79cdfbbc7c72] jump_label: Annotate entries that operate on __init code earlier
git bisect good 19483677684b6ca01606f58503cb79cdfbbc7c72
# bad: [13ddb52c165ba47d153b7b040931a5cbe9220866] s390/jump_label: Switch to relative references
git bisect bad 13ddb52c165ba47d153b7b040931a5cbe9220866
# bad: [e872267b8bcbb179e21ccc7118f258873d6e7a59] jump_table: Move entries into ro_after_init region
git bisect bad e872267b8bcbb179e21ccc7118f258873d6e7a59
# first bad commit: [e872267b8bcbb179e21ccc7118f258873d6e7a59] jump_table: Move entries into ro_after_init region
