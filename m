From: adrian.hunter@intel.com (Adrian Hunter)
Date: Mon, 19 Sep 2016 09:15:40 +0300
Subject: [PATCH V5] perf tools: adding support for address filters
In-Reply-To: <20160917223311.19dac50f03da4f40fd5cc844@kernel.org>
References: <1473702794-8493-1-git-send-email-mathieu.poirier@linaro.org>
 <cd7b9dc9-686c-813e-ff9f-97faba377799@intel.com>
 <CANLsYkz_rQ5uhJQ0x9EDi6vcx4xHrbjjSdwxA=X1ssHq4ucALQ@mail.gmail.com>
 <20160914082535.3304d51a1a6a085234f77529@kernel.org>
 <CANLsYkwRUps0Mtc_yQfNOW+qsmOXT8yaGrDj4566LPPTrLsUxg@mail.gmail.com>
 <20160917223311.19dac50f03da4f40fd5cc844@kernel.org>
Message-ID: <008718a0-13bf-8245-e2ee-562cffeba3c5@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/09/16 16:33, Masami Hiramatsu wrote:
> On Fri, 16 Sep 2016 09:32:43 -0600
> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
>> On 13 September 2016 at 17:25, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> On Tue, 13 Sep 2016 08:18:10 -0600
>>> Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>>>
>>>> On 13 September 2016 at 04:01, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>> On 12/09/16 20:53, Mathieu Poirier wrote:
>>>>>> This patch makes it possible to use the current filter
>>>>>> framework with address filters.  That way address filters for
>>>>>> HW tracers such as CoreSight and IntelPT can be communicated
>>>>>> to the kernel drivers.
>>>>>>
>>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>>>
>>>>>> ---
>>>>>> Changes for V5:
>>>>>>  - Modified perf_evsel__append_filter() to take a string format
>>>>>>    rather than an operation.
>>>>>
>>>>> Hope I'm not being a pain, but aren't there other places calling
>>>>> perf_evsel__append_filter() that need to be changed.  Might make
>>>>> sense as a separate patch.
>>>>
>>>> No no, you're right - I completely overlooked that.
>>>>
>>>> But shouldn't it be in the same patch?  That way a git bisect would
>>>> stay consistent...
>>>
>>> You're right. Caller and callee should be changed in atomic.
>>>
>>> BTW, could you add document updates how the perf command line
>>> will be changed, and also show the result in the patch description?
>>
>> This patch does not change anything on the perf command line.  It
>> simply allows current options to succeed (as they should) rather than
>> fail.
> 
> Yes, and it will make perf acceptable to pass --filter to CoreSight or
> Intel PT events, or am I misunderstand?
> If it is correct, could you give us an example how to pass it, since
> tools/perf/Documentation/perf-record.txt says it is only for tracepoints?

I am adding support for symbols in the address filter.  I will send the
patches soon, but the documentation will be:

--filter=<filter>::
        Event filter. This option should follow a event selector (-e) which
	selects either tracepoint event(s) or a hardware trace PMU
	(e.g. Intel PT or CoreSight).

	- tracepoint filters

	In the case of tracepoints, multiple '--filter' options are combined
	using '&&'.

	- address filters

	A hardware trace PMU advertises its ability to accept a number of
	address filters	by specifying a non-zero value in
	/sys/bus/event_source/devices/<pmu>/nr_addr_filters.

	Address filters have the format:
	
	filter|start|stop|tracestop <start> [/ <size>] [@<file name>]
	
	Where:
	- 'filter': defines a region that will be traced.
	- 'start': defines an address at which tracing will begin.
	- 'stop': defines an address at which tracing will stop.
	- 'tracestop': defines a region in which tracing will stop.

	<file name> is the name of the object file, <start> is the offset to the
	code to trace in that file, and <size> is the size of the region to
	trace. 'start' and 'stop' filters need not specify a <size>.

	If no object file is specified then the kernel is assumed, in which case
	the start address must be a current kernel memory address.

	<start> can also be specified by providing the name of a symbol. If the
	symbol name is not unique, it can be disambiguated by inserting #n where
	'n' selects the n'th symbol in address order. Alternately #0, #g or #G
	select only a global symbol. <size> can also be specified by providing
	the name of a symbol, in which case the size is calculated to the end
	of that symbol. For 'filter' and 'tracestop' filters, if <size> is
	omitted and <start> is a symbol, then the size is calculated to the end
	of that symbol.

	If <size> is omitted and <start> is '*', then the start and size will
	be calculated from the first and last symbols, i.e. to trace the whole
	file.

	If symbol names (or "*") are provided, they must be surrounded by white
	space.

	The filter passed to the kernel is not necessarily the same as entered.
	To see the filter that is passed, use the -v option.

	The kernel may not be able to configure a trace region if it is not
	within a single mapping.  MMAP events (or /proc/<pid>/maps) can be
	examined to determine if that is a possibility.

	Multiple filters can be separated with space or comma.
