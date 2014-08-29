From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 08:53:15 +0200
Subject: [PATCH] ARM: tegra: remove pinmux setup from Tegra124 boards
In-Reply-To: <53F22B10.1010106@wwwdotorg.org>
References: <1403563506-6461-1-git-send-email-swarren@wwwdotorg.org>
 <1407921548.5835.20.camel@weser.hi.pengutronix.de>
 <53F22B10.1010106@wwwdotorg.org>
Message-ID: <CACRpkdbJai_40OOKPMFT9RaDs5o2ZQCG48fFA4EUFbParqQKaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 6:34 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/13/2014 03:19 AM, Lucas Stach wrote:
>>
>> Hi Stephen,
>>
>> sorry for getting on this late, I completely missed this and only now
>> stumbled upon this.
>>
>> I'm not really fond of this change. The barebox bootloader completely
>> probes itself from DT, including the pinmux. We try to stay as close as
>> possible to the upstream kernel DTs and only introduce minimal changes.
>> Removing the pinmux from the DTS will completely break barebox, as we
>> don't have any static pinmux tables there.
>>
>> In order to not break the bootloader use-case I strongly advocate to
>> keep the static pinmux in the DT. Can't we just rename the the state to
>> something like "initial", so Linux won't try to set it by default? This
>> way we could still keep the information in the DT, while being able to
>> say "if you are going to program the initial pinmux state you need to
>> follow the sequence defined by NVIDIA syseng".
>>
>> This obviously would make the naming of the state part of the binding,
>> but I think this may be acceptable.
>
>
> Linus, what do you think of Lucas's proposal?

I guess we say the DTs should be neutral to OS, whether they should
be neutral to the use case for boot loaders is another question, but
I think the more info is in the DT, the better actually as it avoids spreading
relevant information across places where it's hard-coded.

> As background, the Tegra HW design implies that all initial pinmux setup
> should be applied one time early during boot before peripherals are used.
> That means it should happen early in boot code, not once an OS like Linux
> has been loaded, since loading the OS requires use of at least some
> peripheral(s). Hence, there's no point the kernel re-applying the same
> configuration.
>
> I had suggested (in this patch) removing the pinmux completely from the DT,
> since no OS should need it. However, the Barebox bootloader is configured
> via DT, and so wants to keep the pinmux configuration in the DT, rather than
> embedding the pinmux tables into the bootloader's board support code. Lucas
> has suggested simply changing the pinmux state name in the DT so that the
> kernel won't apply the pinmux configuration yet it's still there for the
> bootloader to use if it wants.
>
> I'd suggest "boot" rather than "initial" myself for the new state name, but
> that's just bike-shedding.

I'm game for "boot".

Yours,
Linus Walleij
