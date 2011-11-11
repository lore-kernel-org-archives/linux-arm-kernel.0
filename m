From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 10:13:26 -0600
Subject: [PATCH] mach-ux500: add devicetree compat nodes
In-Reply-To: <CACRpkda-9OVP8E1qO3Nc5znw_v7cKFiv8T5HHwTCnY2C9Fg7iA@mail.gmail.com>
References: <1321023902-18870-1-git-send-email-niklas.hernaeus@linaro.org>
 <4EBD3C85.1010508@gmail.com>
 <CACRpkda-9OVP8E1qO3Nc5znw_v7cKFiv8T5HHwTCnY2C9Fg7iA@mail.gmail.com>
Message-ID: <4EBD49A6.2020306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 09:59 AM, Linus Walleij wrote:
> On Fri, Nov 11, 2011 at 4:17 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
>>>  MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>>>       /* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
>>>       .boot_params    = 0x100,
>>> @@ -651,6 +666,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>>>       /* we re-use nomadik timer here */
>>>       .timer          = &ux500_timer,
>>>       .init_machine   = mop500_init_machine,
>>> +     .dt_compat      = mop500_dt_board_compat,
>>>  MACHINE_END
>>>
>>>  MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
>>> @@ -659,6 +675,7 @@ MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
>>>       .init_irq       = ux500_init_irq,
>>>       .timer          = &ux500_timer,
>>>       .init_machine   = mop500_init_machine,
>>> +     .dt_compat      = hrefv60_dt_board_compat,
>>>  MACHINE_END
>>>
>>>  MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
>>> @@ -668,4 +685,5 @@ MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
>>>       /* we re-use nomadik timer here */
>>>       .timer          = &ux500_timer,
>>>       .init_machine   = mop500_init_machine,
>>> +     .dt_compat      = snowball_dt_board_compat,
>>>  MACHINE_END
>>
>> These all look very similar and should be combined. Why do you not have
>> 1 machine for all DT platforms as other SOCs are doing?
> 
> This needs to be rebased for the latest kernel.
> Which looks like this:
> 
> MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
>         /* Maintainer: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com> */
>         .atag_offset    = 0x100,
>         .map_io         = u8500_map_io,
>         .init_irq       = ux500_init_irq,
>         /* we re-use nomadik timer here */
>         .timer          = &ux500_timer,
>         .init_machine   = mop500_init_machine,
> MACHINE_END
> 
> MACHINE_START(HREFV60, "ST-Ericsson U8500 Platform HREFv60+")
>         .atag_offset    = 0x100,
>         .map_io         = u8500_map_io,
>         .init_irq       = ux500_init_irq,
>         .timer          = &ux500_timer,
>         .init_machine   = hrefv60_init_machine,
> MACHINE_END
> 
> MACHINE_START(SNOWBALL, "Calao Systems Snowball platform")
>         .atag_offset    = 0x100,
>         .map_io         = u8500_map_io,
>         .init_irq       = ux500_init_irq,
>         /* we re-use nomadik timer here */
>         .timer          = &ux500_timer,
>         .init_machine   = snowball_init_machine,
> MACHINE_END
> 
> So - different .init_machine() calls, needed to simplify the board
> files as of now. (Patch from Lee Jones.)
> 

But ultimately I would expect that the init_machine calls to be the same
with a DT based machine. This goes back to do we add DT to existing
boards or create a new clean DT machine and add to it as boards are
converted?

Rob
