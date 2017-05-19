From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 19 May 2017 11:06:45 +0100
Subject: [PATCH] i2c: designware: don't infer timings described by ACPI
 from clock rate
In-Reply-To: <ab57959e-7c00-7f92-8631-5204685c719c@linux.intel.com>
References: <20170519085640.15111-1-ard.biesheuvel@linaro.org>
 <ab57959e-7c00-7f92-8631-5204685c719c@linux.intel.com>
Message-ID: <CAKv+Gu-wRmxWnT+5mb19h2Ggq5kS8qU9dMbEgoPK=0b06P0bFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2017 at 11:01, Jarkko Nikula <jarkko.nikula@linux.intel.com> wrote:
> On 05/19/2017 11:56 AM, Ard Biesheuvel wrote:
>>
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
> Thanks, this is ok to me. Let's add also kudos to Lorenzo:
>
> Reported-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

Thanks. I suppose this is going in as a fix? If not, please cc to -stable
