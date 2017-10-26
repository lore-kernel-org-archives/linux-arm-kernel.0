From: julien.thierry@arm.com (Julien Thierry)
Date: Thu, 26 Oct 2017 09:50:13 +0100
Subject: arm64: ftrace: function_graph tracer not working without dynamic
 instrumentation
Message-ID: <c243a20f-e2b5-5d1c-0ace-c956eb11684c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On arm64, I noticed that when CONFIG_DYNAMIC_FTRACE is not enabled, 
using the function_graph tracer in ftrace alway gives empty traces.

The issues seems to be that the ftrace_trace_function is set to a 
function different than ftrace_stub when running mcount. If I allow 
mcount to continue beyond that check, I get the graph traces.

Guidelines given in Documentation/trace/ftrace-design.txt suggest that 
ftrace_trace_function != ftrace_stub should be checked before any 
function_graph related values and if the check is true then we shouldn't 
try to call ftrace_trace_function.

Investigating a bit more, ftrace_trace_function gets set 
ftrace_ops_no_ops in update_ftrace_function called when setting up the 
function_graph tracer.

The issue does not occur when dynamic ftrace is supported because we 
just replace some nops at known locations and replace them with branches.

It seemed to me that the arm64 side of things is following the 
guidelines in ftrace-design, so I am unsure whether it is intended that 
the ftrace_trace_function is not set to ftrace_stub when using the 
function_graph tracer.

Cheers,

-- 
Julien Thierry
