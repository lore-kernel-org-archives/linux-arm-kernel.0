From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Jan 2010 23:29:55 +0000
Subject: [RFC PATCH 5/5] gic: initialize interrupts as per argument
In-Reply-To: <1264620749-24527-6-git-send-email-adharmap@codeaurora.org>
References: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
	<1264620749-24527-6-git-send-email-adharmap@codeaurora.org>
Message-ID: <20100127232955.GG29665@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2010 at 11:32:29AM -0800, adharmap at codeaurora.org wrote:
> From: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> 
> Initialize interrupts as per an argument passed instead of initializing
> them as active level low triggered interrupts.
> 
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@quicinc.com>
> ---
>  Configuring level triggered interrupts as default may not be correct on
>  some platforms, this changes the default behaviour of the gic_dist_init 
>  function and also adds a flag to indicate whether the default should be level
>  or edge.

Changing the interrupt type for all interrupts is just wrong.  For on-chip
peripherals, you generally want to use level based interrupts as they're
the most efficient and simplest way to signal interrupts.

It should be a per-interrupt thing, and we already have that through
request_irq() etc.  Other platforms manage this just fine without having
to have special configuration like this.
