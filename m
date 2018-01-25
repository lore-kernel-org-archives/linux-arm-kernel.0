From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 25 Jan 2018 17:38:17 +0000
Subject: [PATCH 04/16] arm64: capabilities: Prepare for fine grained
 capabilities
In-Reply-To: <728779ba-2a91-a391-4c34-46923882dc7d@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
 <20180123122809.16269-5-suzuki.poulose@arm.com>
 <20180123173346.GB5862@e103592.cambridge.arm.com>
 <9a9e5aeb-dfc7-9602-c00e-80ea32d66c15@arm.com>
 <20180125134301.GH5862@e103592.cambridge.arm.com>
 <728779ba-2a91-a391-4c34-46923882dc7d@arm.com>
Message-ID: <20180125173816.GK5862@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 05:08:58PM +0000, Suzuki K Poulose wrote:
> On 25/01/18 13:43, Dave Martin wrote:

[...]

> >>2) WHEN: When is the capability "enabled" or in other words, when does the
> >>kernel start using the capability. At the moment there is only
> >>one place. After all the CPUs are brought up during the kernel init, from
> >>setup_cpu_features. (But this will change when we add support for enabling
> >>some capabilities very early during the boot, based on the boot CPU. e.g, VHE
> >>and GIC CPUIF - for NMI).
> >>
> >>For now, unless you see "EARLY", in the type, everything is enabled from
> >>setup_cpu_features.
> >
> >Agreed -- I'd forgotten about this.  To what extent is this orthogonal
> >to 1/3/4?
> 
> Apologies for not posting the work here, it was delayed due to some
> issues with how we handle VHE. I will include it in the next version.
> 
> The Early capabilities are based on Boot CPU, and is "detected" only on boot
> CPU. So, scope implies SCOPE_CPU_LOCAL. As for (2), the capability is enabled
> on the boot CPU right after it is detected, to allow early usage of the feature.
> For any other CPU (including the boot time activated ones) we make sure that
> they are verified against "early" capabilities.
> 
> To make the rule a bit generic, any CPU is verified against the already
> "enabled" capabilities. There are two stages during the boot when the capabilities
> are enabled.
>  1) Early caps: Detected and Enabled on the boot CPU, before any other CPU is
>     brought up.
>  2) All the other caps: Could be detected on CPU / System wide. But enabled
>     only after all the boot time active CPUs are up.
> 
> So, in any context, "LATE" tag now implies "after the particular capability"
> is enabled by the kernel.
> 
> ---------------------------------------------------------------
> Verification:  | Boot CPU | SMP CPUs by kernel | CPUs by user |
> ---------------------------------------------------------------
> Early cap      |   n      |      y             |       y      |
> ---------------------------------------------------------------
> All other cap  |   n      |      n             |       y      |
> ---------------------------------------------------------------
> 
> The above table kind of  shows how the capabilities are checked for conflicts.
> Any early capability is treated as critical and a conflict will result in a
> Panic, unless the non-compatible CPU is parked safely. (e.g, for VHE we park
> the late CPU with MMU off).

OK, this makes sense to me now -- thanks.

[...]

> >>4) CONFLICT: How should we treat a conflict of a capability on a CPU which
> >>boots after the capability was enabled in the kernel (as per 2, it could
> >>be earlier or after smp CPUs are brought up) ?
> >>
> >>Here are the possible combinations, representing a Conflict:
> >>
> >>	System		| Late Booting CPU
> >>a)	   y		|   n
> >>b) 	   n		|   y
> >>
> >>(a) Is considered safe for features like Erratum and KPTI where some
> >>actions have to be taken to make the system behave in desirable manner.
> >>However (a) is not considered safe for some features we advertise to the
> >>user (e.g, ELF HWCAP)
> >>
> >>(b) Is considered safe for most of the features (except KPTI and Software
> >>prefetching), while it is unsafe for Errata, as we couldn't possibly take
> >>any action as the time for applying the actions (enabling as per (2) above)
> >>has passed already.
> >>
> >>
> >>So we have the following cases :
> >>  i)   a_Safe && b_not_Safe
> >>  ii)  a_not_Safe && b_Safe
> >>  iii) a_Safe && b_Safe
> >
> >Is this the same as saying that the CONFLICT type (iii) is not
> >applicable to capabilites that are not decided globally?
> 
> Practically, yes. But we don't want to label it as such, as we don't know
> what future features could come with.

[...]

> The types are just a name for collective flags and sometimes there may be
> same bits in different names. This is for making it easier to add new
> entries to the table with the right bits set.

Fair enough.

[...]

Cheers
---Dave
