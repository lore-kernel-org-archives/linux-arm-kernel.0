From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jul 2018 17:22:35 +0100
Subject: [PATCH 1/1] arm64: kexec: machine_kexec should call
 __flush_icache_range
In-Reply-To: <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
References: <faf6c7cb-d9da-9a9c-cc0f-43c95e864ca2@oracle.com>
 <e07fc674-2a71-29ae-2212-46ee5f79593d@oracle.com>
 <20180730161641.6zxxy3lxp27tznck@armageddon.cambridge.arm.com>
Message-ID: <20180730162235.GC4276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 05:16:42PM +0100, Catalin Marinas wrote:
> On Mon, Jul 30, 2018 at 10:29:21AM -0500, Dave Kleikamp wrote:
> > machine_kexec flushes the reboot_code_buffer from the icache
> > after stopping the other cpus.
> > 
> > Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache
> > for kernel mappings") added an IPI call to flush_icache_range, which
> > causes a hang here, so replace the call with __flush_icache_range
> 
> While machine_kexec() may be called with interrupts disabled (IIUC) and
> we shouldn't IPI other CPUs, I don't understand why it hangs here. Are
> there any other CPUs online at this point?

The BUG_ON and WARN_ON at the start of machine_kexec() suggest to me that
this should only happen if we're kexec'ing a crash kernel and
smp_crash_stop_failed(). Is that something we need to care about?

Will
