From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 18:50:29 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <565DE289.2000105@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
 <20151201152826.GA28370@leverpostej> <565DC5DB.7070905@arm.com>
 <20151201163138.GA29045@leverpostej> <565DDB2E.2010308@arm.com>
 <20151201175254.GD29045@leverpostej> <565DE289.2000105@arm.com>
Message-ID: <20151201185028.GF29045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 06:10:17PM +0000, Suzuki K. Poulose wrote:
> On 01/12/15 17:52, Mark Rutland wrote:
> >On Tue, Dec 01, 2015 at 05:38:54PM +0000, Suzuki K. Poulose wrote:
> >>On 01/12/15 16:31, Mark Rutland wrote:
> >
> >[...]
> >
> >>>We need stuck-in-the-kernel flag to account for CPUs which didn't manage
> >>>to turn the MMU on (which are either in the spin-table, or failed when
> >>>they were individually onlined).
> >>
> >>Did you mean to say "turn the MMU off" ?
> >
> >No, I mean CPUs which were unable to turn the MMU on in the first place.
> >Perhaps they entered the spin-table but were never individually onlined,
> >perhaps they didn't support the kernel page size, etc.
> >
> >When CPUs exit the kernel via PSCI they never switch the MMU off within
> >the kernel.
> 
> OK. So the flag will also be used for CPUs which are stuck-in-the-kernel
> with MMU turned on. e.g, a CPU (using spin-table) we try to bring down
> in kill_cpu_early(). Correct ?

Yes.

We'd also pad it such that nothing else shares the same writeback
granule, and when writing to it with the MMU off we can invalidate the
stale cached copy.

Thanks,
Mark.
