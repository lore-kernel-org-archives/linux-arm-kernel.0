From: cdall@linaro.org (Christoffer Dall)
Date: Wed, 26 Apr 2017 15:00:20 +0200
Subject: [PATCH v5 02/22] KVM: arm/arm64: Add GICV3 pending table save
 API documentation
In-Reply-To: <4dc866a0-582c-af69-916f-eb435988b5ec@redhat.com>
References: <1492164934-988-1-git-send-email-eric.auger@redhat.com>
 <1492164934-988-3-git-send-email-eric.auger@redhat.com>
 <CAFEAcA_0N9Jx5ym+=jjmxAzSaXPjt-m+gW1cq90of8Qhw3LOzg@mail.gmail.com>
 <a5ab9181-8398-f62b-12f1-032961b12c28@redhat.com>
 <CAFEAcA-u-sH+v-Pnr_3gRC3iSJP0ZK68+GqkDzmi3xe1-B2WAQ@mail.gmail.com>
 <20170426084830.GB2098@work-vm>
 <4dc866a0-582c-af69-916f-eb435988b5ec@redhat.com>
Message-ID: <20170426130020.GM4104@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 11:57:16AM +0200, Auger Eric wrote:
> Hi Peter, Dave,
> 
> On 26/04/2017 10:48, Dr. David Alan Gilbert wrote:
> > * Peter Maydell (peter.maydell at linaro.org) wrote:
> >> On 26 April 2017 at 09:26, Auger Eric <eric.auger@redhat.com> wrote:
> >>> On 25/04/2017 12:43, Peter Maydell wrote:
> >>>> When does the -EFAULT return happen? (if the guest points GITS_BASER<n>
> >>>> etc at invalid memory, presumably?)
> >>>
> >>> Yes that's correct, when GICR_PENDBASER contains a bad GPA.
> >>>
> >>>>  How does the QEMU migration code
> >>>> handle this case? Failing migration because the guest has done something
> >>>> silly doesn't seem too palatable, but trying to avoid that could be
> >>>> more effort than an obscure corner case really merits.
> >>>
> >>> The kvm_device_access will cause an abort() as for other errors returned
> >>> by kvm_device_ioctl().
> >>
> >> That's pretty nasty. Guests shouldn't be able to provoke QEMU
> >> into abort()ing, ideally. We don't necessarily have to produce
> >> a successful migration, but we should at least fail it cleanly.
> > 
> > Yes, no abort()'s during migration due to guest behaviour.
> > They always end up coming back around to being filed as migration
> > bugs and people worry why they've got cores.
> > 
> > Ideally log a message into stderr to say that the guest state
> > is inconsistent so that when someone comes to debug it then they
> > can see it's obvious.
> 
> OK I agree. I will respin the QEMU part accordingly and in that
> situation I won't abort and will print a message.
> 
Alternatively we should mark a pending error notification to the guest
in KVM, so that when the guest boots it gets something like an SError
instead, given that presumably the guest wrote the weird value.  Except
of course if the problem is caused by QEMU fudging with the register
value for the PENDBASER.

Just a thought.

Thanks,
-Christoffer
