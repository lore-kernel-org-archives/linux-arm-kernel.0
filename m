From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 20:37:04 -0600
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <20121007225417.GA29996@glitch>
References: <20121007015300.828366635@gmail.com>
 <20121007015405.958959522@gmail.com>
 <20121007195759.GG12801@game.jcrosoft.org> <20121007225417.GA29996@glitch>
Message-ID: <50738DD0.5090406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/07/2012 04:54 PM, Domenico Andreoli wrote:
> On Sun, Oct 07, 2012 at 09:57:59PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 03:53 Sun 07 Oct     , Domenico Andreoli wrote:
>>> From: Domenico Andreoli <domenico.andreoli@linux.com>
>>>
>>> BCM476x's minimal infrastructure, Kernel's great reuse.
>>>
>>> Look mom, no include/mach directory!

(sigh, Jean-Christophe, it's a really good idea when replying to patches
to delete everything except what you're replying to so that others can
actually find what they wrote in the email...)

>>> Index: b/arch/arm/boot/dts/bcm476x.dtsi

>>> +		vic0: interrupt-controller at 80000 {
>>> +			compatible = "brcm,bcm476x-pl192", "arm,pl192-vic", "arm,primecell";
>> why brcm specific compatbile?
> 
> Nothing breaks if I drop it. I think it's a future-proof clause, especially
> if you consider that the devicetree could be not easy to upgrade and you
> may need a way to differentiate the bcm476x's implementation from the
> common one. I'm not sure it's an actual requirement with use cases.

Indeed, everything works fine right now if you drop that. However, it is
correct practice to include a compatible value for the particular SoC
that incorporates the IP so that if in the future some SoC-specific
workaround is required, the compatible value needed to trigger this is
already in all historical .dts file.

>>> Index: b/arch/arm/include/debug/bcm476x.S

>>> +#if defined(CONFIG_DEBUG_BCM476X_UART0)
>>> +# define BCM476X_DEBUG_PHYS	0x000c0000
>>> +# define BCM476X_DEBUG_VIRT	0xd00c0000
>>> +#elif defined(CONFIG_DEBUG_BCM476X_UART1)
>>> +# define BCM476X_DEBUG_PHYS	0x000c1000
>>> +# define BCM476X_DEBUG_VIRT	0xd00c1000
>>> +#elif defined(CONFIG_DEBUG_BCM476X_UART2)
>>> +# define BCM476X_DEBUG_PHYS	0x000b2000
>>> +# define BCM476X_DEBUG_VIRT	0xd00b2000
>>> +#else
>>> +# error Unknown BCM476x debug port
>>> +#endif
>>
>> can't you detect it?
> 
> If I can assume that the boot loader will configure and enable only the
> console port, I could use the first one in such state.
> 
> Where could I place such detection, in the maco addruart itself?

Auto-detection is not necessarily a good idea; there's no reason in
general to believe that no future board will ever use a UART for any
purposes other than console/debug. Being explicit is probably good.
