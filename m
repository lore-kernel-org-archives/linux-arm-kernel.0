From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 29 Jan 2018 17:24:14 +0000
Subject: [PATCH 10/16] arm64: Make KPTI strict CPU local feature
In-Reply-To: <4bf35de5-ae61-93b8-f202-52d734997cc5@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-11-suzuki.poulose@arm.com>
 <20180126122519.GR5862@e103592.cambridge.arm.com>
 <4bf35de5-ae61-93b8-f202-52d734997cc5@arm.com>
Message-ID: <20180129172414.GC5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 26, 2018 at 03:46:59PM +0000, Suzuki K Poulose wrote:
> On 26/01/18 12:25, Dave Martin wrote:
> >On Tue, Jan 23, 2018 at 12:28:03PM +0000, Suzuki K Poulose wrote:
> >>KPTI capability is a security feature which should be enabled
> >>when at least one CPU on the system needs it. Any late CPU
> >>which needs the kernel support, should be prevented from
> >>booting (and thus making the system unsecure) if the feature
> >>was not already enabled.
> >
> >Is there an actual change to behaviour here?
> 
> Yes, we now prevent any new CPU from booting if it *matches* the capability,
> which we didn't do earlier.

Ok

> >
> >It's not very obvious from the commit message, or the patch when read in
> >isolation.
> >
> 
> I will fix the commit message to indicate the current behavior. How about :
> 
> "KPTI is treated as a system wide feature, where we enable the feature
> when all the CPUs on the system suffers from the security vulnerability,
> unless it is enabled via kernel command line. Also, we ignore a late CPU

Maybe "enabled" -> "forcibly enabled", if the command-line really is
supposed to have override semantics (which I guess it is).

> which might need the defense if the KPTI is not enabled, making the system
> insecure. This is not sufficient, as
> we should enable the defense when at least one CPU needs it. Also, if
> it is not enabled at boot-time, we can no longer enable it when a late
> CPU turns up. This patch makes sure that the KPTI is checked on all CPUs

There's some repetition here.  Does the following work:

"[...] command line.  Also, if a late CPU needs KPTI but KPTI was not
enabled at boot time, the CPU is currently allowed to boot, which is a
potential security vulnerability.  This patch ensures that late CPUs
are rejected as appropriate if they need KPTI but it wasn't enabled."

Hmmm.  That's no shorter after all.  Oh well :P

Cheers
---Dave
