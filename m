From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 21 Jan 2016 13:26:39 +0100
Subject: [PATCH RFC 05/15] mmc: sunxi: Support MMC_DDR52 timing modes
In-Reply-To: <CAGb2v640b6tygtu1TkBEYM6Uf6JqpytzqUQ-Y1uxKf9PUwpQaA@mail.gmail.com>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
 <1453354002-28366-6-git-send-email-wens@csie.org>
 <56A0BD8F.2000805@redhat.com>
 <CAGb2v640b6tygtu1TkBEYM6Uf6JqpytzqUQ-Y1uxKf9PUwpQaA@mail.gmail.com>
Message-ID: <56A0CE7F.3080203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21-01-16 12:55, Chen-Yu Tsai wrote:
> On Thu, Jan 21, 2016 at 7:14 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 21-01-16 06:26, Chen-Yu Tsai wrote:
>>>
>>> DDR transfer modes include UHS-1 DDR50 and MMC HS-DDR (or MMC_DDR52).
>>> Consider MMC_DDR52 when setting clock delays.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>>> ---
>>>    drivers/mmc/host/sunxi-mmc.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>> index 4bec87458317..b403a2433eec 100644
>>> --- a/drivers/mmc/host/sunxi-mmc.c
>>> +++ b/drivers/mmc/host/sunxi-mmc.c
>>> @@ -687,7 +687,8 @@ static int sunxi_mmc_clk_set_rate(struct
>>> sunxi_mmc_host *host,
>>>                  oclk_dly = host->clk_delays[SDXC_CLK_25M].output;
>>>                  sclk_dly = host->clk_delays[SDXC_CLK_25M].sample;
>>>          } else if (rate <= 50000000) {
>>
>>
>> Shouldn't this be <= 52000000 then, considering that we may@one point get
>> some PLL setup where we may actually be able to do 52000000 for
>> MMC_TIMING_MMC_DDR52 ?
>
> Given that mmc->f_max = 50000000, the core will never try any clock rate higher
> than 50 MHz, and iirc clk_round_rate always rounds down. We could increase both
> numbers at the same time when we actually encounter such hardware.

I'm afraid that someone may increase mmc->f_max = 50000000 at one point without
adjusting the rate checks above at the same time, so lets update both of them now.

Regards,

Hans
