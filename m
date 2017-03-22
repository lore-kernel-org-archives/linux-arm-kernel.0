From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 22 Mar 2017 13:44:57 -0700
Subject: [PATCH v4 1/4] syscalls: Restore address limit after a syscall
In-Reply-To: <20170322203834.67556-1-thgarnie@google.com>
References: <20170322203834.67556-1-thgarnie@google.com>
Message-ID: <CALCETrV6K8iSfAwojMFyLrbb3CG2aF4k5hPWc7EDV4ErPDq64w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 1:38 PM, Thomas Garnier <thgarnie@google.com> wrote:
> This patch ensures a syscall does not return to user-mode with a kernel
> address limit. If that happened, a process can corrupt kernel-mode
> memory and elevate privileges.
>
> For example, it would mitigation this bug:
>
> - https://bugs.chromium.org/p/project-zero/issues/detail?id=990
>
> If the CONFIG_BUG_ON_DATA_CORRUPTION option is enabled, an incorrect
> state will result in a BUG_ON.

I'm a bit confused about this choice of configurability.  I can see
two sensible choices:

1. Enable this hardening feature: BUG if there's an exploitable bug.

2. Don't enable it at all.

While it's possible that silently papering over the bug is slightly
faster than BUGging, it will allow bugs to continue to exist
undetected.

--Andy
