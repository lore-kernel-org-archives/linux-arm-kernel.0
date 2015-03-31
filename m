From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 31 Mar 2015 20:01:38 +0900
Subject: [PATCH v2 2/3] rtc: mediatek: Add MT6397 RTC driver
In-Reply-To: <1427795066.14023.64.camel@mtksdaap41>
References: <1426657537-41414-1-git-send-email-eddie.huang@mediatek.com>
 <1426657537-41414-3-git-send-email-eddie.huang@mediatek.com>
 <CAAFQd5ADCaKhP=3BmJsVimvo-uXZB3pobVAUST-b5kU+98Rt+A@mail.gmail.com>
 <1427795066.14023.64.camel@mtksdaap41>
Message-ID: <CAAFQd5AHcFi-NhQ5ogbqRR-mdhoELBaKD0JgLu9v462JD6JBRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie,

Please see my response inline.

On Tue, Mar 31, 2015 at 6:44 PM, Eddie Huang <eddie.huang@mediatek.com> wrote:

[snip]

>> > +       ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
>> > +       if (ret < 0)
>> > +               goto exit;
>> > +
>> > +       while (data & RTC_BBPU_CBUSY) {
>> > +               cpu_relax();
>> > +               ret = mtk_rtc_read(rtc, RTC_BBPU, &data);
>> > +               if (ret < 0)
>> > +                       goto exit;
>> > +       }
>>
>> The initial read and the loop could be folded into a do {} while loop?
>> Also it would be safer to have a timeout here.
> Because I need to check return value, so not put initial read in do { }.

Hmm, inside the loop you also check return value. Considering the fact
that cpu_relax() doesn't do anything interesting besides issuing a
memory barrier (and probably could be omitted here) I don't see why
this couldn't be made a do {} while loop. (Obviously this is a bit of
bikeshedding, but by the way of other changes this could be changed as
well.)

[snip]

>>
>> Also shouldn't the unused bits be masked out?
> Hardware return zero in unused bits. So I think it not necessary to add
> mask.
>

OK. Thanks for explaining this.

>>
>> > +
>> > +exit:
>> > +       mutex_unlock(&rtc->lock);
>> > +       return ret;
>> > +}
>> > +
>> > +static int mtk_rtc_read_time(struct device *dev, struct rtc_time *tm)
>> > +{
>> > +       time64_t time;
>> > +       struct mt6397_rtc *rtc = dev_get_drvdata(dev);
>> > +       int sec, ret;
>> > +
>> > +       do {
>> > +               ret = __mtk_rtc_read_time(rtc, tm, &sec);
>> > +               if (ret < 0)
>> > +                       goto exit;
>> > +       } while (sec < tm->tm_sec);
>>
>> Shouldn't this be while (sec > tm->tm_sec)?
> No, it should keep it as is, this is used to check whether second
> overflow (from 59 to 0). If yes, read time again.
>

Ah, right, of course, an overlooking on my side. Thanks for clarifying this.

[snip]

>> > +       mutex_lock(&rtc->lock);
>> > +       if (alm->enabled) {
>>
>> Is this possible that an alarm was already set? Is it okay to keep it
>> enabled while changing the alarm time to new one?
> It's ok because all alarm time register set to hardware after call
> mtk_rtc_write_trigger.
>

Fair enough. Thanks for explanation. Could you maybe add a comment
here saying that the new alarm setting will be committed after calling
mtk_rtc_write_trigger()?

[snip]

>> > +       res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>> > +       rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
>> > +       if (rtc->irq <= 0)
>> > +               goto out_rtc;
>>
>> Just return an error code here directly. Which one is actually a good
>> question. Looks like existing code is using -EINVAL or -ENXIO. Any
>> ideas?
> I tend to use -EINVAL

SGTM.

[snip]

>> > +
>> > +out_rtc:
>> > +       rtc_device_unregister(rtc->rtc_dev);
>>
>> All references to this label are actually before rtc_device_register()
>> is even called. The proper thing to do here is to dispose the created
>> IRQ mapping.
> OK, will call irq_dispose_mapping and free_irq
>

OK, thanks. Please note that this will also mean changing
devm_request_threaded_irq() to normal request_threaded_irq().

Still, now as I think of it, I'm not sure if this driver is the right
place to call irq_create_mapping(). Instead, shouldn't the parent MFD
driver create the mapping and pass the final virtual IRQ number to
this driver through resources?

Lee, could you comment on this, please?

Best regards,
Tomasz
