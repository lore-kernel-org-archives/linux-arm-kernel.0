From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 6 May 2016 12:55:15 +0800
Subject: [PATCH v7 6/9] i2c: rk3x: Move spec timing data to "static const"
 structs
In-Reply-To: <CAD=FV=Vg+umhA73uR66AdFmaNKhpyXCYojqE9kZJqkTOsyK_Jg@mail.gmail.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372472-6396-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=Vg+umhA73uR66AdFmaNKhpyXCYojqE9kZJqkTOsyK_Jg@mail.gmail.com>
Message-ID: <572C23B3.6090702@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016/5/6 6:58, Doug Anderson ??:
> David,
>
> On Wed, May 4, 2016 at 7:34 AM, David Wu <david.wu@rock-chips.com> wrote:
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>
> As you can probably guess, again a description would be nice.  Like maybe:
>
> The i2c timing specs are really just constant data.  There's no reason
> to write code to init them, so move them out to structures.  This not
> only is a cleaner solution but it will reduce code duplication when we
> introduce a new variant of rk3x_i2c_calc_divs() in a future patch.
>
> That helps someone reading the patch understand the motivation.
>
>
>> @@ -76,6 +76,51 @@ enum {
>>   #define DEFAULT_SCL_RATE  (100 * 1000) /* Hz */
>>
>>   /**
>> + * struct i2c_spec_values:
>> + * @min_hold_start_ns: min hold time (repeated) START condition
>> + * @min_low_ns: min LOW period of the SCL clock
>> + * @min_high_ns: min HIGH period of the SCL cloc
>> + * @min_setup_start_ns: min set-up time for a repeated START conditio
>> + * @max_data_hold_ns: max data hold time
>> + * @min_data_setup_ns: min data set-up time
>> + * @min_setup_stop_ns: min set-up time for STOP condition
>> + * @min_hold_buffer_ns: min bus free time between a STOP and
>> + * START condition
>> + */
>> +struct i2c_spec_values {
>> +       unsigned long min_hold_start_ns;
>> +       unsigned long min_low_ns;
>> +       unsigned long min_high_ns;
>> +       unsigned long min_setup_start_ns;
>> +       unsigned long max_data_hold_ns;
>> +       unsigned long min_data_setup_ns;
>> +       unsigned long min_setup_stop_ns;
>> +       unsigned long min_hold_buffer_ns;
>> +};
>> +
>> +static const struct i2c_spec_values standard_mode_spec = {
>> +       .min_hold_start_ns = 4000,
>> +       .min_low_ns = 4700,
>> +       .min_high_ns = 4000,
>> +       .min_setup_start_ns = 4700,
>> +       .max_data_hold_ns = 3450,
>> +       .min_data_setup_ns = 250,
>> +       .min_setup_stop_ns = 4000,
>> +       .min_hold_buffer_ns = 4700,
>
> There are more spec values than are currently used in this patch.
> Personally I'm OK with that, but if you wanted to be totally clean
> this patch would only include the spec values that were needed, then
> introduce the additional values in the rk3399 patch.
>
>
>> @@ -492,6 +548,8 @@ static int rk3x_i2c_calc_divs(unsigned long clk_rate,
>>          unsigned long min_div_for_hold, min_total_div;
>>          unsigned long extra_div, extra_low_div, ideal_low_div;
>>
>> +       unsigned long data_hold_buffer_ns = 50;
>
> aside (feel free to ignore): Gosh, I kinda forgot what the heck this
> value was for.  I guess it's not anything in the spec.  I have a
> feeling it was some sort of slop value that someone felt was
> necessary, but I don't quite remember.  Oh well, I guess we leave it
> there since I'd rather not mess with timings on old hardware that are
> apparently working for everyone.  :-P
>
>

I thing it was a tuning value for max_t_low_ns. :-P

> In any case, aside from the missing description:
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> IMHO this can be applied any time independent of any earlier patches.
>
>
> -Doug
>
>
>
