From: khilman@ti.com (Kevin Hilman)
Date: Fri, 04 Nov 2011 16:27:53 -0700
Subject: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
In-Reply-To: <1320185752-568-5-git-send-email-omar.ramirez@ti.com> (Omar
	Ramirez Luna's message of "Tue, 1 Nov 2011 17:15:52 -0500")
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
Message-ID: <87obwr1n9i.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Omar Ramirez Luna <omar.ramirez@ti.com> writes:

> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
>
> Tidspbridge uses a macro removed with this patch, for now the value
> is hardcoded to avoid breaking compilation.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>

Looks like a good cleanup.

I agree with the comments from Myungjoo, and have a question below..

[...]

> @@ -821,9 +820,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
>  	if (!obj->refcount)
>  		return IRQ_NONE;
>  
> -	clk_enable(obj->clk);
>  	errs = iommu_report_fault(obj, &da);
> -	clk_disable(obj->clk);
>  	if (errs == 0)
>  		return IRQ_HANDLED;

I'm not terribly familiar with this IOMMU code, but this one looks
suspiciou because you're removing the clock calls but not replacing them
with runtime PM get/put calls.

I just want to make sure that's intentional.  If so, you might want to
add a comment about that to the changelog.

Kevin
