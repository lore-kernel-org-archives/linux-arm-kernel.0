From: broonie@kernel.org (Mark Brown)
Date: Fri, 2 May 2014 13:04:33 -0700
Subject: [PATCHv3] arm64: topology: add MPIDR-based detection
In-Reply-To: <1398814573-27389-1-git-send-email-zlim@broadcom.com>
References: <1398814573-27389-1-git-send-email-zlim@broadcom.com>
Message-ID: <20140502200433.GX3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 04:36:13PM -0700, Zi Shen Lim wrote:

This looks good to me, modulo a couple of really tiny nitpicks.

Reviwed-by: Mark Brown <broonie@linaro.org>

I'm just doing some brief testing now, I'll repost my series with this
and Lorenzo's changes included shortly assuming no issues.

>  	if (cpuid_topo->cluster_id == -1) {
> -		/*
> -		 * DT does not contain topology information for this cpu.
> -		 */
> +		/* No topology information for this cpu ?! */
>  		pr_debug("CPU%u: No topology information configured\n", cpuid);
>  		return;
>  	}

Now that we have MPIDR support (well, will with this patch) this should
probably be raised to a pr_err() since we've got ourselves confused
somehow if it ever happens - we should always be able to get topology
from MPIDR.  I'll tweak this when I repost.

> +	pr_debug("CPU%u: cluster %d core %d thread %d mpidr %llx\n",
> +		 cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
> +		 cpuid_topo->thread_id, mpidr);

I do wonder if we should print this either unconditionally or not at
all (rather than only if using MPIDR), I know Catalin and/or Lorenzo
weren't keen on noise but it is just at debug level and it's nice and
easy to refer to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140502/aa5272e8/attachment-0001.sig>
