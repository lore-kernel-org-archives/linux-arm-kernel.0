From: sylvester.nawrocki@gmail.com (Sylwester Nawrocki)
Date: Fri, 09 Nov 2012 11:05:40 +0100
Subject: [PATCH] ARM: S3C64XX: Statically define parent clock of the
 "camera" clock
In-Reply-To: <CAA11ShABPJhLP5dvx65=HOzSNoiY+jjiiNPAvd_x_5z7K3meVg@mail.gmail.com>
References: <CAA11ShAo_N5iwPmVqE27NMzhpSD6NZORqf7yvjUyZ-+kGkgYog@mail.gmail.com>
 <1352449929-20168-1-git-send-email-sylvester.nawrocki@gmail.com>
 <CAA11ShABPJhLP5dvx65=HOzSNoiY+jjiiNPAvd_x_5z7K3meVg@mail.gmail.com>
Message-ID: <509CD574.2050909@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/09/2012 10:31 AM, Andrey Gusakov wrote:
> On Fri, Nov 9, 2012 at 12:32 PM, Sylwester Nawrocki
> <sylvester.nawrocki@gmail.com>  wrote:
>> The "camera" clock defined in arch/arm/mach-s3c64xx/clock.c has null
>> clock source mux control register as it can have only one parent
>> clock. In such cases there is a need to configure the parent clock
>> statically, otherwise s3c_set_clksrc() bails out with an error message
>> "no parent clock specified" leaving the parent clock not configured.
>> Define statically the parent clock so it is possible to get or set
>> rate of the "camera" clock.
>> While at it remove the unneded null reg_src definition.
>>
>> Reported-by: In-Bae Jeong<kukyakya@gmail.com>
>> Signed-off-by: Sylwester Nawrocki<sylvester.nawrocki@gmail.com>
>> ---
>>   arch/arm/mach-s3c64xx/clock.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
>> index 28041e8..2e6d7f9 100644
>> --- a/arch/arm/mach-s3c64xx/clock.c
>> +++ b/arch/arm/mach-s3c64xx/clock.c
>> @@ -744,9 +744,9 @@ static struct clksrc_clk clksrcs[] = {
>>                          .name           = "camera",
>>                          .ctrlbit        = S3C_CLKCON_SCLK_CAM,
>>                          .enable         = s3c64xx_sclk_ctrl,
>> +                       .parent         =&clk_h2,
>>                  },
>>                  .reg_div        = { .reg = S3C_CLK_DIV0, .shift = 20, .size = 4  },
>> -               .reg_src        = { .reg = NULL, .shift = 0, .size = 0  },
>>                  .sources        =&clkset_camif,
> Just figure out that .sources can be removed to. And seems
> "clkset_camif" and "clkset_camif_list" can be removed as unused.

OK, you're right. I think it could be done as a separate patch,
depending on this one to avoid conflicts.

> I'll try to test it tiday.

Thanks.
