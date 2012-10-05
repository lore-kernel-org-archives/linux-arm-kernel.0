From: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 05 Oct 2012 15:58:56 +0930
Subject: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <000301cda230$91eb4fa0$b5c1eee0$@samsung.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
 <50625DB2.4000700@virtualopensystems.com>
 <20120927141314.GK25916@mudshark.cambridge.arm.com>
 <CANM98qKidvG_sOHM197F+1EDtEFTGnLksCJo=12T36JE3u6R4w@mail.gmail.com>
 <000301cda230$91eb4fa0$b5c1eee0$@samsung.com>
Message-ID: <87obkhzb2v.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Min-gyu Kim <mingyu84.kim@samsung.com> writes:
>> -----Original Message-----
>> From: kvm-owner at vger.kernel.org [mailto:kvm-owner at vger.kernel.org] On
>> Behalf Of Christoffer Dall
>> Sent: Monday, October 01, 2012 4:22 AM
>> To: Will Deacon
>> Cc: kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
>> kvmarm at lists.cs.columbia.edu; rusty.russell at linaro.org; avi at redhat.com;
>> marc.zyngier at arm.com
>> Subject: Re: [PATCH 06/15] KVM: ARM: Initial skeleton to compile KVM
>> support
>> 
>> On Thu, Sep 27, 2012 at 10:13 AM, Will Deacon <will.deacon@arm.com> wrote:
>> > On Wed, Sep 26, 2012 at 02:43:14AM +0100, Christoffer Dall wrote:
>> >> >> +static inline enum vcpu_mode vcpu_mode(struct kvm_vcpu *vcpu) {
>> >> >> +       u8 mode = __vcpu_mode(vcpu->arch.regs.cpsr);
>> >> >> +       BUG_ON(mode == 0xf);
>> >> >> +       return mode;
>> >> >> +}
>> >> >
>> >> > I noticed that you have a fair few BUG_ONs throughout the series.
>> >> > Fair enough, but for hyp code is that really the right thing to do?
>> >> > Killing the guest could make more sense, perhaps?
>> >>
>> >> the idea is to have BUG_ONs that are indeed BUG_ONs that we want to
>> >> catch explicitly on the host. We have had a pass over the code to
>> >> change all the BUG_ONs that can be provoked by the guest and inject
>> >> the proper exceptions into the guest in this case. If you find places
>> >> where this is not the case, it should be changed, and do let me know.
>> >
>> > Ok, so are you saying that a BUG_ON due to some detected inconsistency
>> > with one guest may not necessarily terminate the other guests? BUG_ONs
>> > in the host seem like a bad idea if the host is able to continue with
>> > a subset of guests.
>> >
>> 
>> No, I'm saying a BUG_ON is an actual BUG, it should not happen and there
>> should be nowhere where a guest can cause a BUG_ON to occur in the host,
>> because that would be a bug.
>> 
>> We basically never kill a guest unless really extreme things happen (like
>> we cannot allocate a pte, in which case we return -ENOMEM). If a guest
>> does something really weird, that guest will receive the appropriate
>> exception (undefined, prefetch abort, ...)
>> 
>
> I agree with Will. It seems to be overreacting to kill the entire system.

No.  If we manage to put the guest in an undefined state, we don't know
what has happened.  Something has gone horribly wrong.  Most likely,
vcpu isn't a vcpu pointer at all, or has been so horribly corrupted that
"killing the guest" is just a complicated way of messing ourselves up
further.

The system by this stage is so damaged that we're best off panicing, and
avoiding corrupting things further.

Cheers,
Rusty.
