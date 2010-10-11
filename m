From: robert.richter@amd.com (Robert Richter)
Date: Mon, 11 Oct 2010 13:06:54 +0200
Subject: [PATCH 7/7] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <a0c83396f5fb8a29baff3daf43d29b2e601511ff.1286584677.git.matt@console-pimps.org>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a0c83396f5fb8a29baff3daf43d29b2e601511ff.1286584677.git.matt@console-pimps.org>
Message-ID: <20101011110654.GR13563@erda.amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.10.10 20:46:22, Matt Fleming wrote:
> Now that we've got a generic perf-events based oprofile backend we might
> as well make use of it seeing as SH doesn't do anything special with its
> oprofile backend. Also introduce a new CONFIG_HW_PERF_EVENTS symbol so
> that we can fallback to using the timer interrupt for oprofile if the
> CPU doesn't support perf events.
> 
> Also, to avoid a section mismatch warning we need to annotate
> oprofile_arch_exit() with an __exit marker.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> ---
>  arch/sh/Kconfig            |   13 +++++
>  arch/sh/oprofile/Makefile  |    4 ++
>  arch/sh/oprofile/common.c  |  115 +++++++++-----------------------------------
>  arch/sh/oprofile/op_impl.h |   33 -------------
>  4 files changed, 40 insertions(+), 125 deletions(-)
>  delete mode 100644 arch/sh/oprofile/op_impl.h

> -static int op_sh_create_files(struct super_block *sb, struct dentry *root)
> +char *op_name_from_perf_id(void)
>  {
> -	int i, ret = 0;
> +	const char *pmu;
> +	char buf[20];
> +	int size;
>  
> -	for (i = 0; i < model->num_counters; i++) {
> -		struct dentry *dir;
> -		char buf[4];
> +	pmu = perf_pmu_name();
> +	if (!pmu)
> +		return NULL;
>  
> -		snprintf(buf, sizeof(buf), "%d", i);
> -		dir = oprofilefs_mkdir(sb, root, buf);
> +	size = snprintf(buf, sizeof(buf), "sh/%s", pmu);

Matt and Paul,

are those (upper case) cpu_type strings already supported by the
oprofile userland?

-Robert

> +	if (size > -1 && size < sizeof(buf))
> +		return buf;
>  
> -		ret |= oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
> -		ret |= oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
> -		ret |= oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
> -		ret |= oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
> -
> -		if (model->create_files)
> -			ret |= model->create_files(sb, dir);
> -		else
> -			ret |= oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
> -
> -		/* Dummy entries */
> -		ret |= oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
> -	}
> -
> -	return ret;
> +	return NULL;
>  }

-- 
Advanced Micro Devices, Inc.
Operating System Research Center
