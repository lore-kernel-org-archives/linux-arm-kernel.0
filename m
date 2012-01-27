From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 27 Jan 2012 09:54:19 +0100
Subject: [linux-pm] [PATCH 0/3] coupled cpuidle state support
In-Reply-To: <CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
 <4F1929E9.7070707@linaro.org>
 <CAMbhsRTbVqV6p0py9NGZrpFPf2yvp-B0dr+o-m7qbdja_-Lfzw@mail.gmail.com>
Message-ID: <CAKfTPtAsO8z_8AnR8zSGZ9cm_7orDNxB3r09JAFk+2jdezUVmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 January 2012 21:40, Colin Cross <ccross@android.com> wrote:
> On Fri, Jan 20, 2012 at 12:46 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> Hi Colin,
>>
>> this patchset could be interesting to resolve in a generic way the cpu
>> dependencies.
>> What is the status of this patchset ?
>
> I can't do much with it right now, because I don't have any devices
> that can do SMP idle with a v3.2 kernel. ?I've started working on an
> updated version that avoids the spinlock, but it might be a while
> before I can test and post it. ?I'm mostly looking for feedback on the
> approach taken in this patch, and whether it will be useful for other
> SoCs besides Tegra and OMAP4.
>

Hi Colin,

In your patch, you put in safe state (WFI for most of platform) the
cpus that become idle and these cpus are woken up each time a new cpu
of the cluster becomes idle. Then, the cluster state is chosen and the
cpus enter the selected C-state. On ux500, we are using another
behavior for synchronizing  the cpus. The cpus are prepared to enter
the c-state that has been chosen by the governor and the last cpu,
that enters idle, chooses the final cluster state (according to cpus'
C-state). The main advantage of this solution is that you don't need
to wake other cpus to enter the C-state of a cluster. This can be
quite worth full when tasks mainly run on one cpu. Have you also think
about such behavior when developing the coupled cpuidle driver ? It
could be interesting to add such behavior.

Regards,
Vincent

>> Did you have the opportunity to measure the power consumption with and
>> without this patchset ?
>
> Power consumption will be very dependent on the specific SoC in
> question. ?The most important factors are the power savings of the
> independent cpuidle state (normally WFI) vs. the hotplug state
> (normally 1 cpu in OFF), and the workload being tested.
>
> On a very idle system, these patches result in the same total power as
> hotplugging one cpu and letting the other idle normally. ?On a 25%
> busy system, you might see a slight increase in power, as the best
> independent cpuidle state might be WFI, vs 1 cpu in OFF mode in
> hotplug. ?On OMAP4, that difference is small, on the order of 10 mW.
> Once you hit the threshold where a hotplug governor would have
> hotplugged in the second cpu (lets say 40%), the savings from these
> patches are enormous, as you can hit the lowest power state up to 60%
> of the time, where the hotplug solution would never be going below WFI
> on both cpus. ?On OMAP4, that can be well over 100 mW.
> _______________________________________________
> linux-pm mailing list
> linux-pm at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-pm
