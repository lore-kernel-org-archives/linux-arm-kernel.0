From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 23 May 2017 09:33:25 +0200
Subject: [PATCH] spi: add null check before pointer dereference
In-Reply-To: <CAJKOXPepyk6KtSUNXymjMkT6qTX9PnCC1LvTC4y_2dL0nZ-kMA@mail.gmail.com>
References: <20170523002507.GA16670@embeddedgus>
 <CAJKOXPepyk6KtSUNXymjMkT6qTX9PnCC1LvTC4y_2dL0nZ-kMA@mail.gmail.com>
Message-ID: <CAMuHMdVNTT9JJvZ_SuSUkAPMqYOmdG-4zLggwaT_ObStbGG_ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 9:24 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, May 23, 2017 at 2:25 AM, Gustavo A. R. Silva
> <garsilva@embeddedor.com> wrote:
>> Add null check before dereferencing pointer desc
>>
>> Addresses-Coverity-ID: 1397997
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/spi/spi-s3c64xx.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
>> index b392cca..9f1013e 100644
>> --- a/drivers/spi/spi-s3c64xx.c
>> +++ b/drivers/spi/spi-s3c64xx.c
>> @@ -306,6 +306,12 @@ static void prepare_dma(struct s3c64xx_spi_dma_data *dma,
>>         desc = dmaengine_prep_slave_sg(dma->ch, sgt->sgl, sgt->nents,
>>                                        dma->direction, DMA_PREP_INTERRUPT);
>>
>> +       if (!desc) {
>> +               dev_err(&sdd->master->dev,
>> +                       "%s:dmaengine_prep_slave_sg Failed\n", __func__);
>> +               return;
>> +       }
>
> Although the check itself looks needed, but I think you did not handle
> the error at all. You just bail out before submitting dma descriptor
> but except that, everything else goes like there was no error. It
> might work, might not... did you test this error path? How does it
> behave?

I.e. does it fall back to PIO?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
