From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 27 Oct 2011 12:10:43 -0400 (EDT)
Subject: [PATCH] AMBA: Use suspend_noriq to force devices into runtime
	suspend
In-Reply-To: <1319730524-29483-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <Pine.LNX.4.44L0.1110271206450.2004-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Oct 2011, Ulf Hansson wrote:

> To be able to make sure devices are put into runtime suspend
> after a suspend sequence, the suspend_noirq callback is used.
> 
> Previously it was was possible for drivers doing pm_runtime_suspend
> and pm_runtime_put_sync directly from it's suspend callbacks.
> This is now not possible due to the following commit, which solve a
> race issue:
> 
> PM: Limit race conditions between runtime PM and system sleep (v2)

I have a small request for this patch:

> +static int amba_pm_runtime_suspend_noirq(struct device *dev)
> +{
...
> +}

> +static int amba_pm_runtime_resume_noirq(struct device *dev)
> +{
...
> +}

Can the names of these functions be changed?  Since they run during
system sleep transitions with IRQs disabled, they aren't really runtime
suspend or resume routines.

In fact, since each routine is used in only one place, maybe they can 
be eliminated entirely and moved into their callers?

Alan Stern
