From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Sep 2017 23:49:56 +0200
Subject: [PATCH] ARM: unaligned.h: Use an arch-specific version
In-Reply-To: <CAKv+Gu-KAou7y-xTc7aaKU6WFstchKitSPJsKD_dXJ=_BbWb8w@mail.gmail.com>
References: <20170920151802.7609-1-romain.izard.pro@gmail.com>
 <CAKv+Gu_ZMy-A-Du3ikVe47pcUR7hSBFHY+hQQ8APGGP1iRcigA@mail.gmail.com>
 <CAK8P3a17y1zfhOPShjpbt+wf5B=ZyTb1jL1WiBHCz_rU4pNnnQ@mail.gmail.com>
 <CAKv+Gu-KAou7y-xTc7aaKU6WFstchKitSPJsKD_dXJ=_BbWb8w@mail.gmail.com>
Message-ID: <CAK8P3a3MDSDCZq_+Meub6ty8-ZasSOJ09Qjc3h4OArFcB24ScA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 11:36 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 September 2017 at 13:35, Arnd Bergmann <arnd@arndb.de> wrote:

>> The architectures that do use include/asm-generic/unaligned.h and
>> also set HAVE_EFFICIENT_UNALIGNED_ACCESS in some configurations
>> are arm, arm64, metag, s390 and arc.
>>
>> This is a rather short list, and three of them (arm64, metag and arc) only
>> support very recent compilers, so we can probably just ask the respective
>> arch maintainers to ack the patch that changes the asm-generic file
>> for everyone.
>>
>
> If we can limit the fallout like that, I agree that we should simply
> make the struct flavor the default. It elegantly informs the compiler
> about the size of the access and the potential misalignment, so it
> should allow compilers for any architecture to select the most
> appropriate instruction.
>
> But doesn't that mean that any code that currently relies on
> HAVE_EFFICIENT_UNALIGNED_ACCESS should be using get_unaligned instead?
> I haven't reviewed the actual use cases (other than the ones I added
> myself to the crypto subsystem), but it seems to me that it is
> generally unsafe to do any unaligned accesses directly on ARM, given
> that the compiler may merge adjacent LDRs into LDMs or LDRDs (and
> likewise for stores)

It's not clear that all that code should be using get_unaligned(),
but I agree that any code relying on
HAVE_EFFICIENT_UNALIGNED_ACCESS is potentially inefficient
on ARM when it causes a trap.

I think it would be a useful goal to avoid running into the ARM alignment
trap handler entirely for kernel code, but that sounds like a lot of work.

If we want to do that, we'd need at least these steps:

- review each reference to HAVE_EFFICIENT_UNALIGNED_ACCESS
  and modify it so that gcc will never use the trapping instructions
- add a WARN_ON_ONCE() in the trap handler
- fix any drivers we run into that should be using get_unaligned() but
  blindly rely on the trap handler instead.

        Arnd
