From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 26 Dec 2012 06:31:13 +0000
Subject: [PATCH 09/10] ARM: OMAP2+: clockdomain: convert existing atomic
 usecounts into spinlock-protected shorts/ints
In-Reply-To: <20121209012342.19716.66436.stgit@dusk.lan>
References: <20121209011755.19716.25244.stgit@dusk.lan>
 <20121209012342.19716.66436.stgit@dusk.lan>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ECA6D3D@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sun, Dec 09, 2012 at 06:53:43, Paul Walmsley wrote:
> The atomic usecounts seem to be confusing, and are no longer needed
> since the operations that they are attached to really should take
> place under lock.  Replace the atomic counters with simple integers,
> protected by the enclosing powerdomain spinlock.
[...]
>  
> @@ -1063,7 +1123,8 @@ static int _clkdm_clk_hwmod_enable(struct clockdomain *clkdm)
>  	 * should be called for every clock instance or hwmod that is
>  	 * enabled, so the clkdm can be force woken up.
>  	 */
> -	if ((atomic_inc_return(&clkdm->usecount) > 1) && autodeps) {
> +	clkdm->usecount++;
> +	if (clkdm->usecount > 1 && autodeps) {
>  		pwrdm_unlock(clkdm->pwrdm.ptr);
>  		return 0;
>  	}

This is not directly related to this patch but something I noticed when I enabled
the various debug prints.

if the clkdm->usecount is > 1, there is still a call to arch_clkdm->clkdm_clk_enable().
Won't the usecount >1 guarantee that the clkdm is in the right state and the PRCM
access can be skipped?

Regards,
Vaibhav
