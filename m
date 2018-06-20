From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 Jun 2018 15:51:55 +0200
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <20180619091735.7aec75d0@gandalf.local.home>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
 <b9f269ed2143688c38cdcbba7367b101@agner.ch>
 <20180619091735.7aec75d0@gandalf.local.home>
Message-ID: <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.06.2018 15:17, Steven Rostedt wrote:
> On Tue, 19 Jun 2018 10:16:19 +0200
> Stefan Agner <stefan@agner.ch> wrote:
> 
>> > I'm guessing that it boots fine with CONFIG_FTRACE_STARTUP_TEST=n? Can
>> > you try disable the tracers to see if it's the function graph or
>> > function tracer that is causing the issue? That is, turn off
>> > CONFIG_FUNCTION_GRAPH_TRACER and test it again, and if that crashes,
>> > turn off CONFIG_FUNCTION_TRACER to make sure the crash goes away there
>> > too.
>>
>> Without CONFIG_FTRACE_STARTUP_TEST the kernel boots fine.
>>
>> CONFIG_FUNCTION_TRACER=y
>> # CONFIG_FUNCTION_GRAPH_TRACER is not set
>> # CONFIG_SCHED_TRACER is not set
>> CONFIG_FTRACE_STARTUP_TEST=y
> 
> OK, so it's not a graph tracer issue, but a function tracer issue.
> 
>>
>> Crashes with the same stack trace.
>>
>> # CONFIG_FUNCTION_TRACER is not set
>> CONFIG_SCHED_TRACER=y
>> CONFIG_FTRACE_STARTUP_TEST=y
>>
>> Runs tracer tests and boots fine.
> 
> Thanks. Did this ever work? And if so, perhaps you have time to perform
> a bisect. If you have a ktest setup, you can have it run the bisect for
> you (over night).

v4.9 seems to work, so I started bisecting. It turned out that commit
6f05d0761af6 ("ARM: 8668/1: ftrace: Fix dynamic ftrace with DEBUG_RODATA
and !FRAME_POINTER") broke it, introduced during the v4.12 merge window.

I did not look closer into it yet.

Abel, maybe you see what is going on here?

--
Stefan
