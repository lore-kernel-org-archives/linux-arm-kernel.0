From: dianders@chromium.org (Doug Anderson)
Date: Mon, 20 Oct 2014 12:30:30 -0700
Subject: [PATCHv2 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <544538FF.7090200@opensource.altera.com>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
 <1413819079-17120-2-git-send-email-dinguyen@opensource.altera.com>
 <CAD=FV=X=DOVLeW6YQzFcXBrVte9vCizMvDy9DJQFLYUnzEAeHQ@mail.gmail.com>
 <544538FF.7090200@opensource.altera.com>
Message-ID: <CAD=FV=XwyMA1XByB5Mrd+=vSzMCeKzjzY=wEgm3x1t0PbqfLQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dinh,

On Mon, Oct 20, 2014 at 9:31 AM, Dinh Nguyen
<dinguyen@opensource.altera.com> wrote:
>>>  &mmc0 {
>>> -       cd-gpios = <&gpio1 18 0>;
>>> +       cd = <&gpio1 18 0>;
>>
>> This doesn't look right to me.  What was the error that was passed back?
>>
>> I think your change has the same net effect as just deleting the
>> "cd-gpios" line.  ...or is there some code somewhere that is parsing
>> the "cd" property.
>>
>
> It just hangs here:
>
> dw_mmc ff704000.dwmmc0: Using PIO mode.
> dw_mmc ff704000.dwmmc0: Version ID is 240a
> dw_mmc ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host data
> width, 1024 deep fifo
> platform ff704000.dwmmc0: Driver dw_mmc requests probe deferral
>
>
> Without this patch :
> mmc_of_parse ret=-517 (EPROBE_DEFER)

I think you need to dig more into this error.  Why are you getting an
-EPROBE_DEFER when you asked for this GPIO?

The -EPROBE_DEFER tells the system that a resource is not available
yet and that it should try to re-run the dw_mmc init later once the
resource becomes available.  I believe that some other bug is causing
the resource to never become available.

Guesses:

* The GPIO specifier is wrong in the DTB and is pointing to a GPIO
that would never exist.

* Something is happening in the GPIO driver that is causing it to fail.


...so we need to dig in further.

-Doug
