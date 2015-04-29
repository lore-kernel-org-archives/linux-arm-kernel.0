From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 29 Apr 2015 21:20:12 +0200
Subject: [PATCH v2 06/10] KVM: arm64: guest debug,
 add SW break point support
In-Reply-To: <87oam70y64.fsf@linaro.org>
References: <20150414082558.GS6186@cbox> <87y4li6hua.fsf@linaro.org>
 <20150427200407.GG23335@cbox>
 <CAFEAcA-Kh7Tn+kw9psL=gqme9ogAn+mM8Uco_HcJy=cqg72hbw@mail.gmail.com>
 <87wq0wr6dd.fsf@linaro.org>
 <CAFEAcA85i_1JybEFBg91NA3-LpAzYh4RSDnqryOd=rZN7gZP5A@mail.gmail.com>
 <20150428125645.GA4137@cbox> <87tww0qqh9.fsf@linaro.org>
 <20150429081047.GB4137@cbox> <87r3r31eed.fsf@linaro.org>
 <20150429103814.GC4137@cbox> <87oam70y64.fsf@linaro.org>
Message-ID: <CAMJs5B-qs9euMo4yW1-prnakBHo37qvhcDvtVPVXqPoyA_J1Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 5:08 PM, Alex Benn?e <alex.bennee@linaro.org> wrote:
>
> Christoffer Dall <christoffer.dall@linaro.org> writes:
>
>> On Wed, Apr 29, 2015 at 10:18:18AM +0100, Alex Benn?e wrote:
>>>
>>> Christoffer Dall <christoffer.dall@linaro.org> writes:
>>>
>>> > On Tue, Apr 28, 2015 at 03:37:01PM +0100, Alex Benn?e wrote:
>>> >>
>>> >> Christoffer Dall <christoffer.dall@linaro.org> writes:
>>> >>
>>> >> > On Tue, Apr 28, 2015 at 10:34:12AM +0100, Peter Maydell wrote:
>>> >> >> On 28 April 2015 at 09:42, Alex Benn?e <alex.bennee@linaro.org> wrote:
>>> >> >> > Peter Maydell <peter.maydell@linaro.org> writes:
>>> >> >> >> Does the kernel already have a conveniently implemented "inject
>>> >> >> >> exception into guest" lump of code? If so it might be less effort
>>> >> >> >> to do it that way round, maybe.
>>> >> >> >
> <snip>
>>> >>
>>> >> Certainly there are some cases where the kernel doesn't have all the
>>> >> information. For example it doesn't know if the soft break was inserted
>>> >> by the guest or the host. That to me favours the "let userspace deal
>>> >> with the ugly" approach.
>>> >>
>>> > Not sure I follow.
>>> >
>>> > If it's an exception for the guest, then that must be because the guest
>>> > put in the breakpoint instruction, right?
>>>
>>> No the host can add breakpoint instructions as well. They both generate
>>> the same (redirected) exception to the hypervisor which then has to
>>> figure out who planted the breakpoint and where the eventual exception
>>> will be handled.
>>
>> I understand this; let's just rewind here.
>>
>> If you've concluded that the exception is for the guest, then the guest
>> must have placed the breakpoint instruction there, correct?  Otherwise,
>> the exception is for the hypervisor and the discussion about how to
>> inject an exception for the guest is invalid.
>
> But only userspace has enough information to make that conclusion (after
> searching the list of breakpoints it added to the code). So from
> userspace we can:
>
>   - re-enter KVM telling it to re-route the exception it just delivered
>     to userspace somehow
>
>   or
>
>   - make the changes to deliver the exception in userspace and re-enter
>     KVM as normal.
>

ok, we agree and are talking about the same thing.  good.

> It seems to me if we have already exited into userspace it may as well
> clean up if it has all the information it needs?
>

depends on the complexity and size of the code really, imho.

>> Or are you talking about the corner case where the host uses a soft
>> breakpoint to get a breakpoint on an instruction which is also a
>> breakpoint in the guest?
>
> I think in this case host debugging just wins.
>
ok
