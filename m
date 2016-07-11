From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Mon, 11 Jul 2016 15:02:16 -0700
Subject: [PATCH v2 10/22] usb: chipidea: Add support for ULPI PHY bus
In-Reply-To: <20160711031003.GC30448@shlinux2>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-11-stephen.boyd@linaro.org>
 <20160711031003.GC30448@shlinux2>
Message-ID: <CAJOFmgxWM+9UaDC+QoBM5xutj1vPtSHmwiU8=cf2G5zSB8RRNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2016 at 20:10, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Thu, Jul 07, 2016 at 03:21:01PM -0700, Stephen Boyd wrote:
>> @@ -418,6 +427,17 @@ static inline bool ci_otg_is_fsm_mode(struct ci_hdrc *ci)
>>  #endif
>>  }
>>
>> +#if IS_ENABLED(CONFIG_USB_CHIPIDEA_ULPI)
>> +int ci_ulpi_init(struct ci_hdrc *ci);
>> +void ci_ulpi_exit(struct ci_hdrc *ci);
>> +int ci_ulpi_resume(struct ci_hdrc *ci);
>> +#else
>> +static inline int ci_ulpi_init(struct ci_hdrc *ci) { return 0; }
>> +static inline void ci_ulpi_exit(struct ci_hdrc *ci) { }
>> +static inline int ci_ulpi_resume(struct ci_hdrc *ci) { return 0; }
>> +#endif
>> +
>> +
>
> One more blank line
>

Fixed.

>> @@ -911,11 +918,15 @@ static int ci_hdrc_probe(struct platform_device *pdev)
>>
>>               /* if both generic PHY and USB PHY layers aren't enabled */
>>               if (PTR_ERR(ci->phy) == -ENOSYS &&
>> -                             PTR_ERR(ci->usb_phy) == -ENXIO)
>> -                     return -ENXIO;
>> +                             PTR_ERR(ci->usb_phy) == -ENXIO) {
>> +                     ret = -ENXIO;
>> +                     goto ulpi_exit;
>> +             }
>>
>> -             if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy))
>> -                     return -EPROBE_DEFER;
>> +             if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
>> +                     ret = -EPROBE_DEFER;
>> +                     goto ulpi_exit;
>> +             }
>
> Just confirm, you try to get PHY through:
>         ci->phy = devm_phy_get(dev->parent, "usb-phy");
> right?

Yes.
