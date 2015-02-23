From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 23 Feb 2015 14:36:18 -0800
Subject: [PATCH 1/7] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
 (Viresh Kumar's message of "Wed, 11 Feb 2015 16:16:24 +0800")
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <cover.1423642246.git.viresh.kumar@linaro.org>
 <be795ef7ec98669bc5aa90ec426a1ec1fbc32b6c.1423642246.git.viresh.kumar@linaro.org>
Message-ID: <7ha904b6hp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar <viresh.kumar@linaro.org> writes:

> Current OPP (Operating performance point) DT bindings are proven to be
> insufficient at multiple instances.
>
> There had been multiple band-aid approaches to get them fixed (The latest one
> being: http://www.mail-archive.com/devicetree at vger.kernel.org/msg53398.html).
> For obvious reasons Rob rejected them and shown the right path forward.
>
> The shortcomings we are trying to solve here:
>
> - Getting clock sharing information between CPUs. Single shared clock vs
>   independent clock per core vs shared clock per cluster.
>
> - Support for turbo modes
>
> - Support for intermediate frequencies or OPPs we can switch to.
>
> - Other per OPP settings: transition latencies, disabled status, etc.?
>
> - Expandability of OPPs in future.
>
> This patch introduces new bindings "operating-points-v2" to get these problems
> solved. Refer to the bindings for more details.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

[...]

> +* OPP Descriptor Node
> +
> +This describes the OPPs belonging to a device. This node can have following
> +properties:
> +
> +Required properties:
> +- compatible: Allow OPPs to express their compatibility. It should be:
> +  "operating-points-v2".
> +- OPP nodes: One or more OPP nodes describing frequency-voltage pairs. Their
> +  name isn't significant but their phandles can be used to reference an OPP.
> +
> +Optional properties:
> +- shared-opp: Indicates that device nodes using this OPP descriptor's phandle
> +  switch their DVFS state together, i.e. they share clock lines. 

... or shared voltage rail?

> +  Missing property means devices have independent clock lines, but they share OPPs.

huh?  missing 'shared-opp' property means they share OPPs?  -ECONFUSED.

Maybe I missed some of the discussion of why this property is needed,
but I'm left wondering why it's needed explicitly.  With the OPPs as
part of the CPU nodes, shouldnt' the "shared" nature of the OPP be
easily derived from the clock and or regulator (opp-supply) property of
the CPU nodes?  IOW, if two CPU nodes share a clock and/or a regulator,
the framework should know it's "shared".

Or, were there other reasons besides clocks/regulators why this property
was needed (if so, the documentation doesn't describe them.)

Kevin
