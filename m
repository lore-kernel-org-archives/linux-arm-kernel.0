From: wruan@quicinc.com (Ruan, Willie)
Date: Mon, 11 Jan 2010 16:52:18 -0800
Subject: [RFC 04/18] arm: cache-l2x0: add l2x0 suspend and resume functions
In-Reply-To: <20100111234424.GM7925@n2100.arm.linux.org.uk>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-5-git-send-email-dwalker@codeaurora.org>
	<20100111234424.GM7925@n2100.arm.linux.org.uk>
Message-ID: <179C5F34D68DF54C8898E904FC5BAF8C79E13E90D4@NALASEXMB09.na.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Please see my comments below with [wr].

-----Original Message-----
From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
Sent: Monday, January 11, 2010 3:44 PM
To: Daniel Walker
Cc: linux-arm-kernel at lists.infradead.org; Ruan, Willie
Subject: Re: [RFC 04/18] arm: cache-l2x0: add l2x0 suspend and resume functions

On Mon, Jan 11, 2010 at 02:47:23PM -0800, Daniel Walker wrote:
> From: Willie Ruan <wruan@quicinc.com>
> 
> Suspend function should be called before L2 cache power is turned off
> to save power. Resume function should be called when the power is
> reapplied.

What is this 'collapsed' argument for?  Who is responsible for calling
the suspend/resume functions?

[wr] The application processor in Qualcomm's 7xxx and 8xxx series chips can be powered off during Linux suspend and idle time. L2 cache is on the same power rail as the processor for current chips. We use "power collapse" to describe the action (turn off apps power) and the state (apps being powered off). The platform_suspend_ops.enter() and arch_idle() should call l2x0_suspend and l2x0_resume before and after collapsing the power. Since the action could be aborted due to pending interrupt or other events, we need to use a variable to the state whether the power was turned off or not. That state variable is 'collapsed' here.


This is clearly a case where inappropriate commenting is a problem:

[wr] Surely I can change the commit comment. I'll add WHY this patch is needed. Do you have any suggestion for the function names? They are 'suspend' and 'resume' functions, but also called in arch_idle.

> +void l2x0_resume(int collapsed)
> +{
> +	if (collapsed)
> +		/* Restore aux control register value */
> +		writel(aux_ctrl_save, l2x0_base + L2X0_AUX_CTRL);
> +
> +	/* Enable the cache */
> +	writel(1, l2x0_base + L2X0_CTRL);
> +}

The above comments provide little in the way of useful value - they
just tell the already informed reader what's going on, but not why.
Eg, a comment before the function describing what this 'collapsed'
argument is would be much more useful, and describing when this
should be called.

[wr] I can do the change. 

Thank you,
~Willie
[/wr]
