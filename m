From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 23 Apr 2012 00:06:41 -0700
Subject: [PATCH v3 0/9] Fixes for common mistakes w/ for_each_process and
 task->mm
Message-ID: <20120423070641.GA27702@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is another resend of several task->mm fixes, the bugs I found
during LMK code audit. Architectures were traverse the tasklist
in an unsafe manner, plus there are a few cases of unsafe access to
task->mm in general.

There were no objections on the previous resend, and the final words
were somewhere along "the patches are fine" line.

In v3:
- Dropped a controversal 'Make find_lock_task_mm() sparse-aware' patch;
- Reword arm and sh commit messages, per Oleg Nesterov's suggestions;
- Added an optimization trick in clear_tasks_mm_cpumask(): take only
  the rcu read lock, no need for the whole tasklist_lock.
  Suggested by Peter Zijlstra.

In v2: 
- introduced a small helper in cpu.c: most arches duplicate the
  same [buggy] code snippet, so it's better to fix it and move the
  logic into a common function.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
