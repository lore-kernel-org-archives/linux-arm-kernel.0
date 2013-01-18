From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Jan 2013 16:05:27 +0100
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <50EF27B4.60608@wwwdotorg.org>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org>
Message-ID: <CACRpkdYK9r9XvQ7t+WOpDOi+RnFb9DGJiFNx5VFGkuuJf=VmgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 9:42 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

>> +     /* Allocate a pin state container on-the-fly */
>> +     if (!dev->pins) {
>> +             dpi = devm_kzalloc(dev, sizeof(*dpi), GFP_KERNEL);
>
> This is allocated using a devm_ function. If -EPROBE_DEFER is returned
> below after the assignment to dev->pins or if the driver's own probe()
> returns -EPROBE_DEFER, this allocation will be freed by the driver core.
> This can leave dev->pins pointing to something non-NULL, yet invalid.

OK I (think I) fixed it like this:

For the second deferral, set dev->pins to NULL.

I did some other fixes here to explicitly devm_kfree() the container
if no pinctrl handle was found. No point in keeping it around.

>> +     if (!dpi->p) {
>> +             dpi->p = devm_pinctrl_get(dev);
>
> That won't succeed for a pinctrl device that has a default state in
> order to implement hogs. This will then cause the pin controller device
> to always defer probe and never activate. This will leave HW
> unconfigured and/or prevent other devices from successfully calling
> pinctrl_get().

Fixed by your suggested patch, thanks.

>> +     /*
>> +      * See if somebody else (such as the device core) has already
>> +      * obtained a handle to the pinctrl for this device. In that case,
>> +      * return another pointer to it.
>> +      */
>>       p = find_pinctrl(dev);
>> -     if (p != NULL)
>> -             return ERR_PTR(-EBUSY);
>
> I deliberately returned an error here, because there's no reference
> counting on the struct pinctrl objects. If a driver calls pinctrl_get(),
> with the new code below, it will retrieve the same struct. If it later
> calls pinctrl_put(), the put will immediately free the structure. This
> will invalidate the pointers that reference it in struct device's pins
> field.
>
> This issue will probably trigger on Tegra, since we at least have a
> pinctrl-based I2C mux that calls pinctrl_get().

OK I just introduced a reference counter using <linux/kref.h>.

I've retested on U300 and U8500.

Yours,
Linus Walleij
