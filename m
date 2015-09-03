From: ykk@rock-chips.com (Yakir Yang)
Date: Thu, 03 Sep 2015 13:33:27 +0800
Subject: [PATCH v4 01/16] drm: exynos/dp: fix code style
In-Reply-To: <55E7D5EB.1060505@samsung.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441086399-24889-1-git-send-email-ykk@rock-chips.com>
 <55E79297.3050203@samsung.com> <55E7D4E4.6070808@rock-chips.com>
 <55E7D5EB.1060505@samsung.com>
Message-ID: <55E7DBA7.90504@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

? 09/03/2015 01:08 PM, Krzysztof Kozlowski ??:
> On 03.09.2015 14:04, Yakir Yang wrote:
>> Hi Krzysztof,
>>
>> ? 09/03/2015 08:21 AM, Krzysztof Kozlowski ??:
>>> On 01.09.2015 14:46, Yakir Yang wrote:
>>>> After run "checkpatch.pl -f --subjective" command, I see there
>>>> are lots of alignment problem in exynos_dp driver, so let just
>>>> fix them.
>>> Hi,
>>>
>>> Warnings from checkpatch are not a reason for a commit. Reason for a
>>> commit could be for example an unreadable code, violation of
>>> coding-style leading to decrease in code maintainability or just
>>> improving the code readability so it will be easier to review and
>>> maintain it.
>>>
>>> You do not make commits because some tool tells you that. We do not
>>> listen to machines :) ... If that would be the case, the commit could be
>>> made automatically, without human interaction. Such automated commit
>>> could be even easily tested by the machine by comparing object files.
>>>
>>> Especially that you enabled "subjective" rule. This is not a valid
>>> motivation for a commit.
>>>
>>> Please rephrase this to sensible reason and convince that change is
>>> worth the effort.
>> Oh, nice, thanks for your remind. I would rephrase the commit.
>>
>>>> - Take Romain suggest, rebase on linux-next branch
>>> That comment seems unrelated to the commit. Please remove it.
>> Done,
>>
>>>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>>>> ---
>>>> Changes in v4: None
>>>> Changes in v3: None
>>>> Changes in v2:
>>>> - Take Joe Preches advise, improved commit message more readable, and
>>>>     avoid using some uncommon style like bellow:
>>>>     -  retval = exynos_dp_read_bytes_from_i2c(...
>>>>                  ...)
>>>>     +  retval =
>>>>     +  exynos_dp_read_bytes_from_i2c(......);
>>>>
>>>>    drivers/gpu/drm/exynos/exynos_dp_core.c | 226
>>>> ++++++++++++++++----------------
>>>>    drivers/gpu/drm/exynos/exynos_dp_core.h |  54 ++++----
>>>>    drivers/gpu/drm/exynos/exynos_dp_reg.c  | 106 +++++++--------
>>>>    3 files changed, 188 insertions(+), 198 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c
>>>> b/drivers/gpu/drm/exynos/exynos_dp_core.c
>>>> index d66ade0..266f7f7 100644
>>>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
>>>> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
>>>> @@ -115,8 +115,8 @@ static int exynos_dp_read_edid(struct
>>>> exynos_dp_device *dp)
>>>>          /* Read Extension Flag, Number of 128-byte EDID extension
>>>> blocks */
>>>>        retval = exynos_dp_read_byte_from_i2c(dp, I2C_EDID_DEVICE_ADDR,
>>>> -                EDID_EXTENSION_FLAG,
>>>> -                &extend_block);
>>>> +                          EDID_EXTENSION_FLAG,
>>>> +                          &extend_block);
>>>>        if (retval)
>>>>            return retval;
>>>>    @@ -124,10 +124,11 @@ static int exynos_dp_read_edid(struct
>>>> exynos_dp_device *dp)
>>>>            dev_dbg(dp->dev, "EDID data includes a single extension!\n");
>>>>              /* Read EDID data */
>>>> -        retval = exynos_dp_read_bytes_from_i2c(dp,
>>>> I2C_EDID_DEVICE_ADDR,
>>>> -                        EDID_HEADER_PATTERN,
>>>> -                        EDID_BLOCK_LENGTH,
>>>> -                        &edid[EDID_HEADER_PATTERN]);
>>>> +        retval = exynos_dp_read_bytes_from_i2c(
>>>> +                    dp, I2C_EDID_DEVICE_ADDR,
>>>> +                    EDID_HEADER_PATTERN,
>>>> +                    EDID_BLOCK_LENGTH,
>>>> +                    &edid[EDID_HEADER_PATTERN]);
>>>>            if (retval != 0) {
>>>>                dev_err(dp->dev, "EDID Read failed!\n");
>>>>                return -EIO;
>>>> @@ -139,11 +140,11 @@ static int exynos_dp_read_edid(struct
>>>> exynos_dp_device *dp)
>>>>            }
>>>>              /* Read additional EDID data */
>>>> -        retval = exynos_dp_read_bytes_from_i2c(dp,
>>>> -                I2C_EDID_DEVICE_ADDR,
>>>> -                EDID_BLOCK_LENGTH,
>>>> -                EDID_BLOCK_LENGTH,
>>>> -                &edid[EDID_BLOCK_LENGTH]);
>>>> +        retval = exynos_dp_read_bytes_from_i2c(
>>>> +                    dp, I2C_EDID_DEVICE_ADDR,
>>>> +                    EDID_BLOCK_LENGTH,
>>>> +                    EDID_BLOCK_LENGTH,
>>>> +                    &edid[EDID_BLOCK_LENGTH]);
>>>>            if (retval != 0) {
>>>>                dev_err(dp->dev, "EDID Read failed!\n");
>>>>                return -EIO;
>>>> @@ -155,24 +156,22 @@ static int exynos_dp_read_edid(struct
>>>> exynos_dp_device *dp)
>>>>            }
>>>>              exynos_dp_read_byte_from_dpcd(dp, DP_TEST_REQUEST,
>>>> -                    &test_vector);
>>>> +                          &test_vector);
>>>>            if (test_vector & DP_TEST_LINK_EDID_READ) {
>>>> -            exynos_dp_write_byte_to_dpcd(dp,
>>>> -                DP_TEST_EDID_CHECKSUM,
>>>> +            exynos_dp_write_byte_to_dpcd(
>>>> +                dp, DP_TEST_EDID_CHECKSUM,
>>>>                    edid[EDID_BLOCK_LENGTH + EDID_CHECKSUM]);
>>>> -            exynos_dp_write_byte_to_dpcd(dp,
>>>> -                DP_TEST_RESPONSE,
>>>> +            exynos_dp_write_byte_to_dpcd(
>>>> +                dp, DP_TEST_RESPONSE,
>>>>                    DP_TEST_EDID_CHECKSUM_WRITE);
>>> To me, missing argument after opening parenthesis, looks worse. I would
>>> prefer:
>>>
>>>              exynos_dp_write_byte_to_dpcd(dp,
>>>
>>> Why you moved the 'dp' argument to new line?
>> Hmm... Just like style tool indicate, no more warning after
>> that change.
>>
>> For now, I would like to follow the original style, just improved
>> some obvious style problem.  :-)
> What was the checkpatch warning that said 'dp' has to move to new line?
> I tried this and I don't see it.

checkpatch haven't remind me that put dp to new line would fix
this warning, this just come from my experiments. And I works,
no more warnings from checkpatch, so I toke this style.

- Yakir

> Best regards,
> Krzysztof
>
>
>
>
