From: oleg@redhat.com (Oleg Nesterov)
Date: Mon, 28 Jul 2014 20:58:03 +0200
Subject: TIF_NOHZ can escape nonhz mask? (Was: [PATCH v3 6/8] x86: Split
 syscall_trace_enter into two phases)
In-Reply-To: <20140728173723.GA20993@redhat.com>
References: <cover.1405992946.git.luto@amacapital.net>
 <3f649f5658a163645e3ce15156176c325283762e.1405992946.git.luto@amacapital.net>
 <20140728173723.GA20993@redhat.com>
Message-ID: <20140728185803.GA24663@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Off-topic, but...

On 07/28, Oleg Nesterov wrote:
>
> But we should always call user_exit() unconditionally?

Frederic, don't we need the patch below? In fact clear_() can be moved
under "if ()" too. and probably copy_process() should clear this flag...

Or. __context_tracking_task_switch() can simply do

	 if (context_tracking_cpu_is_enabled())
	 	set_tsk_thread_flag(next, TIF_NOHZ);
	 else
	 	clear_tsk_thread_flag(next, TIF_NOHZ);

and then we can forget about copy_process(). Or I am totally confused?


I am also wondering if we can extend user_return_notifier to handle
enter/exit and kill TIF_NOHZ.

Oleg.

--- x/kernel/context_tracking.c
+++ x/kernel/context_tracking.c
@@ -202,7 +202,8 @@ void __context_tracking_task_switch(stru
 				    struct task_struct *next)
 {
 	clear_tsk_thread_flag(prev, TIF_NOHZ);
-	set_tsk_thread_flag(next, TIF_NOHZ);
+	if (context_tracking_cpu_is_enabled())
+		set_tsk_thread_flag(next, TIF_NOHZ);
 }
 
 #ifdef CONFIG_CONTEXT_TRACKING_FORCE
