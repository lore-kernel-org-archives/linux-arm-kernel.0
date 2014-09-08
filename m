From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 08 Sep 2014 16:05:40 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140908134937.GK4015@sirena.org.uk>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <20140908134937.GK4015@sirena.org.uk>
Message-ID: <540DB7B4.4060300@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Will,

On 09/08/2014 03:49 PM, Mark Brown wrote:
> On Mon, Sep 08, 2014 at 01:20:11PM +0100, Grant Likely wrote:
>> On Mon, Sep 8, 2014 at 12:21 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
>> > Whilst I'm sympathetic to people working to enable DRM, I think this is
>> > the right solution to the problem. The transition from simplefb to DRM
>> > shouldn't break display for a bunch of kernel revisions whilst the code is
>> > in flux.
> 
>> I would go further. The kernel behaviour has changed, and we have to
>> deal with platforms that assume the old behaviour. That means either
>> defaulting to leaving enabled regulators/clocks alone unless there is
>> a flag in the DT saying they can be power managed, or black listing
>> platforms that are known to depend on the regulator being on.
> 
> For regulators there is essentially a flag in DT already - the
> regulators should not be described in DT if the OS isn't supposed to be
> managing them.
> 
>> Updating the device tree must not be required to get the kernel to
>> boot, but it is valid to require a DT upgrade to get better
>> performance (battery life) out of the platform.
> 
> This has got to be a blacklist then, and it seems like we've got to fix
> simplefb to actually support managing the resources it's using.  The
> current plan does not seem at all sensible - we're talking about adding
> hacks in every subsystem that provides resources and bodging DTs in
> order to work around simplefb.
> 

Since many folks don't agree that hacking different subsystems is the way
forward I'll hold the patches and don't post them. The sunxi thread [0]
already shows how different people have strong opposite positions on the
correct approach to handle this.

For now you can just disable the tps65090 PMIC support by not enabling the
CONFIG_REGULATOR_TPS65090 kconfig symbol on your kernel config. That will give
you exactly the same behavior that before tps65090 support was added to the
Snow DT on commit b16be76 ("ARM: dts: add tps65090 power regulator for
exynos5250-snow") which AFAIU was good enough for your workflow.

Best regards,
Javier

[0]: https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06623.html
