From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 27 Apr 2017 18:17:31 +0100
Subject: [PATCH] arm64: cpufeature: use static_branch_enable_cpuslocked()
In-Reply-To: <2e321402-7042-9d5b-aa85-52b0e6f1e20c@arm.com>
References: <20170426085958.GC27156@leverpostej>
 <bad40d9a-2c81-5a6c-2c12-3bf7094549de@arm.com>
 <20170426103236.GI27156@leverpostej>
 <20170427082719.3wyru4bk67kdmflb@linutronix.de>
 <20170427095744.GB31337@leverpostej>
 <alpine.DEB.2.20.1704271200420.4607@nanos>
 <20170427123056.GD31337@leverpostej>
 <20170427154806.GA6646@leverpostej>
 <20170427163546.GA30972@e107814-lin.cambridge.arm.com>
 <2e321402-7042-9d5b-aa85-52b0e6f1e20c@arm.com>
Message-ID: <20170427171730.GB7114@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 27, 2017 at 06:03:35PM +0100, Suzuki K Poulose wrote:
> On 27/04/17 17:35, Suzuki K Poulose wrote:
> >@@ -1092,7 +1093,9 @@ void check_local_cpu_capabilities(void)
> >
> > static void __init setup_feature_capabilities(void)
> > {
> >-	update_cpu_capabilities(arm64_features, "detected feature:");
> >+	get_online_cpus();
> >+	update_cpu_capabilities(arm6_features, "detected feature:");
> 
> s/arm6_features/arm64_features
> 
> And we need the following hunk:
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 62bdab4..19c359a 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1086,7 +1086,7 @@ void check_local_cpu_capabilities(void)
>          * advertised capabilities.
>          */
>         if (!sys_caps_initialised)
> -               update_cpu_errata_workarounds();
> +               update_secondary_cpu_errata_workarounds();
>         else
>                 verify_local_cpu_capabilities();
>  }
> 
> Sorry about that.

No worries; thanks for the fixups.

With those this is working for me, so I'll send this and Sebastian's
patch (with Ccs) as a new series.

> 
> Suzuki
