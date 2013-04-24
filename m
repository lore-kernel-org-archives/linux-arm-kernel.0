From: mikedunn@newsguy.com (Mike Dunn)
Date: Wed, 24 Apr 2013 09:07:17 -0700
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
Message-ID: <51780335.6030100@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

The patch you offered yesterday does not fix things on palmtreo, because there
are calls to gpio_request() in another file (palm27x.c) that are made from
init_machine().  I'd be grateful for any insight into how to resolve this.
Please see below...


On 04/20/2013 11:02 PM, Haojian Zhuang wrote:
> On 20 April 2013 23:26, Mike Dunn <mikedunn@newsguy.com> wrote:
>> Hi,
>>
>> After a few months of neglect, I rebased my palm treo 680 kernel with the latest
>> from Linus' official tree, and now all the calls to gpio lib functions
>> (gpio_request(), etc) made from the init_machine() method in struct machine_desc
>> fail.  I tracked this back to commit 6c7e660a27da7494c670bfba21cfeba30457656c
>> dated Jan 23 2013
>>
>>     gpio: pxa: set initcall level to module init
>>
>>     gpio & pinctrl driver are used together. The pinctrl driver is already
>>     launched before gpio driver in Makefile. So set gpio driver to module
>>     init level. Otherwise, the sequence will be inverted.
>>
>>     Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> At the time, Haojian addressed a question about this patch regarding module
>> dependencies, advising use of the deferred probe infrastructure.  But unless I'm
>> mistaken, mine is an initcall level problem, not a dependency issue among driver
>> probes.  Now that gpio-pxa initialization is at the device level (initcall6),
>> calls to gpiolib are no longer possible from init_machine(), which remains at
>> the initcall3 level.
>>
>> I feel like I must be missing something, because a lot of pxa boards call
>> gpiolib from init machine(), so my breakage should not be an isolated case.
>>
>> If I'm not missing anything and the patch is necessary, it looks like one
>> solution would be to move all the initializations that use gpiolib to the
>> init_late method in struct machine_desc, which runs as initcall7.
>>
>> Grateful for any advice!
>>
>> Thanks,
>> Mike
> 
> Actually gpio request should be handled in the driver, not machine platform
> driver. For example, lcd init may request gpio. pxafb.c provides the callback
> to handle it. We need to move code of requesting gpio into the callback.


It appears that some pxa27x drivers will need to be reworked to accomplish this.
 For example, in the case of the pxa27x lcd driver (pxafb), there are callbacks
for turning the lcd and its backlight on and off, but it seems that the gpios
should have already been requested when these run.  The board-specific gpios
*could* be passed to the pxafb driver via platform_data, and the driver could
request them in its probe function, but currently this is not done.

Moving gpiolib calls to init_late() in struct machine_desc, which runs as
initcall7, may also be a solution.


> 
> Since this change breaks current platform, we have to revert it. We still need
> a code cleanup in arch-pxa directory.


Indeed, if I'm not mistaken, at least these boards are now broken:
  - tosa
  - baloon3
  - gumstix
  - hx4700
  - magician
  - mioa701
  - palmtreo/palmcentro
  - palmld
  - palmtc
  - palmz72


> 
> Linus,
> Could you help to revert this commit? Or do I need to send a revert commit
> to you?
> 

Thanks,
Mike
