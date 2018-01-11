From: kim.phillips@arm.com (Kim Phillips)
Date: Wed, 10 Jan 2018 18:08:21 -0600
Subject: [PATCH 00/10] perf tools: Add support for CoreSight trace decoding
In-Reply-To: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
References: <1513356299-26274-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20180110180821.a92368599af8708790e0362b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Dec 2017 09:44:49 -0700
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> This patchset adds support for per-thread CoreSight trace decoding from the
> "perf report" interface.  It is largely modelled on what has been done for 
> intelPT traces and currently targets the ETMv4 architecture.  Support for
> cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.
> 
> The trace decoding support is done using the Open CoreSight Decoding
> Library (openCSD), a stand alone open source project available here [1].
> Integration of the openCSD library with the perf tools follow what has
> been done for other support libraries.  If the library has been installed
> on a system the build scripts will include support for CoreSight trace
> decoding:
> 
> ...                          zlib: [ on  ]
> ...                          lzma: [ OFF ]
> ...                     get_cpuid: [ on  ]
> ...                           bpf: [ on  ]
> ...                    libopencsd: [ on  ] <------
> 
> Instructions on how to build and install the openCSD library are provided
> in the HOWTO.md of the project repository.  

Usually when a perf builder sees something they need "on," they - or,
at least I - start querying the host's package manager for something
that provides it (e.g., apt search/install libopencsd), but since no
distro provides libopencsd, this is bad because it misleads the user.

> We elected to keep the decoder
> library independent of the kernel tree as it is also used outside of the
> perf toolset and various non-linux projects.

Where?  Not that that won't mean it can't be included in the kernel
source tree anyway:  Doing so would enable support without burdening
the linux perf user with adding any external custom library
dependencies.

Keeping the library external will also inevitably introduce more
source level synchronization problems because the perf sources being
built may not be compatible with their version of the library, whether
due to new features like new trace hardware support, or API changes.

As Mark Brown (cc'd) mentioned on the Coresight mailing list, this may
be able to be done the same way the dtc is incorporated into the
kernel, where only its relevant sources are included and updated as
needed:  see linux/scripts/dtc/update-dtc-source.sh.

Hopefully the upstream maintainers (acme, etc.) can chime in with
their opinion on how to include the library, if at all?  It's
essentially the same type of code as the Intel-PT decoder code,
currently found under tools/perf/util/intel-pt-decoder, except we're
trying to keep some sense of connection to the parent project ("Intel
(R) Processor Trace Decoder Library" in Intel's case [1]) alive.

Thanks,

Kim

[1] https://github.com/01org/processor-trace
