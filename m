From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Mar 2014 19:18:30 -0700
Subject: [PATCHv2 3/5] net: rfkill: gpio: remove gpio names
In-Reply-To: <CACRpkdZF4-rWs1WkOp3t0x77fgSCE71E=wdrxiDuGZ8eBu_p_Q@mail.gmail.com>
References: <1393330950-7283-1-git-send-email-heikki.krogerus@linux.intel.com>	<1393330950-7283-4-git-send-email-heikki.krogerus@linux.intel.com>	<530D218E.9010007@wwwdotorg.org>
 <CACRpkdZF4-rWs1WkOp3t0x77fgSCE71E=wdrxiDuGZ8eBu_p_Q@mail.gmail.com>
Message-ID: <53168976.7000008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 06:43 PM, Linus Walleij wrote:
> On Wed, Feb 26, 2014 at 7:04 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>>> -     gpio = devm_gpiod_get_index(&pdev->dev, rfkill->reset_name, 0);
>>> +     gpio = devm_gpiod_get_index(&pdev->dev, NULL, 0);
>>
>> I think the correct fix here is to look up the GPIO by name rather than
>> by index, but simply hard-code the name rather than generating it with
>> sprintf(). Index lookups are hard to expand compatibly, but named-based
>> lookups scale much better.
>>
>> In other words, I rather specifically disagree with using a plain
>> "gpios" property in any future DT binding, but would strongly prefer
>> e.g. reset-gpios/shutdown-gpios or gpios/gpio-names.
> 
> If I understand the situation correctly it's like ACPI does not have named
> GPIOs so keeping specifying this in DT GPIO bindings is counter-productive
> to the work of abstracting the access to GPIO handlers so that drivers
> need not know whether ACPI or DT is used for describing the hardware.

For devices that already have both ACPI and DT bindings, we can't
pretend they can be the same; they are already potentially different. We
simply need to parse DT and ACPI differently, since that's the sway
their bindings are defined.

For any devices that don't have both ACPI and DT bindings, I agree we
should certainly strive to make any new bindings aligned so we don't
have to deal with this for them.

However, we can't change the past.
