From: will.deacon@arm.com (Will Deacon)
Date: Wed, 13 Jun 2018 11:35:56 +0100
Subject: [RFC V2 3/3] perf: qcom: Add Falkor CPU PMU IMPLEMENTATION
 DEFINED event support
In-Reply-To: <9957219b64252d3b2e19724db04a1179@codeaurora.org>
References: <1528379808-27970-1-git-send-email-agustinv@codeaurora.org>
 <1528379808-27970-4-git-send-email-agustinv@codeaurora.org>
 <20180612144055.m2h26n64spfm6k6o@lakrids.cambridge.arm.com>
 <9957219b64252d3b2e19724db04a1179@codeaurora.org>
Message-ID: <20180613103555.GC26280@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 04:41:32PM -0400, Agustin Vega-Frias wrote:
> Hi Mark,
> 
> On 2018-06-12 10:40, Mark Rutland wrote:
> >Hi,
> >
> >On Thu, Jun 07, 2018 at 09:56:48AM -0400, Agustin Vega-Frias wrote:
> >>Selection of these events can be envisioned as indexing them from
> >>a 3D matrix:
> >>- the first index selects a Region Event Selection Register
> >>(PMRESRx_EL0)
> >>- the second index selects a group from which only one event at a time
> >>  can be selected
> >>- the third index selects the event
> >>
> >>The event is encoded into perf_event_attr.config as 0xPRCCG, where:
> >>  P  [config:16   ] = prefix   (flag that indicates a matrix-based
> >>event)
> >>  R  [config:12-15] = register (specifies the PMRESRx_EL0 instance)
> >>  G  [config:0-3  ] = group    (specifies the event group)
> >>  CC [config:4-11 ] = code     (specifies the event)
> >>
> >>Events with the P flag set to zero are treated as common PMUv3 events
> >>and are directly programmed into PMXEVTYPERx_EL0.
> >>
> >>The first two indexes are set combining the RESR and group number with
> >>a base number and writing it into the architected PMXEVTYPER_EL0
> >>register.
> >>The third index is set by writing the code into the bits corresponding
> >>with the group into the appropriate IMPLEMENTATION DEFINED PMRESRx_EL0
> >>register.
> >
> >When are the IMP DEF registers accessible at EL0? Are those goverend by
> >the same controls as the architected registers?
> 
> No, there is a separate IMP DEF register to control access.

Great :( We need to make sure we disable EL0 access during boot then, but
that means we need to prove for the existence of this thing in head.S
(since the PMU driver might not get loaded).

Also, what's the kvm story here so that we don't accidentally open up a
VM-VM side-channel via these registers? How do the EL1 trapping controls
work?

Will
