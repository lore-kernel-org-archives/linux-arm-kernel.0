From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 27 Apr 2015 22:57:34 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <20150427200407.GG23335@cbox>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
Message-ID: <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 April 2015 at 21:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Thu, Apr 23, 2015 at 03:26:53PM +0100, Alex Benn?e wrote:
>>
>> Christoffer Dall <christoffer.dall@linaro.org> writes:
>>
>> > On Tue, Mar 31, 2015 at 04:08:04PM +0100, Alex Benn?e wrote:
>> >> + * just need to report the PC and the HSR values to userspace.
>> >> + * Userspace may decide to re-inject the exception and deliver it to
>> >> + * the guest if it wasn't for the host to deal with.
>> >
>> > now I'm confused - does userspace setup the guest to receive an
>> > exception or does it tell KVM to emulate an exception for the guest or
>> > do we execute the breakpoint without trapping the debug exception?
>>
>> I've made it all go through userspace as we may have to translate the
>> hypervisor visible exception code to what the guest was expecting to see.
>>
>
> ok, so I think you should re-phrase something like:
>
> "Userspace may decide that this exception is caused by the guest using
> debugging itself, and may in that case emulate the guest debug exception
> in userspace before resuming KVM."
>
> But does that really work?  Given that we don't support KVM-TCG
> migration, this sounds a little strange.  Did we test it?

The QEMU patches have a TODO note at the point where you'd want
to do this... Design-wise you can do the reinjection in the
kernel or in userspace (ppc QEMU does this in userspace, for
instance) because it's pretty much just setting registers to fake
up the exception-entry into EL1. Code-wise QEMU's ARM code isn't
set up to do it right now, but it shouldn't be too difficult to
persuade the TCG exception-entry code to work for this case too.

Does the kernel already have a conveniently implemented "inject
exception into guest" lump of code? If so it might be less effort
to do it that way round, maybe.

-- PMM
