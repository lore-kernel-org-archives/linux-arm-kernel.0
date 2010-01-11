From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:44:24 +0000
Subject: [RFC 04/18] arm: cache-l2x0: add l2x0 suspend and resume functions
In-Reply-To: <1263250057-26692-5-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-5-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111234424.GM7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:23PM -0800, Daniel Walker wrote:
> From: Willie Ruan <wruan@quicinc.com>
> 
> Suspend function should be called before L2 cache power is turned off
> to save power. Resume function should be called when the power is
> reapplied.

What is this 'collapsed' argument for?  Who is responsible for calling
the suspend/resume functions?

This is clearly a case where inappropriate commenting is a problem:

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
