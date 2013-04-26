From: mikedunn@newsguy.com (Mike Dunn)
Date: Fri, 26 Apr 2013 05:38:57 -0700
Subject: gpio-pxa initcall level change and machine init breakage
In-Reply-To: <87ppxiz9l5.fsf@free.fr>
References: <5172B398.7060706@newsguy.com>
 <CAD6h2NSRA9w7GZLQGgK-+TvEAsxwOHow5_26JyVUA6YQyj3OQg@mail.gmail.com>
 <517466F6.3000003@newsguy.com>
 <CAD6h2NSy0=3P-PHdCiJJQG_jvGaFnr7uex+Uxs=0F-VsUxtPWg@mail.gmail.com>
 <CACRpkdbk24kR75fanvXVAocnuozNq_=jWDSPHPCWhbZCOrN5_Q@mail.gmail.com>
 <5176E438.80800@newsguy.com>
 <CACRpkdYLCKKZZFi6Y-viPUvrwupJGzfxr3f20a1emp-9qE0YBg@mail.gmail.com>
 <87ppxiz9l5.fsf@free.fr>
Message-ID: <517A7561.1080606@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2013 12:36 PM, Robert Jarzmik wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
> 
>> On Tue, Apr 23, 2013 at 9:42 PM, Mike Dunn <mikedunn@newsguy.com> wrote:
>>
>>> On a more general note... I'm surprised that gpiolib can not run earlier, for
>>> something so low-level.
>>
>> Well I think the patch we're discussing is making it run less early, and it
>> can actually run as arch_initcall() or similar if you wish (it's up to the
>> driver).
>>
>> However that is beside the point, Haojian is still doing the right thing
>> trying to push this to driver init (==module_init) level. The reason is
>> that basically all hardware drivers should be initialized at this level
>> because the other init levels are basically for other things and driver
>> deps are just shoehorned into them.
>>
>> Instead of relying on things to be set up early one shall rely on
>> deferred probe.
> Hi Linus,
> 
> Even if that is the long term goal, and I agree with that goal, let me quote
> Documentation/gpio.txt : "However, for spinlock-safe GPIOs it's OK to use them
> before tasking is enabled, as part of early board setup.".
> 
> When gpio abstraction was written, it was assumed GPIO usage was usable in early
> platform setup code. As this was granted, we (board maintainers) coded
> accordingly.
> 
> Now this patch breaks boards. I disagree in having my board code broken without
> notice. What I would find less intrusive would be to :
>  (a) revert the patch
>  (b) inform board maintainers that they must fix their board code (for example
>  give them 1 window)
>  (c) put back the patch. Board maintainers who did not amend their board
>  code cannot say anymore they didn't know it. Board maintainers will also have
>  time to rise objections if they think they cannot change their board code
>  (which I do not believe is possible, but who knows ...)


Yes, thank you Robert.  More than a few boards were broken.  Old architectures
get no respect ;)

Some drivers may need rework, not just board support code.  For the pxa27x lcd
driver (pxafb), I am thinking that the board will have to pass a callback
function to the driver by way of platform_data, which the driver will call from
its probe function.  Advice gratefully received!


> Ah and change the Documentation too I think, if you want GPIO to be only usable
> from device initcall level.


As Linus mentioned, it depends on the driver.  There is no standard initcall
level for them.  Do 'grep initcall drivers/gpio/*.c' and you'll see the variety.
 This is a problem with the gpio abstraction that should be addressed, at least
in the documentation.  I wouldn't mind helping, but I'm pretty clueless at this
point.

Thanks,
Mike
