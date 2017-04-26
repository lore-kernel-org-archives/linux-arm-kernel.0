From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Apr 2017 11:10:21 +0100
Subject: [PATCH v2] arm64: perf: Use only exclude_kernel attribute when
 kernel is running in HYP
In-Reply-To: <CY4PR07MB3415C0CEBB9D3DF0C249DC6793110@CY4PR07MB3415.namprd07.prod.outlook.com>
References: <1492623846-29335-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <20170420084928.GC31436@leverpostej>
 <CAFpQJXVSsg8CX28vEo2LzmOi3pknHiH233spMD6ip4LZO4vw=Q@mail.gmail.com>
 <20170424154530.GO12323@arm.com>
 <CAFpQJXWX=0GQ5hse4E_OSdnYhMOA7CvqeoHe9AdMsyoZJmrPQQ@mail.gmail.com>
 <20170425165259.GS24484@arm.com>
 <CA+7sy7D-ZB84xQ2pE-io1v7pmnAuWUszh1B=Zq+Ezup=sysQ2g@mail.gmail.com>
 <CY4PR07MB3415C0CEBB9D3DF0C249DC6793110@CY4PR07MB3415.namprd07.prod.outlook.com>
Message-ID: <20170426101021.GF21744@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 07:22:46AM +0000, Pinski, Andrew wrote:
> On 4/25/2017 11:53 PM, Jayachandran C. wrote:
> > On Tue, Apr 25, 2017 at 10:23 PM, Will Deacon <will.deacon@arm.com> wrote:
> >> On Tue, Apr 25, 2017 at 09:13:40AM +0530, Ganapatrao Kulkarni wrote:
> >>> On Mon, Apr 24, 2017 at 9:15 PM, Will Deacon <will.deacon@arm.com> wrote:
> >>>> On Thu, Apr 20, 2017 at 02:56:50PM +0530, Ganapatrao Kulkarni wrote:
> >>>>> OK, if you are ok with sysfs part, i can send next version with that
> >>>>> change only?.
> >>>> I think the sysfs part is still a little dodgy, since you still expose the
> >>>> "exclude_hv" file with a value of 0 when not running at EL2, which would
> >>>> imply that exclude_hv is forced to zero. I don't think that's correct.
> >>> okay, i can make exclude_hv visible only when kernel booted in EL2.
> >>> is it ok to have empty directory "attr" when kernel booted to EL1?
> >>> attr can be place holder for any other miscellaneous attributes, that
> >>> can be added in future.
> >> Sounds good to me, although I'll seek comment from the other perf folks
> >> before merging anything with ABI implications.
> > Do you really think this is the solution given:
> > - this is an arm64 specific sysfs interface that is tied to the perf API

That's why I want feedback from others. The intention would be that this can
be used by other PMUs as well, since it's not uncommon that parts of the
sizeable perf_event_attr structure are not used by a given PMU.

> > - the perf API documentation has to be updated for this

So? If having to update documentation means we shouldn't change the kernel,
then we may as well all find new jobs.

> > - All the applications that use the perf API have to be modified to
> > check this sysfs interface
> > - If the application fails to do so, a very narrow corner case
> > (exclude_hv != exclude_kernel and VHE enabled) fails.

See below, but apparently people care about it.

> > Any application that really cares can already do see if exclude_hv !=
> > exclude_kernel case works by calling perf_open_event() with those
> > options and checking the return value.

That's a good point: there is *something* userspace can do, although that
would be arm64-specific and doesn't really help with the state-space
explosion you get with combinations of invalid/unused perf_event_attr
fields.

> An example of an application which needs to changed is HHVM. Currently 
> it sets exclude_hv to true but exclude_kernel to false as it does not 
> care about the hypervisor associated perf events associated with the 
> code, only the kernel and userspace associated evnts.
> Yes we could submit a patch to use the sysfs interface to check but it 
> would look funny and the facebook folks might reject the patch as it is 
> ARM64 specific in generic code.  Note this is how all of this discussion 
> started was HHVM's call to perf_open_event was failing.

Hmm, if you're saying that HHVM won't be changed to use the sysfs stuff,
then why are we bothering?

Not sure where this leaves us.

Will
