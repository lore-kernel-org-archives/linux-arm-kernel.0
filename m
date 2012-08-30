From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Aug 2012 12:00:06 -0700
Subject: [RFC/PATCH] ARM: smp: Fix cpu_up() racing with sys_reboot
In-Reply-To: <20120829235353.GW18957@n2100.arm.linux.org.uk>
References: <1345608229-5707-1-git-send-email-sboyd@codeaurora.org>
 <20120829235353.GW18957@n2100.arm.linux.org.uk>
Message-ID: <503FB836.2060000@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/29/2012 4:53 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 21, 2012 at 09:03:49PM -0700, Stephen Boyd wrote:
>> Nothing stops a process from hotplugging in a CPU concurrently
>> with a sys_reboot() call. In such a situation we could have
>> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
>> fact that the CPU is not really offline and call the
>> CPU_UP_PREPARE notifier. When this happens stop_machine code will
>> complain that the cpu thread already exists and BUG_ON().
> This puts us at odds with x86, which is a bad thing without first
> investigating whether a generic solution which fixes all arches would
> be more appropriate.

I went this way because it seems that we stop CPUs in architecture
specific code instead of doing it generically (although we have
smp_send_stop()?). It would be nice if we could generalize the cpu
stopping code so that reboot at the architectual level doesn't have to
do this.

>
> A better solution may be to mark those CPUs as being not-present,
> which will prevent them being hot-plugged back.

That sounds fine to me. I can s/active/present/ for v2 if we can get
some kind of consensus. I was also thinking we could stop using these
functions entirely and have some private stopped CPUs map that we check
instead.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
