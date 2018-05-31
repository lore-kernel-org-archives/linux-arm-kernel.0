From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 31 May 2018 17:00:33 +0100
Subject: [PATCH v2 2/6] arm64: KVM: Handle Set/Way CMOs as NOPs if FWB is
 present
In-Reply-To: <83a4edd3-abea-b6c4-9513-3705cc92b52b@arm.com>
References: <20180530124706.25284-1-marc.zyngier@arm.com>
 <20180530124706.25284-3-marc.zyngier@arm.com>
 <20180531115127.2ymmtlwemz6g5qzj@lakrids.cambridge.arm.com>
 <83a4edd3-abea-b6c4-9513-3705cc92b52b@arm.com>
Message-ID: <20180531160032.24xw2m7oquer6tgz@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 02:00:11PM +0100, Marc Zyngier wrote:
> On 31/05/18 12:51, Mark Rutland wrote:
> > On Wed, May 30, 2018 at 01:47:02PM +0100, Marc Zyngier wrote:
> >> Set/Way handling is one of the ugliest corners of KVM. We shouldn't
> >> have to handle that, but better safe than sorry.
> >>
> >> Thankfully, FWB fixes this for us by not requiering any maintenance
> >> whatsoever, which means we don't have to emulate S/W CMOs, and don't
> >> have to track VM ops either.
> >>
> >> We still have to trap S/W though, if only to prevent the guest from
> >> doing something bad.
> > 
> > S/W ops *also* do I-cache maintenance, so we'd still need to emulate
> > that. Though it looks like we're missing that today...
> 
> This doesn't look right: CSSELR_EL1 does indeed have an InD bit, but
> that's only for the purpose of reading CSSIDR_EL1. DC CSW and co
> directly take a level *without* the InD bit, and seem to be limited to
> "data and unified cache".
> 
> Am I missing something?

No; I was mistaken.

Sorry for the noise!

Mark.
