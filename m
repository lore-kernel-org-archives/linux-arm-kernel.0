From: andrew.murray@arm.com (Andrew Murray)
Date: Tue, 20 Nov 2018 13:32:02 +0000
Subject: [PATCH 10/10] perf/doc: update design.txt for
 exclude_{host|guest} flags
In-Reply-To: <87pnv00yuf.fsf@concordia.ellerman.id.au>
References: <1542363853-13849-1-git-send-email-andrew.murray@arm.com>
 <1542363853-13849-11-git-send-email-andrew.murray@arm.com>
 <87pnv00yuf.fsf@concordia.ellerman.id.au>
Message-ID: <20181120133202.GH35798@e119886-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2018 at 10:31:36PM +1100, Michael Ellerman wrote:
> Andrew Murray <andrew.murray@arm.com> writes:
> 
> > Update design.txt to reflect the presence of the exclude_host
> > and exclude_guest perf flags.
> >
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> > ---
> >  tools/perf/design.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/perf/design.txt b/tools/perf/design.txt
> > index a28dca2..7de7d83 100644
> > --- a/tools/perf/design.txt
> > +++ b/tools/perf/design.txt
> > @@ -222,6 +222,10 @@ The 'exclude_user', 'exclude_kernel' and 'exclude_hv' bits provide a
> >  way to request that counting of events be restricted to times when the
> >  CPU is in user, kernel and/or hypervisor mode.
> >  
> > +Furthermore the 'exclude_host' and 'exclude_guest' bits provide a way
> > +to request counting of events restricted to guest and host contexts when
> > +using virtualisation.
> 
> How does exclude_host differ from exclude_hv ?

I believe exclude_host / exclude_guest are intented to distinguish
between host and guest in the hosted hypervisor context (KVM).
Whereas exclude_hv allows to distinguish between guest and
hypervisor in the bare-metal type hypervisors.

In the case of arm64 - if VHE extensions are present then the host
kernel will run at a higher privilege to the guest kernel, in which
case there is no distinction between hypervisor and host so we ignore
exclude_hv. But where VHE extensions are not present then the host
kernel runs at the same privilege level as the guest and we use a
higher privilege level to switch between them - in this case we can
use exclude_hv to discount that hypervisor role of switching between
guests.

Thanks,

Andrew Murray

> 
> cheers
