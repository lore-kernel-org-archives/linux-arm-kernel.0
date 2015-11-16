From: rostedt@goodmis.org (Steven Rostedt)
Date: Mon, 16 Nov 2015 09:20:27 -0500
Subject: arm64 function_graph tracer panic with CONFIG_DYNAMIC_FTRACE
In-Reply-To: <564937E3.3090501@linaro.org>
References: <20151112104243.GF5627@e104818-lin.cambridge.arm.com>
 <56457A4B.601@linaro.org> <564937E3.3090501@linaro.org>
Message-ID: <20151116092027.705361fc@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Nov 2015 10:56:51 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> I think I fixed the problem.
> As you can see stack dump traces above, psci_cpu_suspend() and psci_suspend_finisher()
> are called in cpu suspend path, but they never return in cpu resume path and
> cpu_suspend() will resume directly via cpu_resume(). So those two functions should not be
> ftrace'd.

Does this crash with just the function graph tracer, or does the
function tracer show the same issue? If it is just the function graph
tracer, lets not cripple function tracing because of it.

Just call pause_graph_tracing() before the suspend code, and
unpause_graph_tracing() when returning.

This will also help keep you from playing whack-a-mole, when there are
other functions that have this issue.

-- Steve
