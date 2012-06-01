From: vapier@gentoo.org (Mike Frysinger)
Date: Fri, 1 Jun 2012 00:36:35 -0400
Subject: [PATCH 5/9] blackfin: A couple of task->mm handling fixes
In-Reply-To: <20120423070901.GE30752@lizard>
References: <20120423070641.GA27702@lizard> <20120423070901.GE30752@lizard>
Message-ID: <201206010036.40468.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012 03:09:01 Anton Vorontsov wrote:
> 1. Working with task->mm w/o getting mm or grabing the task lock is
>    dangerous as ->mm might disappear (exit_mm() assigns NULL under
>    task_lock(), so tasklist lock is not enough).

that isn't a problem for this code as it specifically checks if it's in an 
atomic section.  if it is, then task->mm can't go away on us.

>    We can't use get_task_mm()/mmput() pair as mmput() might sleep,
>    so we have to take the task lock while handle its mm.

if we're not in an atomic section, then sleeping is fine.

> 2. Checking for process->mm is not enough because process' main
>    thread may exit or detach its mm via use_mm(), but other threads
>    may still have a valid mm.

i don't think it matters for this code (per the reasons above).

>    To catch this we use find_lock_task_mm(), which walks up all
>    threads and returns an appropriate task (with task lock held).

certainly fine for the non-atomic code path.  i guess we'll notice in crashes 
if it causes a problem in atomic code paths as well.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120601/ff9a5018/attachment.sig>
