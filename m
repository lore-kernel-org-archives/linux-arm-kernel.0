From: gnurou@gmail.com (Alexandre Courbot)
Date: Tue, 21 Jul 2015 18:00:37 +0900
Subject: [PATCH 0/9] gpiolib: Add GPIO name support
In-Reply-To: <CACRpkdY=SLGyrcvWT355b3Z+pBwb9gPzVcieD8mOn=zdyJ1mFw@mail.gmail.com>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdY=SLGyrcvWT355b3Z+pBwb9gPzVcieD8mOn=zdyJ1mFw@mail.gmail.com>
Message-ID: <CAAVeFuL5F=Y2boCWp_TZEAN-kdT-Ob9r-h1-eNVDjBHftFYkeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 18, 2015 at 5:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jul 17, 2015 at 11:32 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
>> This is a proposal to add GPIO names to the kernel based on devicetree
>> descriptions.
>>
>> This series adds GPIO name support. Until now it is only possible to use names
>> for already requested GPIOs (for example what they are used for). It is not
>> possible to identify GPIOs by a name although most of them have a name for
>> example in the schematics of the board. This makes it difficult to identify
>> a specific GPIO from userspace.
>>
>> As the GPIO name information is a hardware description this series uses the
>> devicetree bindings introduced by the GPIO hogging mechanism, specifically
>> 'line-name', to identify GPIOs. The sysfs 'export' file is changed to accept
>> names as fallback. The gpio numbers still have a higher priority to ensure
>> backwards compatibility.
>>
>> Exported GPIOs are still using their number as directory name (gpio<ID>). But the
>> directories now contain a 'name' file which is '(null)' for non-existent names
>> and the name otherwise.
>>
>> This series can be used to have an easy name mapping for udev with a quite
>> simple rule similar to this:
>>         SUBSYSTEM=="gpio", KERNEL=="gpio*", ATTR{name}!="(null)", ACTION=="add", \
>>         PROGRAM+="/bin/sh -c 'mkdir -p /dev/gpios; rm -f /dev/gpios/$attr{name}; ln -s /sys%p/ /dev/gpios/$attr{name}"
>> With this rule udev adds a link for each exported GPIO with a name into
>> /dev/gpios/. This way it is not necessary to know the number of a GPIO to use
>> it.
>
> I must say I like this series.
>
> Because it makes the GPIO sysfs ABI *less* insane. Especially
> I like the patch that makes a distinction between "label" (use)
> and "name" (the name of the actual line). That illustrates clearly
> that this is thought-through.
>
> However I still have some doubts as it will expand the sysfs ABI,
> and we have discussed a char device for GPIO chips as a better
> alternative, for example since these can do get/set multiple GPIOs
> with a single context switch (ioctl), whereas sysfs is "one value per file"
> and would be able to expose some flags better.

Even if we introduce a new interface (and I don't see traction towards
this yet), sysfs is just too convenient for 90% of the cases to leave
it borderline-unusable as it is currently. The obligation to use
global numbers that potentially change every boot is getting us
complaints every week or so - this series sounds like a good way to
reduce our inbox volume, and if only for that, I encourage it being
pursued. :)

It will also not get in the way of a new user-space interface, so why
refrain from these extra ~90 lines of code?

Alex.
