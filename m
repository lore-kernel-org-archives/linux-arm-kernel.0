From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Sep 2018 17:50:30 +0100
Subject: [PATCH] arm64: add NUMA emulation support
In-Reply-To: <86aad702-9f42-c572-a8f1-74983cd1bf33@kernel.org>
References: <20180829110802.GD10349@dhcp22.suse.cz>
 <f041ba95-03e6-4a7d-c324-870b45a2f648@kernel.org>
 <20180905064252.GW14951@dhcp22.suse.cz>
 <c1b58f13-6190-20e9-7e4f-b8bc2b9d5f80@kernel.org>
 <20180907083452.GC19621@dhcp22.suse.cz>
 <e46e715c-f115-f054-eeb2-3cecbcd1192d@kernel.org>
 <20180910134845.GH10951@dhcp22.suse.cz>
 <4d7beb50-f778-507a-4c3c-f6de92f8cfb9@kernel.org>
 <20180911091124.GP10951@dhcp22.suse.cz>
 <86aad702-9f42-c572-a8f1-74983cd1bf33@kernel.org>
Message-ID: <20180911165029.GA15022@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 09:27:49AM -0600, Shuah Khan wrote:
> On 09/11/2018 03:11 AM, Michal Hocko wrote:
> > On Mon 10-09-18 20:02:05, Shuah Khan wrote:
> >> Hi Michal,
> >>
> >> On 09/10/2018 07:48 AM, Michal Hocko wrote:
> >>> On Fri 07-09-18 16:30:59, Shuah Khan wrote:
> >>>> On 09/07/2018 02:34 AM, Michal Hocko wrote:
> >>>>> On Thu 06-09-18 15:53:34, Shuah Khan wrote:
> >> [....]
> >>>>
> >>>> In addition to isolation, being able to reserve a block instead is one of the
> >>>> issues I am looking to address. Unfortunately memory cgroups won't address that
> >>>> issue.
> >>>
> >>> Could you be more specific why you need reservations other than
> >>> isolation.
> >>>
> >>
> >> Taking automotive as a specific example, there are two classes of applications:
> >> 1. critical applications that must run
> >> 2. Infotainment and misc. user-space.
> >>
> >> In this case, being able to reserve a block of memory for critical applications
> >> will ensure the memory is available for them. If a critical application has to
> >> restart and/or when an on-demand critical application starts, it might not be able
> >> to allocate memory if it is not reserved.
> >>
> >> When a flat system has multiple memory blocks, with NUMA emulation in conjunction with
> >> cpusets, one or more block can be reserved for critical applications configuring a set
> >> of cpus and one of more memory nodes for them.
> >>
> >> Memory cgroups will not support such reservation. Hope this helps explain the use-case
> >> I am trying to address with this patch.
> > 
> > OK, that is more clear. I still believe that you either have to have a
> > very good control over memory allocations or a good luck to not see
> > unexpected kernel allocations in your reserved memory which might easily
> > break guarantees you would like to accomplish.
> > 
> 
> Thanks. Right. I am with you on the possibility that root cgroup can eat into
> the reserved memory. However, with this solution I proposed, there is a guarantee
> that the cpuset cgroup that is configured for non-critical Infotainment and misc.
> user-space application will not be able to allocate from the reserved memory node.
> 
> I am hoping the proposed patch will allow critical apps. reserving memory with the
> exception that root cgroup and kernel can still allocate from it when needed. Perhaps
> cpuset exclusive logic could be extended to look for non-exclusive memory nodes first
> if it doesn't already do that. This is inline with the current cpuset approach is that
> the critical kernel allocations aren't starved to ensure memory reservations.
> 
> If you don't think this solution isn't ideal/good, do you have other suggestions
> for solving the problem? If not would it be okay to start with what I proposed and
> build on top of as needed?

I still don't understand why this can't be achieved by faking up some NUMA
entries in the firmware table and just using the existing NUMA code that we
have.

Will
