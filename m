From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 17 Apr 2014 20:26:22 +0100
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAL_JsqKxsR6-pKv9sP4z1nnp+sy7GncGDyL+kMkF60efn2=DsA@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
 <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
 <CAL_JsqKxsR6-pKv9sP4z1nnp+sy7GncGDyL+kMkF60efn2=DsA@mail.gmail.com>
Message-ID: <CAFEAcA8Ahe7A8Usy5x-DVvb6xxr3x6ELJS+NyzjDQKPv6FFLoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2014 17:58, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Apr 17, 2014 at 5:02 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 2 April 2014 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>>>> Like others, I have been carrying this change locally. Good to see it up!
>>>
>>> Why are you all booting raw Images anyway (just out of curiosity)?
>>
>> Given the recent feedback from the kernel mailing list (viz "don't boot
>> Image unless you really know what you're doing, the correct load
>> image may change randomly depending what other board support
>> is in a multikernel image, etc") maybe we should just remove the
>> Image booting support instead? Clearly nobody who hasn't locally
>> patched QEMU is using it at the moment...
>
> Including AArch64, too? :) It happens to be correct ATM, but really we
> should be looking the Image header to determine the offset. I heard
> Mark Rutland has some patches to do TEXT_OFFSET randomization in fact.

AArch64 is different -- the Image format is sanely specified and
includes enough information to get it right. (The fact that we don't
currently do so is a clear QEMU bug.)

> The choice of 0x10000 is not really a good one either as this forces
> the decompressor to move itself out of the way first. I guess it is a
> good choice if your goal is to test the worst possible code path for
> the decompressor.

The major awkwardness with AArch32 zImage is that it doesn't
give you enough information to know how big the zImage will
be uncompressed, so it's not possible for the bootloader to
sanity check that all the various bits and pieces aren't going
to overlap (and the kernel doesn't check either IIRC, so if things go
wrong they go wrong in various obscure ways).

We could certainly rearrange where QEMU puts things; the current
setup results from a mixture of:
 * legacy "this is how we've always done it" (and the fact that if we
   get things wrong and the uncompressed kernel overlaps with the
   DTB or initrd then the failure is unhelpfully cryptic has generally
   been a pressure towards "don't tweak things too much")
 * handling both Image and zImage (and now AArch64 Image)
   in broadly similar codepaths
 * wanting to handle both boards with what by modern standards are
    tiny amounts of memory and also boards with gigabytes of RAM,
    even though optimal choices for location are going to differ

I don't insist that we drop AArch32 Image support (or necessarily
even think we should gratuitously do so), but if it
makes it simpler to refactor the code to better handle the
other options then I don't particularly object to that happening.
I do think that it seems like an AArch32 Image loader that would
be useful to end-users ought to provide them with some way to
specify the load address or offset.

thanks
-- PMM
