From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 22 Feb 2013 09:46:07 +0100
Subject: [PATCH 0/2] cpustat: use atomic operations to read/update stats
In-Reply-To: <1361512604-2720-1-git-send-email-khilman@linaro.org>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
Message-ID: <1361522767.26780.44.camel@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-02-21 at 21:56 -0800, Kevin Hilman wrote:
> On 64-bit platforms, reads/writes of the various cpustat fields are
> atomic due to native 64-bit loads/stores.  However, on non 64-bit
> platforms, reads/writes of the cpustat fields are not atomic and could
> lead to inconsistent statistics.

Which is a problem how?

> This problem was originally reported by Frederic Weisbecker as a
> 64-bit limitation with the nsec granularity cputime accounting for
> full dynticks, but then we realized that it's a problem that's been
> around for awhile and not specific to the new cputime accounting.
> 
> This series fixes this by first converting all access to the cputime
> fields to use accessor functions, and then converting the accessor
> functions to use the atomic64 functions.

Argh!! at what cost? 64bit atomics are like expensive. Wouldn't adding
a seqlock be saner?
