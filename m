From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 1 Nov 2012 06:48:34 +0100
Subject: [PATCH v3 9/9] pinctrl: single: dump pinmux register value
In-Reply-To: <20121101004734.GK15766@atomide.com>
References: <1351724661-29050-1-git-send-email-haojian.zhuang@gmail.com>
 <1351724661-29050-10-git-send-email-haojian.zhuang@gmail.com>
 <20121101004734.GK15766@atomide.com>
Message-ID: <CAN1soZxVp73uNWD7Q9r_3X1hCA=JhMiMpx2UMPPGiXBtQ2QjAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2012 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Haojian Zhuang <haojian.zhuang@gmail.com> [121031 16:07]:
>> Dump pinmux register value, not only function part in the pinmux
>> register.
>>
>> Also fix the issue on caluclating pin offset. The last parameter
>> should be pin number, not register offset.
>
> You have a minor typo   ^^^^^^^^^^^ should be calculating
> instead.
>
> Is there a bug that should be fixed for the -rc cycle
> here? That's the impression I get from the description.
> Or is it just a cosmetic fix to rename offset to pin?
>
> Regards,
>
> Tony
>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>  drivers/pinctrl/pinctrl-single.c |    8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
>> index 3b97b65..72017e7 100644
>> --- a/drivers/pinctrl/pinctrl-single.c
>> +++ b/drivers/pinctrl/pinctrl-single.c
>> @@ -283,15 +283,15 @@ static int pcs_get_group_pins(struct pinctrl_dev *pctldev,
>>
>>  static void pcs_pin_dbg_show(struct pinctrl_dev *pctldev,
>>                                       struct seq_file *s,
>> -                                     unsigned offset)
>> +                                     unsigned pin)
>>  {
>>       struct pcs_device *pcs;
>> -     unsigned val;
>> +     unsigned val, mux_bytes;
>>
>>       pcs = pinctrl_dev_get_drvdata(pctldev);
>>
>> -     val = pcs->read(pcs->base + offset);
>> -     val &= pcs->fmask;
>> +     mux_bytes = pcs->width / BITS_PER_BYTE;
>> +     val = pcs->read(pcs->base + pin * mux_bytes);
>>
>>       seq_printf(s, "%08x %s " , val, DRIVER_NAME);
>>  }
>> --
>> 1.7.10.4
>>

There's also include a bug fix. I'm OK that this patch could be
included in -rc cycle.
