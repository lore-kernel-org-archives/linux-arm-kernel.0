From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 6 May 2016 10:12:04 +0800
Subject: [PATCH v7 9/9] i2c: rk3x: support fast-mode plus for rk3399
In-Reply-To: <CAD=FV=UtHPDtB7LTbUpwcjOcoYwNma59-TRDU3hrt6c_2TWxxA@mail.gmail.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372668-6583-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=UtHPDtB7LTbUpwcjOcoYwNma59-TRDU3hrt6c_2TWxxA@mail.gmail.com>
Message-ID: <572BFD74.9080200@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016/5/6 7:02, Doug Anderson ??:
> David,
>
> On Wed, May 4, 2016 at 7:37 AM, David Wu <david.wu@rock-chips.com> wrote:
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>>   drivers/i2c/busses/i2c-rk3x.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
>> index 47368c4..c66cc39 100644
>> --- a/drivers/i2c/busses/i2c-rk3x.c
>> +++ b/drivers/i2c/busses/i2c-rk3x.c
>> @@ -124,6 +124,17 @@ static const struct i2c_spec_values fast_mode_spec = {
>>          .min_hold_buffer_ns = 1300,
>>   };
>>
>> +static const struct i2c_spec_values fast_mode_plus_spec = {
>> +       .min_hold_start_ns = 260,
>> +       .min_low_ns = 500,
>> +       .min_high_ns = 260,
>> +       .min_setup_start_ns = 260,
>> +       .max_data_hold_ns = 400,
>
> I'm curious where you got the data_hold_ns.  I can't quite remember
> what this parameter does / how the timing function works anymore, but
> the doc I have (search for UM10204 and click the first link) shows
> values for Standard-mode and Fast-mode but not Fast-mode Plus.  It
> seems to imply that this is a bit of a bogus number anyway because it
> only matters if we don't stretch the tLOW to go along with the longer
> data hold.
>
> As I have said in the previous patch, how all this stuff works has
> totally left my brain, so if you understand it that's probably good
> enough.  If you feel like I should try to re-understand this again so
> I can review it more deeply, let me know.
>
>

Yes, I could not get the description of fast-mode plus data_hold_ns, but 
I saw that the maximum tHD;DAT must be less than the maximum of 
tVD;DATor tVD;ACKby for Standard-mode and Fast-mode.

So I think the maximum tHD;DAT for Fast-mode Plus should be less than 
the maximum of tVD;DATor tVD;ACKby too, the maximum of tVD;DATor 
tVD;ACKby is 450ns, and 400ns is my taking a conservative value.

Description form UM10204
[4] The maximum tHD;DATcould be 3.45?s and 0.9?s for Standard-mode and 
Fast-mode, but must be less than the maximum of tVD;DATor tVD;ACKby a 
transition time. This maximum must only be met if the device does not 
stretch the LOW period (tLOW) of the SCL signal. If the clock stretches 
the SCL, the data must be valid by the set-up time before it releases
the clock.

> Since I assume that you had some sane reason to include max_data_hold_ns:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
>
>
