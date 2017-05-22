From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Mon, 22 May 2017 07:44:56 +0200
Subject: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
In-Reply-To: <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <CAKv+Gu9x_KCdEGBBOw9yaYOcYBcYtxJX-xTX=4kQuWqY=VK0PA@mail.gmail.com>
Message-ID: <62548890-2541-32b2-2015-74b5ed40f115@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-05-21 10:09, Ard Biesheuvel wrote:
> On 19 May 2017 at 09:56, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> Commit bd698d24b1b57 ("i2c: designware: Get selected speed mode
>> sda-hold-time via ACPI") updated the logic that reads the timing
>> parameters for various I2C bus rates from the DSDT, to only read
>> the timing parameters for the currently selected mode.
>>
>> This causes a WARN_ON() splat on platforms that legally omit the clock
>> frequency from the ACPI description, because in the new situation, the
>> core I2C designware driver still accesses the fields in the driver
>> struct that we no longer populate, and proceeds to calculate them from
>> the clock frequency. Since the clock frequency is unspecified, the
>> driver complains loudly using a WARN_ON().
>>
>> So revert back to the old situation, where the struct fields for all
>> timings are populated, but retain the new logic which chooses the SDA
>> hold time from the timing mode that is currently in use.
>>
>> Fixes: bd698d24b1b57 ("i2c: designware: Get selected speed mode ...")
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/i2c/busses/i2c-designware-platdrv.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
>> index f2acd4b6bf01..6283b99d2b17 100644
>> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
>> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
>> @@ -96,6 +96,7 @@ static int dw_i2c_acpi_configure(struct platform_device *pdev)
>>         struct dw_i2c_dev *dev = platform_get_drvdata(pdev);
>>         acpi_handle handle = ACPI_HANDLE(&pdev->dev);
>>         const struct acpi_device_id *id;
>> +       u32 ss_ht, fp_ht, hs_ht, fs_ht;
> 
> Should these be initialized to zero? I realized that
> dw_i2c_acpi_params() could fail, resulting in bogus hold time values
> being returnted, but it is unclear to me how that affects the logic in
> the core driver.

I can tell you what happens: this breaks e.g. the Galileo and the
IOT2000 boards. Will send a patch to initialize the vars to 0, restoring
the previous behavior in the absence to the ACPI parameters. The core is
prepared for sda_hold_time == 0.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
