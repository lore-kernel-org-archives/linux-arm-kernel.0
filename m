From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Tue, 28 Apr 2015 09:42:38 +0100
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-7-git-send-email-alex.bennee@linaro.org>
 <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
 <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
Message-ID: <87wq0wr6dd.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 April 2015 at 21:04, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>> On Thu, Apr 23, 2015 at 03:26:53PM +0100, Alex Benn?e wrote:
>>>
>>> Christoffer Dall <christoffer.dall@linaro.org> writes:
>>>
>>> > On Tue, Mar 31, 2015 at 04:08:04PM +0100, Alex Benn?e wrote:
>>> >> + * just need to report the PC and the HSR values to userspace.
>>> >> + * Userspace may decide to re-inject the exception and deliver it to
>>> >> + * the guest if it wasn't for the host to deal with.
>>> >
>>> > now I'm confused - does userspace setup the guest to receive an
>>> > exception or does it tell KVM to emulate an exception for the guest or
>>> > do we execute the breakpoint without trapping the debug exception?
>>>
>>> I've made it all go through userspace as we may have to translate the
>>> hypervisor visible exception code to what the guest was expecting to see.
>>>
>>
>> ok, so I think you should re-phrase something like:
>>
>> "Userspace may decide that this exception is caused by the guest using
>> debugging itself, and may in that case emulate the guest debug exception
>> in userspace before resuming KVM."
>>
>> But does that really work?  Given that we don't support KVM-TCG
>> migration, this sounds a little strange.  Did we test it?
>
> The QEMU patches have a TODO note at the point where you'd want
> to do this... Design-wise you can do the reinjection in the
> kernel or in userspace (ppc QEMU does this in userspace, for
> instance) because it's pretty much just setting registers to fake
> up the exception-entry into EL1. Code-wise QEMU's ARM code isn't
> set up to do it right now, but it shouldn't be too difficult to
> persuade the TCG exception-entry code to work for this case too.
>
> Does the kernel already have a conveniently implemented "inject
> exception into guest" lump of code? If so it might be less effort
> to do it that way round, maybe.

So you pointed out we can't just re-inject the exceptions we get as we
need to map from things like ESR_ELx_EC_WATCHPT_LOW to
ESR_ELx_EC_WATCHPT_CUR before re-injection.

Of course if it is as simple as modifying the ESR_EL1 register and
returning +ve in the handle_exit path then I can do that but I assumed
if any other wrangling needs doing it should be done in userspace.

>
> -- PMM

-- 
Alex Benn?e
