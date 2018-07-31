From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 31 Jul 2018 09:28:31 +0900
Subject: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
In-Reply-To: <d9bac115-794c-4225-bcaa-91b6847604a2@oracle.com>
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
 <20180730162235.GC4276@arm.com>
 <2651847f-79ea-fe2a-c1d7-efe4d11702b4@oracle.com>
 <20180730165757.GF4276@arm.com>
 <d9bac115-794c-4225-bcaa-91b6847604a2@oracle.com>
Message-ID: <20180731002830.GJ11258@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 04:36:28PM -0500, Dave Kleikamp wrote:
> On 07/30/2018 11:57 AM, Will Deacon wrote:
> > On Mon, Jul 30, 2018 at 11:46:24AM -0500, Dave Kleikamp wrote:
> >> On 07/30/2018 11:22 AM, Will Deacon wrote:
> >>> On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
> >>>> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
> >>>>> machine_kexec flushes the reboot_code_buffer from the icache
> >>>>> after stopping the other cpus.
> >>>>>
> >>>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> >>>>> for kernel mappings") added an IPI call to flush_icache_range, which
> >>>>> causes a hang here, so replace the call with __flush_icache_range
> >>>>
> >>>> While machine_kexec() may be called with interrupts disabled (IIUC) and
> >>>> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
> >>>> there any other CPUs online at this point?
> >>>
> >>> The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
> >>> this should only happen if we're kexec'ing a crash kernel and
> >>> smp_crash_stop_failed(). Is that something we need to care about?
> >>
> >> I observed the hang trying to kexec a crash kernel and I did not see the
> >> warning that smp_crash_stop_failed(). I'm not exactly sure why
> >> flush_icache_range() hung (but it did), but I think that
> >> __flush_icache_range() makes more sense here anyway.
> > 
> > Yeah, I'll pick the patch up, but it would be nice to understand the
> > failure case you observed.
> 
> I see why it failed. ipi_cpu_crash_stop() does not call
> set_cpu_online(cpu, false) the way ipi_cpu_stop() does. So
> cpu_online_mask is still populated with the stopped cpus.
> 
> Any reason why it isn't called there?

Because I wanted that saved cpu-related state be as close to as it was
at panic.
If cpus go offline, the core dump would show that all the cores but
a panicked one be offline whether or not they actually were.

Thanks,
-Takahiro AKASHI

> Thanks,
> Dave
> 
> > 
> > Will
> > 
