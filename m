From: djkurtz@chromium.org (Daniel Kurtz)
Date: Tue, 10 Nov 2015 08:34:16 +0800
Subject: [PATCH v2 1/2] i2c: mediatek: add i2c first write then read
 optimization
In-Reply-To: <CAHp75VfutRR0N0bGDYMjFr+nQGFnmuoiA2afvYfuZ2aOy=2qbQ@mail.gmail.com>
References: <1447047839-5223-1-git-send-email-liguo.zhang@mediatek.com>
 <1447047839-5223-2-git-send-email-liguo.zhang@mediatek.com>
 <CAHp75VfutRR0N0bGDYMjFr+nQGFnmuoiA2afvYfuZ2aOy=2qbQ@mail.gmail.com>
Message-ID: <CAGS+omD08HPGz1-zRWArLWrrN0AMmh2T2dnoTfpZfo+s4u9P=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 10:25 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Nov 9, 2015 at 7:43 AM, Liguo Zhang <liguo.zhang@mediatek.com> wrote:
>> For platform with auto restart support, between every transfer,
>> i2c controller will trigger an interrupt and SW need to handle
>> it to start new transfer. When doing write-then-read transfer,
>> instead of restart mechanism, using WRRD mode to have controller
>> send both transfer in one request to reduce latency.
>
>
>> @@ -518,6 +529,16 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
>>         if (ret)
>>                 return ret;
>>
>> +       i2c->auto_restart = i2c->dev_comp->auto_restart;
>> +
>> +       /* checking if we can skip restart and optimize using WRRD mode */
>> +       if (i2c->auto_restart && num == 2) {
>> +               if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
>> +                   msgs[0].addr == msgs[1].addr) {
>
> Nitpick (optional):
>
> ((msgs[0].flags & msgs[1].flags) & I2C_M_RD)
> ?

IMHO, this makes the code less readable.
Leave this to the compiler's optimizer.

-Dan

>
>> +                       i2c->auto_restart = 0;
>> +               }
>> +       }
>
> --
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
