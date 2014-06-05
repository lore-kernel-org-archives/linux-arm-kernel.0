From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 05 Jun 2014 21:14:34 +0200
Subject: [PATCH v2] clk: exynos5420: Keep aclk66_peric enabled during boot
In-Reply-To: <CAD=FV=W8-M5iOMDG190WGaeSySTd=qcp30k-H8DMUs_C5Pdwog@mail.gmail.com>
References: <1401398496-4624-1-git-send-email-dianders@chromium.org>
 <1401467562-5585-1-git-send-email-dianders@chromium.org>
 <CAD=FV=W8-M5iOMDG190WGaeSySTd=qcp30k-H8DMUs_C5Pdwog@mail.gmail.com>
Message-ID: <5390C19A.9060201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.06.2014 20:48, Doug Anderson wrote:
> Tomasz / Mike,
> 
> On Fri, May 30, 2014 at 9:32 AM, Doug Anderson <dianders@chromium.org> wrote:
>> Right now if you've got earlyprintk enabled on exynos5420-peach-pit
>> then you'll get a hang on boot.  Here's why:
>>
>> 1. The i2c-s3c2410 driver will probe at subsys_initcall.  It will
>>    enable its clock and disable it.  This is the clock "i2c2".
>> 2. The act of disabling "i2c2" will disable its parents.  In this case
>>    the parent is "aclk66_peric".  There are no other children of
>>    "aclk66_peric" officially enabled, so "aclk66_peric" will be turned
>>    off (despite being CLK_IGNORE_UNUSED, but that's by design).
>> 3. The next time you try to earlyprintk you'll do so without the UART
>>    clock enabled.  That's because the UART clocks are also children of
>>    "aclk66_peric".  You'll hang.
>>
>> There's no good place to put a clock enable for earlyprintk, which is
>> handled by a bunch of assembly code.  The best we can do is to handle
>> this in the clock driver.
>>
>> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>> Changes in v2:
>> - Use GATE_A and clk_get().  Save the clock for putting later.
>> - Return 0 from exynos5420_clk_late_init().
>>
>>  drivers/clk/samsung/clk-exynos5420.c | 33 +++++++++++++++++++++++++++++++--
>>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> Are there other changes you'd like me to make to this?  It would be
> really nice to get this in for 3.16 so the system doesn't just
> mysteriously hang when you use earlyprintk.

We can probably take this as an -rc fix, so it should be fine.

However I still don't see the point of exporting this clock and
polluting the global clkdev namespace. Even the diffstat looks better in v1.

Best regards,
Tomasz
