From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Feb 2016 11:29:32 +0000
Subject: [PATCH V2] AHCI: Workaround for ThunderX Errata#22536
In-Reply-To: <56C3AD1C.2000003@caviumnetworks.com>
References: <1455319230-30201-1-git-send-email-tchalamarla@caviumnetworks.com>
 <20160214170152.GC3965@htj.duckdns.org>
 <56C147B2.9010303@caviumnetworks.com>
 <20160215183041.GH3965@htj.duckdns.org>
 <20160216144250.GD31343@rric.localdomain>
 <56C37524.5090000@caviumnetworks.com>
 <56C37AD3.4030407@caviumnetworks.com>
 <56C37D94.8080403@caviumnetworks.com>
 <20160216211410.GI25086@rric.localdomain>
 <56C3AD1C.2000003@caviumnetworks.com>
Message-ID: <20160217112931.GB31970@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 03:13:32PM -0800, Tirumalesh Chalamarla wrote:
> On 02/16/2016 01:14 PM, Robert Richter wrote:
> >CONFIG_CAVIUM_ERRATUM_22536 is exactly that you need. It is not only
> >used for core interrupts, e.g. also for gicv3 devices (and now also
> >for ahci). Non-core errata (e.g. CONFIG_CAVIUM_ERRATUM_23144) are not
> >enabled in the arm64 cpu errata framework (not handled in
> >arch/arm64/kernel/cpu_errata.c).
> >
> >Thus,
> >
> >#ifdef CONFIG_CAVIUM_ERRATUM_22536
> >	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
> >		ahci_thunderx_init(&pdev->dev, hpriv);
> >#endif
> >
> >is the correct enablement of the workaround by device id.
> >
> >And, CAVIUM_ERRATUM_* is very easy to handle, enable and document.
> >
> The code will only run for Thunder and AHCI, becuase its PCI.

Well, the guards also serve as documentation for exactly why we're having
to do something special here, so I'd say go ahead and add
CONFIG_CAVIUM_ERRATUM_22536 and update
Documentation/arm64/silicon-errata.txt accordingly.



Will
