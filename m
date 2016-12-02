From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 2 Dec 2016 14:09:09 +0100
Subject: [PATCH 3/3] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <4b1d65f7-d9a6-6d4e-00f5-2835b728661c@ti.com>
References: <1480612516-18853-1-git-send-email-bgolaszewski@baylibre.com>
 <1480612516-18853-4-git-send-email-bgolaszewski@baylibre.com>
 <4b1d65f7-d9a6-6d4e-00f5-2835b728661c@ti.com>
Message-ID: <CAMpxmJUCn1Fq-jMXdwQYsp2sHo8rBJ7jbYb_NKLamG=H6mNO=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-02 12:20 GMT+01:00 Sekhar Nori <nsekhar@ti.com>:
> On Thursday 01 December 2016 10:45 PM, Bartosz Golaszewski wrote:
>> This function is broken - its second argument is an index to the freq
>> table, not the requested clock rate in Hz. It leads to an oops when
>> called from clk_set_rate() since this argument isn't bounds checked
>> either.
>>
>> Fix it by iterating over the array of supported frequencies and
>> selecting a one that matches or returning -EINVAL for unsupported
>> rates.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> When this function was written, it was written for speed. The only user
> of setting pll0 rate is drivers/cpufreq/davinci-cpufreq.c (not sure how
> you were trying to set pll0 rate). And that driver directly passes the
> table index to the set_rate() function.
>

Hi Sekhar, thanks for the hints.

The origin of this series is the default pll0 frequency set by
upstream u-boot which caused FIFO underflows in LCDC even with the
pixel clock well below 37.5 MHz. I had already sent a patch to the
u-boot mailing list, but thought I'd try setting the clock from within
tilcdc code. This is when I stumbled upon this issue.

I'll send a v2 of this series.

Thanks,
Bartosz Golaszewski
