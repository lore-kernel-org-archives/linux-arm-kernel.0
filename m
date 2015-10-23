From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 23 Oct 2015 17:00:54 +0100
Subject: [PATCH] drivers: psci: make PSCI 1.0 functions initialization
 version dependent
In-Reply-To: <562A4B23.6020702@arm.com>
References: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
 <562A4B23.6020702@arm.com>
Message-ID: <20151023160054.GA13029@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 03:58:43PM +0100, Sudeep Holla wrote:

[...]

> >@@ -347,9 +347,10 @@ static int __init psci_probe(void)
> >
> >  	psci_init_migrate();
> >
> >-	psci_init_cpu_suspend();
> >-
> >-	psci_init_system_suspend();
> >+	if (PSCI_VERSION_MAJOR(ver) >= 1) {
> 
> Alternatively we can just add this check in psci_features function and
> return PSCI_RET_NOT_SUPPORTED if PSCI_VERSION_MAJOR(ver) < 1. New
> callers of psci_features are also protected and need not add checks
> at call sites. Thoughts ?

The resulting behaviour given the current code would be equivalent,
but I think you have a point, we can always refactor this code later
as a clean-up, I just prevented calling initialization functions
that have 0 chances to succeed on pre 1.0 firmware anyway (but do have
have a chance to fail as the breakage showed).

Thanks,
Lorenzo
