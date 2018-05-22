From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 22 May 2018 13:10:04 -0400
Subject: [PATCH RT] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
In-Reply-To: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
Message-ID: <20180522131004.3012953c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 17 May 2018 14:40:06 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> +static DEFINE_LOCAL_IRQ_LOCK(fpsimd_lock);
>  /*
>   * Update current's FPSIMD/SVE registers from thread_struct.
>   *
> @@ -594,6 +595,7 @@ int sve_set_vector_length(struct task_struct *task,
>  	 * non-SVE thread.
>  	 */
>  	if (task == current) {
> +		local_lock(fpsimd_lock);
>  		local_bh_disable();

I'm surprised that we don't have a "local_lock_bh()"?

-- Steve

>  
>  		task_fpsimd_save();
