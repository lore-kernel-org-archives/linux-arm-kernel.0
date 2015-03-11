From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 11 Mar 2015 09:02:17 -0700
Subject: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
In-Reply-To: <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Tue, 10 Mar 2015 17:31:22 +0000")
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <7hh9try12u.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> When a CPU is being profiled through PMU events and it enters suspend
> or idle states, the PMU registers content can be lost, which means that
> counters that were relied upon on power down entry are reset on power
> up to values that are incosistent with the profile session.
>
> This patch adds a CPU PM notifier to arm64 perf code, that detects
> on entry if events are being monitored, and if so, it returns
> failure to the CPU PM notification chain, causing the suspend
> thread or the idle thread to abort power down, therefore preventing
> registers content loss.
>
> By triggering CPU PM notification failure this patch prevents
> suspending a system if the suspend thread is being profiled and
> it also prevents entering idle deep states on cores that have profile
> events in use, somehow limiting power management capabilities when
> there are active perf sessions.

I guess that's one choice.  Couldn't you also stop the PMU and
save/restore it's context in the notifiers? so that you wouldn't affect
PM capabilities?

That would imply that you lose the ability to profile after a certain
point in suspend/idle, but maybe that's a better trade off than having
profiling disable certain PM features?

Kevin
