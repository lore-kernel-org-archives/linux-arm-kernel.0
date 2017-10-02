From: kim.phillips@arm.com (Kim Phillips)
Date: Mon, 2 Oct 2017 18:35:24 -0500
Subject: [PATCH v5 6/7] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20171002164930.GB2121@redhat.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-7-git-send-email-will.deacon@arm.com>
 <20170929171940.2aa33d00463b1e9c987aea15@arm.com>
 <20171002141405.GC12847@arm.com> <20171002164930.GB2121@redhat.com>
Message-ID: <20171002183524.ab23b255b6d03331bb36f75a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Oct 2017 13:49:30 -0300
Arnaldo Carvalho de Melo <acme@redhat.com> wrote:

> Em Mon, Oct 02, 2017 at 03:14:05PM +0100, Will Deacon escreveu:
> > On Fri, Sep 29, 2017 at 05:19:40PM -0500, Kim Phillips wrote:
> > > On Thu, 28 Sep 2017 15:09:50 +0100
> > > Will Deacon <will.deacon@arm.com> wrote:
> > > > +	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> > > > +		return -EOPNOTSUPP;
> > > > +	if (attr->exclude_idle)
> > > > +		return -EOPNOTSUPP;
> 
> > > "PMU Hardware doesn't support sampling/overflow-interrupts." will be
> > > printed if the user didn't specify a sample period.  Otherwise, a
> > > string with "/bin/dmesg may provide additional information." will be
> > > printed.
> 
> > > I was hoping for a response from acme by now for this:
> 
> > > https://www.spinics.net/lists/linux-perf-users/msg04066.html
> 
> > > Alas, nothing.  Looking at the #ifdef x86 in evsel.c, I'm guessing
> > > it'll be ok, although I'm still not sure how PMU-specific we can get in
> > > evsel.c, nor whether it's ok to communicate lists of h/w supported
> > > sample periods through /sys/bus/event_source/devices/...
> > > 
> > > acme?  OK to refactor evsel messaging for Arm, including parsing for
> > > which PMUs are being used, so customize the message?
> > 
> > Arnaldo's probably got enough on his plate maintaining perf tool, so my
> > advice would be to post a patch as an RFC and use that as a concrete basis
> > for discussion. It often works out better starting with code, even if none
> > of it ends up getting merged (and you can include bits of your email above
> > in the cover letter).

That's what I had originally done with the supplemental error message
facility, yet got no response:

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1472313.html

But we're past that now I've learned the dependency was nacked on a
non-public mailing list.

> I'm all for more informative messages, and if you guys agree on how to
> provide the info in a way that combined with logic in evsel.c, I'd say
> do what Will suggested, post a patch series and include usage examples,
> before and after.

I'll figure out how to get the PMU in evsel.c's strerror fn, and give it
another shot.  I don't think it'll be a big problem for the SPE driver
itself, it's just some of the other drivers have long lists of reasons
to return -EXXXX, and I don't think evsel.c's strerror fn should be
able to handle all that.

Meanwhile, when I build this v5 arm_spe_pmu as a module, load it, do a
perf list, rmmod it, then re-load it, I get an Oops:

# insmod arm_spe_pmu.ko
[ 2018.623646] arm_spe_pmu spe-pmu at 0: probed for CPUs 0-3 [max_record_sz 64, align 1, features 0xf]
[ 2018.626346] arm_spe_pmu spe-pmu at 1: probed for CPUs 4-7 [max_record_sz 64, align 1, features 0xf]
# ./perf list
[ 2021.649688] Unable to handle kernel NULL pointer dereference at virtual address 00000038
[ 2021.649769] Mem abort info:
[ 2021.649851]   Exception class = DABT (current EL), IL = 32 bits
[ 2021.649851]   SET = 0, FnV = 0
[ 2021.649952]   EA = 0, S1PTW = 0
[ 2021.649952] Data abort info:
[ 2021.650073]   ISV = 0, ISS = 0x00000006
[ 2021.650097]   CM = 0, WnR = 0
[ 2021.650179] user pgtable: 4k pages, 48-bit VAs, pgd = ffff80007a8f7000
[ 2021.650261] [0000000000000038] *pgd=00000000fac75003, *pud=00000000f9146003, *pmd=0000000000000000
[ 2021.650362] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[ 2021.650446] Modules linked in: arm_spe_pmu [last unloaded: arm_spe_pmu]
[ 2021.650564] CPU: 3 PID: 2456 Comm: perf Not tainted 4.14.0-rc3-00012-g43cb9545da3d-dirty #18
[ 2021.650646] Hardware name: FVP Base (DT)
[ 2021.650671] task: ffff80007ab9c600 task.stack: ffff0000133a0000
[ 2021.650752] PC is at perf_pmu_disable+0xc/0x30
[ 2021.650853] LR is at ctx_resched+0x38/0xb0
[ 2021.650853] pc : [<ffff0000081566fc>] lr : [<ffff000008157b00>] pstate: 404001c9
[ 2021.650998] sp : ffff0000133a3be0
[ 2021.651056] x29: ffff0000133a3be0 x28: ffff80007a361400
[ 2021.651162] x27: ffff80007ab9c600 x26: 0000000000000000
[ 2021.651251] x25: ffff80007ab9c600 x24: 0000000000000000
[ 2021.651263] x23: 0000000000000000 x22: 0000000000000001
[ 2021.651408] x21: ffff80007a393f00 x20: ffff80007df86280
[ 2021.651446] x19: 0000000000000001 x18: 0000ffffc116eaf0
[ 2021.651546] x17: 0000ffff867dbcd0 x16: ffff00000815ca10
[ 2021.651654] x15: 0000ffff8685d588 x14: 00000000000000c0
[ 2021.651755] x13: 0000000002000000 x12: 0000000000000020
[ 2021.651880] x11: 0000000000000000 x10: 7f7f7f7f7f7f7f7f
[ 2021.651946] x9 : ffff80007a361400 x8 : ffff80007a361400
[ 2021.652063] x7 : 0000000000000000 x6 : ffff000008c89dd8
[ 2021.652146] x5 : 000000000000001f x4 : 0000800075313000
[ 2021.652246] x3 : 0000000000000009 x2 : 0000000000000001
[ 2021.652246] x1 : ffff80007a393f00 x0 : 0000000000000000
[ 2021.652391] Process perf (pid: 2456, stack limit = 0xffff0000133a0000)
[ 2021.652473] Call trace:
[ 2021.652555] Exception stack(0xffff0000133a3aa0 to 0xffff0000133a3be0)
[ 2021.652656] 3aa0: 0000000000000000 ffff80007a393f00 0000000000000001 0000000000000009
[ 2021.652748] 3ac0: 0000800075313000 000000000000001f ffff000008c89dd8 0000000000000000
[ 2021.652858] 3ae0: ffff80007a361400 ffff80007a361400 7f7f7f7f7f7f7f7f 0000000000000000
[ 2021.652964] 3b00: 0000000000000020 0000000002000000 00000000000000c0 0000ffff8685d588
[ 2021.653046] 3b20: ffff00000815ca10 0000ffff867dbcd0 0000ffffc116eaf0 0000000000000001
[ 2021.653146] 3b40: ffff80007df86280 ffff80007a393f00 0000000000000001 0000000000000000
[ 2021.653246] 3b60: 0000000000000000 ffff80007ab9c600 0000000000000000 ffff80007ab9c600
[ 2021.653374] 3b80: ffff80007a361400 ffff0000133a3be0 ffff000008157b00 ffff0000133a3be0
[ 2021.653456] 3ba0: ffff0000081566fc 00000000404001c9 0000000000000000 ffff80007df88f20
[ 2021.653557] 3bc0: 0001000000000000 ffff000008156778 ffff0000133a3be0 ffff0000081566fc
[ 2021.653702] [<ffff0000081566fc>] perf_pmu_disable+0xc/0x30
[ 2021.653784] [<ffff000008157b00>] ctx_resched+0x38/0xb0
[ 2021.653865] [<ffff000008157e94>] __perf_install_in_context+0xe4/0x148
[ 2021.653946] [<ffff000008153408>] remote_function+0x60/0x70
[ 2021.654046] [<ffff000008122c6c>] generic_exec_single+0xdc/0x128
[ 2021.654158] [<ffff000008122dd8>] smp_call_function_single+0x120/0x168
[ 2021.654246] [<ffff00000815102c>] task_function_call+0x3c/0x58
[ 2021.654275] [<ffff00000815394c>] perf_install_in_context+0x84/0x120
[ 2021.654357] [<ffff00000815d4b8>] SyS_perf_event_open+0xaa8/0xcf8
[ 2021.654458] Exception stack(0xffff0000133a3ec0 to 0xffff0000133a4000)
[ 2021.654603] 3ec0: 000000003bc8ab48 0000000000000000 00000000ffffffff 00000000ffffffff
[ 2021.654685] 3ee0: 0000000000000008 0000000000000008 0000000000000000 0000000000000000
[ 2021.654767] 3f00: 00000000000000f1 0000000000000004 0000000000000000 0000000000000008
[ 2021.654849] 3f20: 000000000000001b 0000000002000000 00000000000000c0 0000ffff8685d588
[ 2021.654949] 3f40: 000000000061f798 0000ffff867dbcd0 0000ffffc116eaf0 0000000000000000
[ 2021.655069] 3f60: 0000000000000000 0000000000406550 0000000000000000 0000000000000000
[ 2021.655176] 3f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 2021.655258] 3fa0: 0000000000000000 0000ffffc116ec10 00000000004ab98c 0000ffffc116ec10
[ 2021.655359] 3fc0: 0000ffff867dbcf4 0000000060000000 000000003bc8ab48 00000000000000f1
[ 2021.655504] 3fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[ 2021.655586] [<ffff0000080837b0>] el0_svc_naked+0x24/0x28
[ 2021.655668] Code: d503201f a9bf7bfd 910003fd d538d084 (f9401c01)
[ 2021.655750] ---[ end trace 0aa18f6f0dec9036 ]---
[ 2021.655980] note: perf[2456] exited with preempt_count 3
 
The PC is at perf_pmu_disable+0xc/0x30, which is line 1070 in
kernel/events/core.c:

void perf_pmu_disable(struct pmu *pmu)
{
        int *count = this_cpu_ptr(pmu->pmu_disable_count);  <<<< here
        if (!(*count)++)
                pmu->pmu_disable(pmu);
}

Looking at it briefly, it doesn't look to be driver problem, rather
this would happen with any PMU driver built as a module.

I tested this diff:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6bc21e202ae4..9d886db68999 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1067,14 +1067,24 @@ static int perf_mux_hrtimer_restart(struct perf_cpu_context *cpuctx)
 
 void perf_pmu_disable(struct pmu *pmu)
 {
-       int *count = this_cpu_ptr(pmu->pmu_disable_count);
+       int *count;
+
+       if (!pmu)
+               return;
+
+       count = this_cpu_ptr(pmu->pmu_disable_count);
        if (!(*count)++)
                pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-       int *count = this_cpu_ptr(pmu->pmu_disable_count);
+       int *count;
+
+       if (!pmu)
+               return;
+
+       count = this_cpu_ptr(pmu->pmu_disable_count);
        if (!--(*count))
                pmu->pmu_enable(pmu);
 }

and running 'perf list' and ins/rmmoding the PMU driver multiple
times now works fine.  No idea if the above is acceptable, however.
I'll post as a patch if it sounds like it will be...

Thanks,

Kim

p.s. The original failing version, including this v5 of the  SPE driver
and tool component, all based on 4.14-rc3, is available here:

http://www.linux-arm.org/git?p=linux-kp.git;a=shortlog;h=refs/heads/willv5%2Btoolprev2
