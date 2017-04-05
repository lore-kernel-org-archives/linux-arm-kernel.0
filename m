From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Wed, 5 Apr 2017 15:18:17 +0530
Subject: [PATCH] arm64: perf: Count EL2 events if either of kernel and hyp
 are not excluded
In-Reply-To: <20170405083155.GA18287@arm.com>
References: <1491302455-5939-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170404111826.GD14898@arm.com>
 <CAFpQJXW_2=8Jwqrt4k6Em6B=TBh_XA2x23OTMbpzkwKZV2x4jA@mail.gmail.com>
 <20170404122632.GF14898@arm.com>
 <CAFpQJXWwRFTPP6BixZAfJ_cRrGqrHEbOas_X+T_R+mDH7u0Aew@mail.gmail.com>
 <20170405083155.GA18287@arm.com>
Message-ID: <CAFpQJXXi8BZAjooUtk9F1Xgzns6EBFOCB9AS8yVm3hGv5Ah93Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Adding maintainers]

On Wed, Apr 5, 2017 at 2:01 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Apr 05, 2017 at 09:29:32AM +0530, Ganapatrao Kulkarni wrote:
>> On Tue, Apr 4, 2017 at 5:56 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Apr 04, 2017 at 05:37:10PM +0530, Ganapatrao Kulkarni wrote:
>> >> On Tue, Apr 4, 2017 at 4:48 PM, Will Deacon <will.deacon@arm.com> wrote:
>> >> > On Tue, Apr 04, 2017 at 04:10:55PM +0530, Ganapatrao Kulkarni wrote:
>> >> >> commit d98ecda (arm64: perf: Count EL2 events if the kernel is running in HYP)
>> >> >> is returning error for perf syscall with mixed attribute set for exclude_kernel
>> >> >> and exlude_hv.
>> >> >>
>> >> >> This change is breaking some applications (observed with hhvm) when
>> >> >> ran with VHE enabled. Adding change to enable EL2 event counting,
>> >> >> if either of or both of exclude_kernel and exlude_hv are not set.
>> >> >>
>> >> >> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
>> >> >> ---
>> >> >>  arch/arm64/kernel/perf_event.c | 19 ++++++++++++-------
>> >> >>  1 file changed, 12 insertions(+), 7 deletions(-)
>> >> >
>> >> > Hmm. When we have VHE, we can't distinguish between hypervisor and kernel,
>> >> > so this patch doesn't seem right to me. The code currently requires
>> >> > both exclude_kernel and exclude_hv to be clear before we enable profiling
>> >> > EL2, otherwise we're failing to exclude samples that were asked to be
>> >> > excluded.
>> >>
>> >> The application cant differentiate that kernel is running in EL2/VHE or in EL1
>> >> when VHE=1, is it makes sense to enable EL2 event counting when there
>> >> is request from application to either include kernel or hypervisor
>> >> event count, since both are same.
>> >
>> > You can make exactly the same argument against your proposal by saying that
>> > it makes sense to disable EL2 event counting when there is a request from
>> > an application to either exclude kernel or hypervisor event counting.
>>
>> yes, the argument is equally valid on either side.
>>
>> >
>> >> IMO, it is not appropriate to have different application behaviour
>> >> when kernel booted with VHE=0/1
>> >
>> > Then find another solution to that. How about a mechanism to advertise
>> > that exclude_hv is effectively always set if the kernel is running at EL2?
>>
>> I am not sure, how we can advertise to user that kernel is running at EL2.
>> we may add a note to man page of perf_event_open?
>> "exclude_hv is always set, if host kernel and hypervisor are running
>> at same privilege level",
>
> I was thinking of putting something into sysfs, alongside the other things
> we have in there. For example, a file that describes whether any of the
> perf_event_attr behave as though they are fixed to a certain value. We
> should involve the perf maintainers (and perf tool developers) in this,
> but perhaps something like an attr directory, where we could have a file
> called exclude_hv that contains the value 1.
>
> Will
