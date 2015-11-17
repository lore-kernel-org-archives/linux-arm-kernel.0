From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 17 Nov 2015 10:12:55 +0000
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
In-Reply-To: <564A773D.6040209@linaro.org>
References: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
 <56457A4B.601@linaro.org> <564937E3.3090501@linaro.org>
 <20151116134518.GC6556@e104818-lin.cambridge.arm.com>
 <20151116154822.GA19228@red-moon> <564A773D.6040209@linaro.org>
Message-ID: <20151117101255.GA940@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 09:39:25AM +0900, AKASHI Takahiro wrote:
> On 11/17/2015 12:48 AM, Lorenzo Pieralisi wrote:
> >On Mon, Nov 16, 2015 at 01:45:19PM +0000, Catalin Marinas wrote:
> >
> >[...]
> >
> >>>There are some other functions which are called by cpu_suspend(), e.g. psci_system_suspend().
> >>>Should we apply a similar fix to them?
> >>
> >>I think we need to apply the fix to any function which does not return.
> >>In general, this should apply to all finishers passed to cpu_suspend()
> >>and the subsequent callees.
> >
> >Yes, I prefer Steven's suggestion though it seems to me the issue
> >is only related to the graph tracer and by pausing/resuming tracing
> >across cpu_suspend() we would solve the problem without having to
> >patch the finishers (and we can still trace them with the function
> >tracer).
> 
> Aha, I didn't know this option. Yes, the issue is function_graph specific.
> I confirmed that we could fix it by sandwiching __cpu_suspend_enter()
> in cpu_suspend() between pause/unpause_graph_tracing().

Yes, the problem is that we are pushing trace contexts on the trace
stack but we are not popping them (ie suspend finishers do not
return), then we pop the wrong trace stack when we go back to cpu_suspend()
from cpu_resume().

> >Takahiro, do you want me to send a patch or you update yours ?
> 
> I think you're the best person.
> one question: do we need 'notrace' against __cpu_suspend_save()?

No, I will remove that with a separate patch.

> >>Do we need such annotation for cpu_die() as well? It probably doesn't
> >>matter as the CPU is coming back on a completely different path anyway.
> >
> >I will test this too in the process.
> 
> Function_graph related info is per-task, and it means that, if cpu_die()
> destroys idle thread, we don't have to care.
> But testing is always crucial.

I am testing the hotplug path with the graph tracer, it seems to work
fine I will continue testing it.

Patch coming, please have a look.

Thanks,
Lorenzo
