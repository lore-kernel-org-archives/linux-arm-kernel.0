From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Jun 2015 00:05:39 +0100
Subject: [RFC 3/4] arm64: Do not call enable PCI resources when specify
 PCI_PROBE_ONLY
In-Reply-To: <1435098868.3996.11.camel@kernel.crashing.org>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1411937610-22125-4-git-send-email-suravee.suthikulpanit@amd.com>
 <CAErSpo6SngcV6_Ew0DOjW+xTw8y6j3UmwdPw1x-tk_AB=mapaQ@mail.gmail.com>
 <1435098868.3996.11.camel@kernel.crashing.org>
Message-ID: <20150623230539.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 08:34:28AM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2014-09-29 at 12:17 -0600, Bjorn Helgaas wrote:
> > This seems like more than necessary, but I don't know all the history.
> > In particular, I don't know why PCI_PROBE_ONLY should make a
> > difference to things like claiming resources.
> 
> It shouldn't ... we created that option on ppc originally to avoid
> allocation/reallocation of resources. If they are bad, leave them bad,
> but it was never a question of disabling all these other things.
> 
> (Ok, the MRSS/MPS is debatable, but why not plumb the parent pointers
> and why not claim ? That doesn't make sense to me).

You could look back over the history of arch/arm/kernel/bios32.c and
see that it was introduced by Will Deacon when he stripped out the
ARM version in favour of the generic version, and was found to be
necessary then.

I think the question has to be asked (based upon what Ben's saying)
and what's identified in these commits as a failure case
(pci_enable_resource failing when PCI_PROBE_ONLY is enabled) -
why is the PCI core creating per-device resources which do not have
parents.

I've no idea on that; the only ARM boxes I have use the kernel's PCI
allocation, I don't have these boxes which want to use PCI_PROBE_ONLY
so it's something I have zero knowledge of.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
