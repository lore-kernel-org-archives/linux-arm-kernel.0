From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 00:53:53 +0100
Subject: [RFC/PATCH] ARM: smp: Fix cpu_up() racing with sys_reboot
In-Reply-To: <1345608229-5707-1-git-send-email-sboyd@codeaurora.org>
References: <1345608229-5707-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120829235353.GW18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 09:03:49PM -0700, Stephen Boyd wrote:
> Nothing stops a process from hotplugging in a CPU concurrently
> with a sys_reboot() call. In such a situation we could have
> ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
> fact that the CPU is not really offline and call the
> CPU_UP_PREPARE notifier. When this happens stop_machine code will
> complain that the cpu thread already exists and BUG_ON().

This puts us at odds with x86, which is a bad thing without first
investigating whether a generic solution which fixes all arches would
be more appropriate.

A better solution may be to mark those CPUs as being not-present,
which will prevent them being hot-plugged back.
