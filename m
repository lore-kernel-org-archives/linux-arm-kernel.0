From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 19 Mar 2012 13:19:07 +0530
Subject: [PATCH v2 3/3] ARM: Samsung: Rework platform data of s3c-fb driver
In-Reply-To: <CAEYLNCo0zyH9Nsf59UU-J4m=km+mKH1ym5a-9s7WthFpos6D+w@mail.gmail.com>
References: <1331585999-8604-1-git-send-email-thomas.abraham@linaro.org>
 <1331585999-8604-4-git-send-email-thomas.abraham@linaro.org>
 <002f01cd00fe$5df84fa0$19e8eee0$%han@samsung.com>
 <CAJuYYwSUf-gsVesduMggSuues9OLOR6DUDAAMg_tL=e3=3c0tQ@mail.gmail.com>
 <000501cd0184$f088cb20$d19a6160$%han@samsung.com>
 <4F60E5C8.3040804@gmail.com>
 <001501cd0241$6bb53560$431fa020$%han@samsung.com>
 <CAEYLNCp5e=86rpRi2C-5OJptTyEeXAn8JHhbWw_BqGzSaDD9wQ@mail.gmail.com>
 <002a01cd0283$1f61b200$5e251600$%han@samsung.com>
 <CAEYLNCrprPE60ZS=_OWuck0JCJMhCxzVErZwuwGpEDYkQq-hXg@mail.gmail.com>
 <001d01cd0315$935cc720$ba165560$%han@samsung.com>
 <CAEYLNCrGCmb5EJjURLY=EGfM=4N54MirNkCCyQRxqKEN3Eka8Q@mail.gmail.com>
 <002d01cd034b$c56f2b00$504d8100$%han@samsung.com>
 <CAEYLNCpfQ0cYb4efw6PZNnKjQ2rF25rj5Ed=i884LJXHAwigBw@mail.gmail.com>
 <002f01cd0359$eb718330$c2548990$%han@samsung.com>
 <CAEYLNCpJU_5uVa-jo5HUNY8Av6eYaiow1gEZtHCiQZ5oKkGoMQ@mail.gmail.com>
 <001501cd0561$57c642b0$0752c810$%han@samsung.com>
 <CAJuYYwQmJvx_uGZKbAJ9uds-ciLs2VDqcifhoqB-P0M5uhO-nA@mail.gmail.com>
 <CAEYLNCo0zyH9Nsf59UU-J4m=km+mKH1ym5a-9s7WthFpos6D+w@mail.gmail.com>
Message-ID: <CAJuYYwQY6C-+NUuYfmDyGoh0ahVa8_x1cai8MCfN_JjWh1k1Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 March 2012 13:10, Darius Augulis <augulis.darius@gmail.com> wrote:
> Hi,
>
> On Mon, Mar 19, 2012 at 9:29 AM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>> Hi Darius,
>>
>> On 19 March 2012 05:16, Jingoo Han <jg1.han@samsung.com> wrote:
>> [...]
>>
>>>
>>> Because there are not multiple windows and driver sees only single window as you mentiond,
>>> Only 'struct s3c_fb_pd_win mini6410_fb_win[0]' should be used and
>>> 'struct s3c_fb_pd_win mini6410_fb_win[1]' should not be used.
>>> s3c_fb_pd_win[0] means window 0 of FIMD IP, s3c_fb_pd_win[1] means window 1 of FIMD IP.
>>>
>>> Therefore, if mini6410_fb_win[0] and mini6410_fb_win[1] are included, it means that
>>> 2 windows of FIMD IP are used in single LCD.
>>>
>>> If you want to support multiple LCDs, you should use struct s3c_fb_platdata[0], struct s3c_fb_platdata[1],
>>> because 'struct s3c_fb_platdata' means LCD panel.
>>>
>>> If you understand the purpose of s3c_fb_platdata and s3c_fb_pd_win, you should do, at least, as below.
>>>
>>> static struct s3c_fb_pd_win mini6410_fb_lcd0_win[] = {
>>> ? ? ? ?{
>>> ? ? ? ? ? ? ? ?.win_mode ? ? ? = { ? ? /* 4.3" 480x272 */
>>> ? ? ? ? ? ? ? ? ? ? ? ?.left_margin ? ?= 3,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.right_margin ? = 2,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.upper_margin ? = 1,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.lower_margin ? = 1,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.hsync_len ? ? ?= 40,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.vsync_len ? ? ?= 1,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.xres ? ? ? ? ? = 480,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.yres ? ? ? ? ? = 272,
>>> ? ? ? ? ? ? ? ?},
>>> ? ? ? ? ? ? ? ?.max_bpp ? ? ? ?= 32,
>>> ? ? ? ? ? ? ? ?.default_bpp ? ?= 16,
>>> ? ? ? ?},
>>> };
>>>
>>> static struct s3c_fb_platdata mini6410_lcd_pdata[0] __initdata = {
>>> ? ? ? ?.setup_gpio ? ? = s3c64xx_fb_gpio_setup_24bpp,
>>> ? ? ? ?.win[0] ? ? ? ? = &mini6410_fb_lcd0_win[0],
>>> ? ? ? ?.vidcon0 ? ? ? ?= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
>>> ? ? ? ?.vidcon1 ? ? ? ?= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>>> };
>>>
>>> static struct s3c_fb_pd_win mini6410_fb_lcd1_win[] = {
>>> ? ? ? ?{
>>> ? ? ? ? ? ? ? ?.win_mode ? ? ? = { ? ? /* 7.0" 800x480 */
>>> ? ? ? ? ? ? ? ? ? ? ? ?.left_margin ? ?= 8,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.right_margin ? = 13,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.upper_margin ? = 7,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.lower_margin ? = 5,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.hsync_len ? ? ?= 3,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.vsync_len ? ? ?= 1,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.xres ? ? ? ? ? = 800,
>>> ? ? ? ? ? ? ? ? ? ? ? ?.yres ? ? ? ? ? = 480,
>>> ? ? ? ? ? ? ? ?},
>>> ? ? ? ? ? ? ? ?.max_bpp ? ? ? ?= 32,
>>> ? ? ? ? ? ? ? ?.default_bpp ? ?= 16,
>>> ? ? ? ?},
>>> };
>>>
>>> static struct s3c_fb_platdata mini6410_lcd_pdata[1] __initdata = {
>>> ? ? ? ?.setup_gpio ? ? = s3c64xx_fb_gpio_setup_24bpp,
>>> ? ? ? ?.win[0] ? ? ? ? = &mini6410_fb_lcd1_win[0],
>>> ? ? ? ?.vidcon0 ? ? ? ?= VIDCON0_VIDOUT_RGB | VIDCON0_PNRMODE_RGB,
>>> ? ? ? ?.vidcon1 ? ? ? ?= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
>>> };
>>>
>>> Each struct means:
>>> ?mini6410_lcd_pdata[0]: 4.3" 480x272 LCD
>>> ?mini6410_fb_lcd0_win[0]: window 0 used for 4.3" 480x272 LCD
>>>
>>> ?mini6410_lcd_pdata[1]: 7.0" 800x480 LCD
>>> ?mini6410_fb_lcd1_win[0]: window 0 used for 7.0" 800x480 LCD
>>>
>>> In this case, 4.3" or 7.0" LCD can be selected using mini6410_lcd_pdata[], instead of selecting mini6410_fb_win[0] or
>>> mini6410_fb_win[1].
>>>
>>> My point is that 's3c_fb_platdata and s3c_fb_pd_win should be used exactly'.
>>
>> I agree with solution which Jingoo Han has proposed. Instead of
>> selecting one instance of s3c_fb_pd_win over the other at runtime, the
>> features->lcd_index can be used to select one of the instances of
>> platform data for s3c-fb driver.
>
> I agree with it too. Would you make such patch based on your s3c-fb patch set?
> Somebody should make it and definitely not to remove multiple LCD
> suport for these boards.

Sure. I will make a patch for that. I did not notice the way two lcd's
were supported in your code while preparing this patchset. Thanks for
bringing up this point.

>
>>
>> s3c_fb_pd_win is used to describe a window supported by the fimd
>> controller. It is not meant to carry lcd timing information. The lcd
>> panel timing remains the same irrespective of the window sizes. And
>> this patchset is a step towards untangling window information and
>> video timing.
>
> Right now s3c_fb_pd_win contains exactly LCD timing values.
> Your patch will move these timing values to struct fb_videomode.
>
> I could make necessary patch for that too, but I think you will spend
> less time doing it by yourself than syncing with me.
> What do you think?

Yes, I will prepare an additional patch in this series that will
maintain backward compatibility for real6410 and mini6410 with the
approach suggested by Jingoo Han. As I do not have either of these
boards, an ack from you would be very helpful when the next version of
this patchset is posted.

Thanks,
Thomas.
