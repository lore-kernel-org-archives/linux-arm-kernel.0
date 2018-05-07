From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 08:37:44 -0500
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <20180505012513.GJ13402@sirena.org.uk>
References: <20180501213114.20183-1-robh@kernel.org>
 <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
 <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
 <74d495d8-04e2-fb7d-7d07-0905fbc8a6cf@arm.com>
 <20180505012513.GJ13402@sirena.org.uk>
Message-ID: <CAL_Jsq+WDrx6Jfoa5drutK-LaVE9xSfttFSGrsgNxPG60DmWJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2018 at 8:25 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, May 02, 2018 at 07:49:57PM +0100, Robin Murphy wrote:
>
>> I guess there's also the possibility that a single driver may want multiple
>> behaviours, if e.g. if SoC variants A and B have some identical peripherals
>> but slightly different pinctrl/IOMMU/etc. hardware such that A has workable
>> default behaviour and can be treated as optional, whereas B absolutely must
>> be controlled by the kernel for the consumers to function properly, and they
>> *should* defer forever otherwise. I think that would pretty much demand some
>> sort of explicitly-curated white/blacklist setup at the subsystem or driver
>> level.
>
> Different board variants, and possibly even different bootloaders might
> also be an issue here - a vendor bootloader might do pinmuxing that an
> upstream bootloader doesn't for example.  In some cases the pinmuxing
> even depends on the boot method with things only getting configured if
> the bootloader wanted to use them.

I think this is going to be too big of a hammer for pinctrl at least.
My current thought is to define a pinctrl DT property to indicate pins
are configured already which the OS can use to decide if pinctrl is
optional or not. I'd prefer to keep it simple and be a per pin
controller flag even though this is quite possibly a per client or pin
group state (as you say, the bootloader may only configure what it
uses). Making this per pin group could be a lot of nodes and difficult
to really get right without testing. Making it per pin controller
could make drivers fail in less predictable ways if their pins are not
configured.

Rob
