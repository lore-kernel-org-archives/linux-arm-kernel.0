From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 12 Mar 2015 09:18:54 -0400
Subject: [RFC PATCH 2/2] arm64: kernel: perf: add pmu CPU PM notifier
In-Reply-To: <7hh9try12u.fsf@deeprootsystems.com>
References: <1426008682-5680-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1426008682-5680-2-git-send-email-lorenzo.pieralisi@arm.com>
 <7hh9try12u.fsf@deeprootsystems.com>
Message-ID: <CAJ5Y-eZBS9Z0BgQK92MggttEZLitgKOYPyZqg3-7=RggYAJWvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2015 at 12:02, Kevin Hilman <khilman@kernel.org> wrote:
> Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
>
>> When a CPU is being profiled through PMU events and it enters suspend
>> or idle states, the PMU registers content can be lost, which means that
>> counters that were relied upon on power down entry are reset on power
>> up to values that are incosistent with the profile session.
>>
>> This patch adds a CPU PM notifier to arm64 perf code, that detects
>> on entry if events are being monitored, and if so, it returns
>> failure to the CPU PM notification chain, causing the suspend
>> thread or the idle thread to abort power down, therefore preventing
>> registers content loss.
>>
>> By triggering CPU PM notification failure this patch prevents
>> suspending a system if the suspend thread is being profiled and
>> it also prevents entering idle deep states on cores that have profile
>> events in use, somehow limiting power management capabilities when
>> there are active perf sessions.
>
> I guess that's one choice.  Couldn't you also stop the PMU and
> save/restore it's context in the notifiers? so that you wouldn't affect
> PM capabilities?
>
> That would imply that you lose the ability to profile after a certain
> point in suspend/idle, but maybe that's a better trade off than having
> profiling disable certain PM features?

I had something like that a few years ago on the Kraits and Scorpions [1].

[1] https://www.codeaurora.org/cgit/quic/la/kernel/msm/commit/arch/arm/kernel?h=msm-3.4&id=b5ca687960f0fea2f4735e83ca5c9543474c19de

Cheers,
Ashwin.
