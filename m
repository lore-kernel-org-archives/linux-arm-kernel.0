From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 11 Jan 2016 11:25:49 +0000
Subject: arm/arm64 HARDLOCKUP Detector and PERF NMI support
In-Reply-To: <20160111102658.GB6499@leverpostej>
References: <569199C0.9030500@samsung.com> <5691A23C.8060807@samsung.com>
 <20160111102658.GB6499@leverpostej>
Message-ID: <5693913D.5060308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/16 10:26, Mark Rutland wrote:
> Hi,
>
> On Sat, Jan 09, 2016 at 04:13:48PM -0800, Mario Smarduch wrote:
>> I'm trying to get HARDLOCKUP detector to work on arm (on foundation
>> model and Juno, but armv7 should have the same issue). Turns out there is no
>> PERF NMI support (HAVE_PERF_EVENTS_NMI), which I guess would be PMU NMI - I
>> tested overflow on cycle counter and PMU interrupts can be masked. HARDLOCKUP
>> assumes perf interrupts are non-maskable and uses the PMU to program an NMI to
>> detect hard lockup and that in turn drives softlockup detection.
>>
>> Is there something, someplace in ARM manuals that addresses this, searched the
>> manuals but couldn't find anything?
>>
>> Or other approaches that I'm not aware off or have floated on the mailing list.
>
> Russell and Daniel did some work [1,2] to use FIQs as NMIs on arm, for
> backtracing and PMU overflow.
 >
> For arm64 the kernel always runs on the non-secure side, so we don't
> expect to have access to FIQ. It's possible to implement NMIs using
> priorities (which it looks like Daniel was looking into [3]).

Thanks Mark.

The blog post is still pretty much describes my ambitions and the 
benefits these features can bring. It also has a link to a fairly 
elderly kernel that contains all the features fully integrated.

There are more patchsets for both ARM (if/f FIQ is available) and ARM64 
(if/f device has GICv3). However these only provide NMI backtrace.

arm:   http://thread.gmane.org/gmane.linux.kernel/2112583

arm64: http://thread.gmane.org/gmane.linux.kernel/2037735 (Mark's
        link to my git repo is more up to date than this patchset)

To get the hard lockup and profiling support upstream then my old code 
to integrate NMIs into the irq subsystem (which was just a cut down 
clone of the existing irq infrastructure) needs to be redesigned. 
However I decided to put the rewrite on ice until I get the foundational 
patches right.


Daniel.
