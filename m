From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Jan 2012 10:44:26 +0530
Subject: [PATCH] video: s3c-fb: Add device tree support
In-Reply-To: <4F10A267.2020608@gmail.com>
References: <1326139307-25112-1-git-send-email-thomas.abraham@linaro.org>
 <4F109C04.5090600@gmail.com> <4F10A267.2020608@gmail.com>
Message-ID: <CAJuYYwSt7KM0_DiChsDmy9aD9s6Q48FqcM6gD1otXBYfk67m+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 14 January 2012 03:00, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> On 01/13/2012 10:03 PM, Sylwester Nawrocki wrote:
>> On 01/09/2012 09:01 PM, Thomas Abraham wrote:
>>>
>>> + ? ?for (idx = 0; idx< ? nr_gpios; idx++) {
>>> + ? ? ? ? ? ?gpio = of_get_gpio(dev->of_node, idx);
>>> + ? ? ? ? ? ?if (!gpio_is_valid(gpio)) {
>>> + ? ? ? ? ? ? ? ? ? ?dev_err(dev, "invalid gpio[%d]: %d\n", idx, gpio);
>>> + ? ? ? ? ? ? ? ? ? ?return -EINVAL;
>>> + ? ? ? ? ? ?}
>>> +
>>> + ? ? ? ? ? ?if (!request)
>>> + ? ? ? ? ? ? ? ? ? ?continue;
>>> +
>>> + ? ? ? ? ? ?ret = gpio_request(gpio, "fimd");
>>
>> Is it how it normally is supposed to be done, i.e. configuring a gpio
>> _before_ it has been requested ? of_get_gpio() indirectly touches the
>> gpio controller and gpio_request() doesn't seem to serve its purpose
>> in this case, i.e. if there is situation like:
>>
>> driver A ? ? ? ? ? ? ? ? ? ? ? ?driver B
>>
>> of_get_gpio(nodeA, gpioA);
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?of_get_gpio(nodeB, gpioA);
>> gpio_request(gpioA);
>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?gpio_request(gpioB);
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? s/B/A
>>
>> driver B will end up with configuration of gpioA from nodeA, not from
>> nodeB.
>
> ugh, I put it wrong, it should instead read:
>
> "driver A will end up with configuration of gpioA from nodeB, not from
> nodeA."
>
>> As there are few drivers doing that I must be missing something,
>> not sure what..
>> I realize the GPIO number needs to be known in order for a GPIO to be
>> requested. Shouldn't of_get_gpio() be extended to allow locking gpio
>> controller's module and marking a GPIO as requested in advance ?
>>
>>> + ? ? ? ? ? ?if (ret) {
>>> + ? ? ? ? ? ? ? ? ? ?dev_err(dev, "gpio [%d] request failed\n", gpio);
>>> + ? ? ? ? ? ? ? ? ? ?goto gpio_free;
>>> + ? ? ? ? ? ?}
>>> + ? ? ? ? ? ?sfb->gpios[idx] = gpio;
>>> + ? ?}
>>> + ? ?return 0;
>>> +
>>> +gpio_free:
>>> + ? ?while (--idx>= 0)
>>> + ? ? ? ? ? ?gpio_free(sfb->gpios[idx]);
>>> + ? ?return ret;
>>> +}
>>> +
>>> +static void s3c_fb_dt_free_gpios(struct s3c_fb *sfb)
>>> +{
>>> + ? ?unsigned int idx, nr_gpio;
>>> +
>>> + ? ?nr_gpio = sfb->pdata->win[0]->max_bpp + 4;
>>> + ? ?for (idx = 0; idx< ? nr_gpio; idx++)
>>> + ? ? ? ? ? ?gpio_free(sfb->gpios[idx]);
>>> +}
>

Yes, I agree that there is a problem here. DT bindings for
pinmux/pinconfig would solve this. But the sequence of of_get_gpio()
and gpio_request() in the above code will stay even when using the dt
bindings for pinmux/pinconfig. There will be only incremental changes
required to adapt to dt bindings for pinmux/pinconfig.

Thanks,
Thomas.
