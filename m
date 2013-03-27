From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 18:03:45 +0000
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <51533037.5060004@gmail.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1303271642340.4430@kaball.uk.xensource.com>
 <51533037.5060004@gmail.com>
Message-ID: <201303271803.45420.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Rob Herring wrote:
> No, I was thinking in the case of Xen and mach-virt, you would not set
> mdesc->smp. So you would have something like this:
> 
> if (mdesc->smp)
>         smp_set_ops(mdesc->smp);
> else
>         smp_set_ops(&psci_smp_ops);

The case that Stefano is interested in if obviously other platforms
that can either run as Dom0 under Xen with psci_smp_ops or natively
with their own smp_ops. A similar case would be a platform that
may implement psci using smc when run in secure mode but provide
its own smp_ops when run natively.

In both cases, it would be simpler to use psci if available but
fall back to mdesc->smp otherwise.

	Arnd
