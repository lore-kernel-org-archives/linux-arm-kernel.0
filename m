From: leo.yan@linaro.org (leo.yan at linaro.org)
Date: Tue, 30 Oct 2018 23:04:49 +0800
Subject: [PATCH] perf cs-etm: Correct CPU mode for samples
In-Reply-To: <20181030143226.GA23310@kernel.org>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
Message-ID: <20181030150449.GB8344@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaldo,

On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> > Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> > for vdso symbols lookup"), the kernel address cannot be properly parsed
> > to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> > CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> > thus it fails to find corresponding map/dso in below flows:
> > 
> >   process_sample_event()
> >     `-> machine__resolve()
> > 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> > 
> > In this flow it needs to pass argument 'sample->cpumode' to tell what's
> > the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> > any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> > to kallsyms for vdso symbols lookup") has been merged.  The reason is
> > even with the wrong CPU mode the function thread__find_map() firstly
> > fails to find map but it will rollback to find kernel map for vdso
> > symbols lookup.  In the latest code it has removed the fallback code,
> > thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> > anymore with kernel address.
> > 
> > This patch is to correct samples CPU mode setting, it creates a new
> > helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> > the address with the info from machine structure; this patch has a bit
> > extension to check not only kernel and user mode, but also check for
> > host/guest and hypervisor mode.  Finally this patch uses the function
> > in instruction and branch samples and also apply in cs_etm__mem_access()
> > for a minor polishing.
> 
> Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
> quickly on this one! 

Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
as I know he is travelling so might be delay a bit.

Just remind, we might need the similiar change for util/intel-pt.c and
util/intel-bts.c when generate samples, otherwise they might have the
same regression for kernel symbols.  I am not the best person to change
these two files, but bring up this for attention.

> Now processing coresight traces should be faster, less lookups :-)

Thanks!

[...]

Thanks,
Leo Yan
