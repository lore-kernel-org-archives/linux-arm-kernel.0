From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 8 Jan 2018 10:45:06 -0700
Subject: [PATCH 00/10] perf tools: Add support for CoreSight trace decoding
In-Reply-To: <20171230005137.GE600@leoy-linaro>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
 <20171230005137.GE600@leoy-linaro>
Message-ID: <CANLsYkxWitMR_0D2B4Ra2JE+8XLBr8t1-BFV0YRA_TTE9MENDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good day Leo,

On 29 December 2017 at 17:51, Leo Yan <leo.yan@linaro.org> wrote:
> Hi Mathieu,
>
> On Fri, Dec 15, 2017 at 09:44:49AM -0700, Mathieu Poirier wrote:
>> This patchset adds support for per-thread CoreSight trace decoding from the
>> "perf report" interface.  It is largely modelled on what has been done for
>> intelPT traces and currently targets the ETMv4 architecture.  Support for
>> cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.
>>
>> The trace decoding support is done using the Open CoreSight Decoding
>> Library (openCSD), a stand alone open source project available here [1].
>> Integration of the openCSD library with the perf tools follow what has
>> been done for other support libraries.  If the library has been installed
>> on a system the build scripts will include support for CoreSight trace
>> decoding:
>>
>> ...                          zlib: [ on  ]
>> ...                          lzma: [ OFF ]
>> ...                     get_cpuid: [ on  ]
>> ...                           bpf: [ on  ]
>> ...                    libopencsd: [ on  ] <------
>>
>> Instructions on how to build and install the openCSD library are provided
>> in the HOWTO.md of the project repository.  We elected to keep the decoder
>> library independent of the kernel tree as it is also used outside of the
>> perf toolset and various non-linux projects.
>>
>> The work applies cleanly to [2] and proper functionning of the feature
>> depends on this patch [3].
>
> With latest perf code, it reports another error when analyse perf
> data: "0x3e0 [0x50]: failed to process type: 1".
>
> After roughly analysis, I found this is caused by one dummy event (in
> the binary from offset 0xf8 to offset 0x178). Because this event type
> is not set for 'PERF_SAMPLE_TIME', so the function
> perf_evsel__parse_sample_timestamp() checks the event has not set
> 'PERF_SAMPLE_TIME' then directly bail out with error.

This patch should fix the problem: https://patchwork.kernel.org/patch/10121515/

>
> 000000f0: 0800 0000 0000 0000 0100 0000 7000 0000  ............p...
> 00000100: 0900 0000 0000 0000 0100 0000 0000 0000  ................
> 00000110: 0300 0100 0000 0000 0400 0000 0000 0000  ................
> 00000120: 6133 8401 0000 0000 0000 0000 0000 0000  a3..............
> 00000130: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 00000140: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 00000150: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 00000160: 0000 0000 0000 0000 7000 0000 0000 0000  ........p.......
> 00000170: 0800 0000 0000 0000 4600 0000 0000 6802  ........F.....h.
>
> You could check the perf binary from [1]. Please note, this perf data
> I capatured from kernel 4.14-rc6, so is it might be compatible issue
> between 4.14-rc6 and 4.15?
>
> [1] http://people.linaro.org/~leo.yan/binaries/perf_4.15_r4/perf.data
>
> Thanks,
> Leo Yan
>
>> Review and comments would be greatly appreciated.
>>
>> Regards,
>> Mathieu
>>
>> [1]. https://github.com/Linaro/OpenCSD
>> [2]. git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>> [3]. https://lkml.org/lkml/2017/12/14/612
>>
>> Mathieu Poirier (8):
>>   perf tools: Integrating the CoreSight decoding library
>>   perf tools: Add initial entry point for decoder CoreSight traces
>>   perf tools: Add decoder mechanic to support dumping trace data
>>   perf tools: Add support for decoding CoreSight trace data
>>   perf tools: Add functionality to communicate with the openCSD decoder
>>   pert tools: Add queue management functionality
>>   perf tools: Add full support for CoreSight trace decoding
>>   perf tools: Add mechanic to synthesise CoreSight trace packets
>>
>> Tor Jeremiassen (2):
>>   perf tools: Add processing of coresight metadata
>>   MAINTAINERS: Adding entry for CoreSight trace decoding
>>
>>  MAINTAINERS                                     |    3 +-
>>  tools/build/Makefile.feature                    |    6 +-
>>  tools/build/feature/Makefile                    |    6 +-
>>  tools/build/feature/test-all.c                  |    5 +
>>  tools/build/feature/test-libopencsd.c           |    8 +
>>  tools/perf/Makefile.config                      |   13 +
>>  tools/perf/util/Build                           |    6 +
>>  tools/perf/util/auxtrace.c                      |    2 +
>>  tools/perf/util/cs-etm-decoder/Build            |    1 +
>>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  513 ++++++++++++
>>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  105 +++
>>  tools/perf/util/cs-etm.c                        | 1023 +++++++++++++++++++++++
>>  tools/perf/util/cs-etm.h                        |   18 +
>>  13 files changed, 1705 insertions(+), 4 deletions(-)
>>  create mode 100644 tools/build/feature/test-libopencsd.c
>>  create mode 100644 tools/perf/util/cs-etm-decoder/Build
>>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
>>  create mode 100644 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
>>  create mode 100644 tools/perf/util/cs-etm.c
>>
>> --
>> 2.7.4
>>
