From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Oct 2014 17:02:28 -0700
Subject: [PATCHv2 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <20141020224147.GA13670@leverpostej>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
 <1413819079-17120-2-git-send-email-dinguyen@opensource.altera.com>
 <20141020184139.GA23062@leverpostej>
 <CAD=FV=Xw2zAL-7s2XJk6fawMGUuMapGfqYGC6ntwG-TCi8GgkA@mail.gmail.com>
 <20141020224147.GA13670@leverpostej>
Message-ID: <CAD=FV=WoGQU+toQ8LM6K1B=tGe_sdLF6OVZ5uVCOtah7P8wvmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Mon, Oct 20, 2014 at 3:41 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Oct 20, 2014 at 08:26:55PM +0100, Doug Anderson wrote:
>> Mark,
>>
>> On Mon, Oct 20, 2014 at 11:41 AM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Mon, Oct 20, 2014 at 04:31:18PM +0100, dinguyen at opensource.altera.com wrote:
>> >> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>> >>
>> >> Without this patch, the booting the SOCFPGA platform would hang at the
>> >> SDMMC driver loading. There were 2 patches that caused this to happen:
>> >>
>> >> - Patch 9795a846e10 "mmc: dw_mmc: remove dw_mci_of_cd_gpio/wp_gpio()" removed
>> >>   looking for "cd-gpios", since mmc_of_parse was getting called.
>> >> - Patch 3cf890fc42b "mmc: dw_mmc: Pass back errors from mmc_of_parse()" would
>> >>   hang the system at the SDMMC driver loading.
>> >
>> > Regardless of which patches caused the issue, the existing DTB should
>> > continue to function. This is a kernel bug, not a DTB bug.
>>
>> Right.  The kernel bug is that there is no "dtb fixup" stage of the
>> kernel to fix up old dtbs with this dtb bug.
>>
>> Said another way:
>>
>> 1. The old dtb was (possibly) not specifying the cd-gpio properly.
>>
>> 2. The kernel had a bug where it was ignoring that error.  Things may
>> have been working because of some other side effect (maybe polling was
>> working).
>>
>> 3. If we fix the kernel bug, what should we do?  The only sensible
>> thing (if we need to support old DTB with no changes) is to add a DTB
>> fixup stage.
>>
>> ...or did someone add that stage and I missed it?
>
> Unfortunately, we have no generic DTB fixup stage currently.

Right.  ...and that's the bug.

I think we may need to modify the general inclination to respond to
dts change requests with "the DTS can't have a bug in it".  DTS files
can indeed have bugs in it.  In this case the dts file was claiming
that the card detect GPIO was a GPIO on a controller that the same dts
claimed was "disabled".  If that's not a bug in the DTS I'm not sure
what it is.

There are all sorts of broken ways that we could work around this in
the driver.  We could pretend that EPROBE_DEFER really meant "I'm all
good".  We could add a special case for this particular board in
dw_mmc (do we check the overall device tree compatible string?).  We
could do all sorts of hacks.  None of them are right.  The "right"
behavior if we really care about maintaining compatbility with old DTB
files is to add a fixup stage for this particular broken board.

Given that no such fixup stage exists, if someone really wants old DTB
files to work then we should add one.

-Doug
