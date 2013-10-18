From: anup@brainfault.org (Anup Patel)
Date: Fri, 18 Oct 2013 09:48:43 +0530
Subject: [RFC PATCH 2/5] ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and
 SYSTEM_RESET to user space
In-Reply-To: <20131017183453.GO24837@cbox>
References: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
 <1381942954-22388-3-git-send-email-anup.patel@linaro.org>
 <525FA1D3.8060001@arm.com>
 <CAFEAcA-xqobnEmHnda5Psr4XH+3vAUr3K9Cnv_uhB7itBbNgfw@mail.gmail.com>
 <525FAC07.4060306@arm.com> <20131017183453.GO24837@cbox>
Message-ID: <CAAhSdy1RW20fHsLgtYYx+Kp5jHEsffFbpLjV=xzQsE7q7vtZdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:04 AM, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Thu, Oct 17, 2013 at 10:21:11AM +0100, Marc Zyngier wrote:
>> On 17/10/13 10:10, Peter Maydell wrote:
>> > On 17 October 2013 09:37, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> >> On 16/10/13 18:02, Anup Patel wrote:
>> >>> The PSCI SYSTEM_OFF and SYSTEM_RESET functions are VM or Guest level
>> >>> functions hence cannot be emulated by the in-kernel PSCI emulation code.
>> >>
>> >> Why can't we implement system-wide functionality in the kernel? I fail
>> >> to see the issue here.
>> >
>> > Because the kernel isn't emulating the whole board, and you need
>> > to power off or reset the whole board, not just the CPUs.
>>
>> In which case we can forward a generic event, once KVM has dealt with
>> the CPUs.
>>
>> >> I'm really not keen on this approach. Having part of the PSCI
>> >> implementation offloaded to userspace means we don't have a complete
>> >> implementation in KVM anymore, and we end-up duplicating functionality
>> >> all over the place.
>> >>
>> >> Also, OFF and RESET are not PSCI specific concepts, and could be
>> >> implemented in various ways. I'm more inclined to return a
>> >> *standardized* exit code that the various platforms can interpret.
>> >
>> > Maybe we should have a more generic "kernel can't handle this,
>> > toss it to userspace" API? That might also fit in with supporting
>> > guests that want to make SMC calls to an emulated monitor...
>>
>> Indeed.
>>
> Agreed as well.  That's what I was trying to say with a more generic
> solution, and exiting on a subset of SMC/HVC calls for PSCI is a weird
> compromise.

OK.

>
> After all, PSCI is nothing more than acting on SMC or HVC calls, and I'm
> quite sure there will be a need for user space to emulate handling of
> SMC calls sooner or later, and that is the interface we need.
>
> We may end up with both kernel and user space support for PSCI in that
> case, but naturally it would always be *either* the kernel handling the
> whole thing, *or* user space handling the whole thing.
>
> In both cases we may need extra functionality to communicate between
> user space and KVM, such as suspending a vcpu from user space and waking
> it up on in-kernel generated timer interrupts, or, conversely, telling
> user space that there was a PSCI call to turn off the system.

Agreed. Lets keep "user space emulation of PSCI for SMC/HVC" out of
discussions because we can implement PSCI SYSTEM_OFF and
SYSTEM_RESET without that.

>
> >From my point of view the most difficult part to figure out is how to
> support general handling of secure monitor services in user space.  I
> don't see any particular problems with expanding the exit reasons with
> things like "turn off VM" or "reset VM"?

Fine with me.

I'll keep separate exit reasons for HVC-based SYSTEM_OFF and
SYSTEM_RESET.

If everyone agrees with this then I'll change it accordingly in revised patch.

(Marc? Christoffer? PMM? ...)

--
Anup

>
> -Christoffer
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
