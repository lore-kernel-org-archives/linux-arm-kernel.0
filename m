From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 14 Sep 2015 15:54:21 +0100
Subject: [PATCH v4 00/20] xen/arm64: Add support for 64KB page in Linux
In-Reply-To: <55F6D9DC.8060607@citrix.com>
References: <1441640038-23615-1-git-send-email-julien.grall@citrix.com>
 <55F68BC9.6020509@citrix.com> <55F6A437.3040403@citrix.com>
 <55F6A9DB.8040503@citrix.com> <55F6ADAE.1010609@citrix.com>
 <55F6B8CC.5090406@citrix.com> <55F6C1D2.7010206@citrix.com>
 <55F6D9DC.8060607@citrix.com>
Message-ID: <alpine.DEB.2.02.1509141542430.2672@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Sep 2015, Roger Pau Monn? wrote:
> IMHO this splitting is just a workaround for the fact that we don't have
> a 64KB PV block protocol, and this is the real problem that should be
> solved.

64K is a pure one guest kernel configuration option, not a platform wide
option. The hypervisor interfaces are still the same, the ABI is the
same and all the other guests are still the same, the Xen binary is
still the same.

A 64K block protocol could be a good performance imprevement, but should
not be required to run kernels which have different config options.


> In the long term this will put a burden on all blkfronts (if 64KB pages
> are also used by other OSes), while introducing a 64KB PV block protocol
> will make the blkfront implementation in all OSes very similar to what
> we have now, without replicating the splitting code amongst all the
> possible blkfront implementations.
> 
> Granted that some changes to blkback will be needed in order to support
> mapping 64KB grants, but there are much fewer blkback implementations
> out there than blkfronts.

I don't think we can rely on blkback having something in order to run
new guests, otherwise we break compatibility: new guests won't run on
old hypervisors.
