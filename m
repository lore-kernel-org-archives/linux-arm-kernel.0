From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Thu, 18 Jan 2018 10:36:03 -0300
Subject: [PATCH v3 00/10] perf tools: Add support for CoreSight trace
 decoding
In-Reply-To: <20180117200440.GH12842@kernel.org>
References: <1516211539-5166-1-git-send-email-mathieu.poirier@linaro.org>
 <20180117200440.GH12842@kernel.org>
Message-ID: <20180118133603.GB18383@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, Jan 17, 2018 at 05:04:40PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jan 17, 2018 at 10:52:09AM -0700, Mathieu Poirier escreveu:
> > This patchset adds support for per-thread CoreSight trace decoding from the
> > "perf report" interface.  It is largely modelled on what has been done for
> > intelPT traces and currently targets the ETMv4 architecture.  Support for
> > cpu-wide scenarios and ETMv3/PTMv1.1 will follow shortly.
> > 
> > The trace decoding support is done using the Open CoreSight Decoding
> > Library (openCSD), a stand alone open source project available here [1].
> > Integration of the openCSD library with the perf tools follow what has
> > been done for other support libraries.  If the library has been installed
> > on a system the build scripts will automatially include support for
> > CoreSight trace decoding.  The status of the library on the system is
> > displayed when adding the VF=1 option as per Jiri's patch [2]:
> > 
> > ...			timerfd: [ on  ]
> > ...			sched_getcpu: [ on  ]
> > ...			sdt: [ OFF ]
> > ...			setns: [ on  ]
> > ...			libopencsd: [ on  ] <---
> > 
> > Instructions on how to build and install the openCSD library are provided
> > in the HOWTO.md of the project repository.  We elected to keep the decoder
> > library independent of the kernel tree as it is also used outside of the
> > perf toolset and various non-linux projects.
> > 
> > The work applies cleanly to [3] and depend on the following patches [4, 5].
> > 
> > Lastly there is a divergence of opinions on whether the decoding library
> > should be part of the kernel tree or live on its own as we chose to do -
> > your point of view on the matter would be greatly appreciated.
> 
> We have all sorts of models with perf:
> 
> 1) Code that perf has that other projects expressed interest in using in
> the past but that we so far failed to make generic in a way that
> external projects could use, with proper versioning, etc.
> 
> It lives in tools/perf/util/ but should move to tools/lib/ while
> transitioning in the direction of a lib external projects could use
> (evsel, evlist, for instance). I'm not in a hurry to make that happen,
> lots of other stuff sucking my time.
 
> 2) Code that we moved to tools/lib/ and that are since being used by
> other projects, such as tools/lib/subcmd/ that is used by tools/objtool/
 
> 3) Code that we started directly in tools/lib/ and that now are even
> maintained outside the perf tools group, but continue being used by
> perf, such as tools/lib/bpf/
 
> 4) Code that we try to share with the kernel, but using a copy that we
> automatically check for drift so that we can analyse how to update our
> copy, such as tools/include/ and tools/lib/rbtree.c
 
> And of course we use a ton of external libraries, some that are mature,
> like the elf libraries and that probably people are used to have
> installed already and some that are more recent, like libbabeltrace.
 
> Then there is the public you want to please, how easy they will find to
> use your work, think of what would happen if Linus Torvalds or Ingo
> Molnar would try to, out of the blue, use this ARM trace decoding
> support in perf, would they get it working super fast and without the
> slighest amount of hassle?

> If you think they would be pleased, you're on to a winner! :-)

To make things clearer, I don't think you have to include this in the
kernel sources if you don't want to, we've been accomodating multiple
ways of doing this integration.

I'll make some comments on the other thread about feature detection.

- Arnaldo
