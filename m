From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 13 Nov 2014 12:20:56 +0100
Subject: [RFC PATCH 1/4] ARM: KVM: on unhandled IO mem abort, route the
 call to the KVM MMIO bus
In-Reply-To: <20141113112012.GO19598@cbox>
References: <1394726249-1547-1-git-send-email-a.motakis@virtualopensystems.com>
 <1394726249-1547-2-git-send-email-a.motakis@virtualopensystems.com>
 <20140328190913.GJ25519@cbox>
 <CADDJ2=Opx2d5ex0hWSXYJjs6uLifR9wZVsahUHzZ7zytSj7ZSg@mail.gmail.com>
 <20141110162736.GA16054@cbox>
 <CADDJ2=PTM0fJ0RFfWdVQ1-471xqaJmj0vP1f5-pf57xOV5jgig@mail.gmail.com>
 <20141113112012.GO19598@cbox>
Message-ID: <CAMJs5B-Fkw0tX0NekeRW3UEg-cpuCiZyDAagRXW-Xynxg=P+VA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[resending to Andre's actual e-mail address]

On Thu, Nov 13, 2014 at 12:20 PM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Nov 13, 2014 at 12:45:42PM +0200, Nikolay Nikolaev wrote:
>
> [...]
>
>> >>
>> >> Going through the vgic_handle_mmio we see that it will require large
>> >> refactoring:
>> >>  - there are 15 MMIO ranges for the vgic now - each should be
>> >> registered as a separate device
>> >>  - the handler of each range should be split into read and write
>> >>  - all handlers take 'struct kvm_exit_mmio', and pass it to
>> >> 'vgic_reg_access', 'mmio_data_read' and 'mmio_data_read'
>> >>
>> >> To sum up - if we do this refactoring of vgic's MMIO handling +
>> >> kvm_io_bus_ API getting 'vcpu" argument we'll get a 'much' cleaner
>> >> vgic code and as a bonus we'll get 'ioeventfd' capabilities.
>> >>
>> >> We have 3 questions:
>> >>  - is the kvm_io_bus_ getting 'vcpu' argument acceptable for the other
>> >> architectures too?
>> >>  - is this huge vgic MMIO handling redesign acceptable/desired (it
>> >> touches a lot of code)?
>> >>  - is there a way that ioeventfd is accepted leaving vgic.c in it's
>> >> current state?
>> >>
>> > Not sure how the latter question is relevant to this, but check with
>> > Andre who recently looked at this as well and decided that for GICv3 the
>> > only sane thing was to remove that comment for the gic.
>> @Andre - what's your experience with the GICv3 and MMIO handling,
>> anything specific?
>> >
>> > I don't recall the details of what you were trying to accomplish here
>> > (it's been 8 months or so) but the surely the vgic handling code should
>> > *somehow* be integrated into the handle_kernel_mmio (like Paolo
>> > suggested), unless you come back and tell me that that would involve a
>> > complete rewrite of the vgic code.
>> I'm experimenting now - it's not exactly rewrite of whole vgic code,
>> but it will touch a lot of it  - all MMIO access handlers and the
>> supporting functions.
>> We're ready to spend the effort. My question is  - is this acceptable?
>>
> I certainly appreciate the offer to do this work, but it's hard to say
> at this point if it is worth it.
>
> What I was trying to say above is that Andre looked at this, and came to
> the conclusion that it is not worth it.
>
> Marc, what are your thoughts?
>
> -Christoffer
