From: dianders@chromium.org (Doug Anderson)
Date: Tue, 8 Jul 2014 08:27:47 -0700
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <CACRpkdZrDJ3xoUYGynf0sO4-U7ZVkJ=Mr_pNVSdar8oM85aVgA@mail.gmail.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
 <CACRpkdZrDJ3xoUYGynf0sO4-U7ZVkJ=Mr_pNVSdar8oM85aVgA@mail.gmail.com>
Message-ID: <CAD=FV=WQWBkq5JKttikLkyKEDX-YydQJLr9=bFWifpy2Lf0mSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 8, 2014 at 12:46 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Jun 26, 2014 at 11:15 AM, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
>
>> From: Doug Anderson <dianders@chromium.org>
>>
>> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
>> being reset across sleep/wake.  If we don't set it to anything then
>> the TPM will be reset.  U-Boot will detect this as invalid
>> and will reset the system on resume time. This GPIO can always be low
>> and not hurt anything.  It will get pulled back high again during a
>> normal warm reset when it will default back to an input.
>>
>> To properly preserve the TPM state across suspend/resume and to make
>> the chrome U-Boot happy, properly set the GPIO to mask the
>> reset to the TPM.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> (...)
>> +       /* We need GPX0_6 to be low at sleep time; just keep it low always */
>> +       mask_tpm_reset_regulator: mask-tpm-reset-regulator {
>> +       compatible = "regulator-fixed";
>
> No matter how the discussion ends up, regulator-fixed is wrong.

OK, fair enough.


> Either folding it into the TPM driver or using a separate reset driver
> is fine with me.

OK, Vikas: do you want to code up the driver?


> So what about the generic delayed reset GPIO thing?
> http://marc.info/?l=linux-kernel&m=140309916607115&w=2

That's a neat concept and could be useful in other cases, but I think
it's just as much of a hack as using a regulator.  This is not a reset
signal for the TPM.  This is a signal that will mask the CPU's reset
signal (using a special bit of board-specific logic).


Personally I think Tomasz's idea of using hogs (after his patches
allowing a default output level) is the cleanest, but I think Stephen
didn't like that.

-Doug
