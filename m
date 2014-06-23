From: keescook@chromium.org (Kees Cook)
Date: Mon, 23 Jun 2014 14:58:04 -0700
Subject: [PATCH v7 0/9] seccomp: add thread sync ability
Message-ID: <1403560693-21809-1-git-send-email-keescook@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the ability for threads to request seccomp filter
synchronization across their thread group (at filter attach time).
For example, for Chrome to make sure graphic driver threads are fully
confined after seccomp filters have been attached.

To support this, locking on seccomp changes is introduced, along with
refactoring of no_new_privs. Races with thread creation/death are handled
via tasklist_lock.

This includes a new syscall (instead of adding a new prctl option),
as suggested by Andy Lutomirski and Michael Kerrisk.

Thanks!

-Kees

v7:
 - rebase on Linus's tree (merged with network bpf changes)
 - wrote manpage text documenting API (follows this series)
v6:
 - switch from seccomp-specific lock to thread-group lock to gain atomicity
 - implement seccomp syscall across all architectures with seccomp filter
 - clean up sparse warnings around locking
v5:
 - move includes around (drysdale)
 - drop set_nnp return value (luto)
 - use smp_load_acquire/store_release (luto)
 - merge nnp changes to seccomp always, fewer ifdef (luto)
v4:
 - cleaned up locking further, as noticed by David Drysdale
v3:
 - added SECCOMP_EXT_ACT_FILTER for new filter install options
v2:
 - reworked to avoid clone races
