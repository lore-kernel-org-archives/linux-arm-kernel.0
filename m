From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 30 Sep 2010 23:37:09 +0900
Subject: [PATCH] spi/pl022: compare bitwidth to enums
In-Reply-To: <AANLkTin6fPnDdSqQiWKH8kTnREV2g8p94HzQQcjcpKLs@mail.gmail.com>
References: <1285840671-9567-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTin6fPnDdSqQiWKH8kTnREV2g8p94HzQQcjcpKLs@mail.gmail.com>
Message-ID: <AANLkTimGpfazBPYp3cc4pSFUJ_Q7GaPVxRtB2=YSM5YE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 30, 2010 at 8:34 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
> 2010/9/30 Linus Walleij <linus.walleij@stericsson.com>:
>
>> The enums from <linux/amba/pl022.h> are actually off-by-one
>> since bitwidth 4 is defined as 0x03, causing weirdness when
>> we were trying out some 9-bit peripheral. Fix this by
>> comparing to the enum values rather than hardcoded values
>> and also fixing the enum to something reasonable.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
>> (...)
>> - ? ? ? if (chip_info->data_size <= 8) {
>> + ? ? ? if (chip_info->data_size <= SSP_DATA_BITS_8) {
>> ? ? ? ? ? ? ? ?dev_dbg(&spi->dev, "1 <= n <=8 bits per word\n");
>> ? ? ? ? ? ? ? ?chip->n_bytes = 1;
>> ? ? ? ? ? ? ? ?chip->read = READING_U8;
>> ? ? ? ? ? ? ? ?chip->write = WRITING_U8;
>> - ? ? ? } else if (chip_info->data_size <= 16) {
>> + ? ? ? } else if (chip_info->data_size <= SSP_DATA_BITS_16) {
>
> I just realized that Kevin Wells patch actually patch away this problem
> so merge his patch and disregard this for the optimal solution.
>
>> ?enum ssp_data_size {
>> - ? ? ? SSP_DATA_BITS_4 = 0x03, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
>> + ? ? ? SSP_DATA_BITS_4 = 0x04, SSP_DATA_BITS_5, SSP_DATA_BITS_6,
>
> This is not good because this is used for default register
> settings too (I didn't notice, typical).

And it creates a 1:1 mapping of name to the same number.  Insane!
Just use the integer number directly.  :-)

>
> If anyone still wants a patch for older kernels I can provide a
> patch against 2.6.36-rc6 with just the first two hunks.
>
> Yours,
> Linus Walleij
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
