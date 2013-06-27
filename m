From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 27 Jun 2013 19:04:41 +0300
Subject: [RFC] ARM: OMAP2+: omap_device: add pinctrl handling
In-Reply-To: <20130627144535.GK5523@atomide.com>
References: <1371826990-25820-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdY=m1b9Lh27+wHP8FQ4SbVZKmAOCGhxe59aP+TcuR9QaA@mail.gmail.com>
 <20130625065811.GZ5523@atomide.com> <51CAEA90.90200@ti.com>
 <CACRpkdbKgEcfF67oO9HrczvDp4Po3Xt1hFajJ1vO8kEvsZH4jA@mail.gmail.com>
 <51CC45D3.2000305@ti.com> <20130627144535.GK5523@atomide.com>
Message-ID: <51CC6299.2070203@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/27/2013 05:45 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [130627 07:12]:
>>
>> As you can see, from 12 pins only 3 pins need to be reconfigured
>> while switching from "active"->"idle" states and back (and as I
>> mentioned above for OMAP "idle" == "sleep" now).
>>
>> Regarding "OFF" state:
>> OMAP mux HW defines special state for unused pins which is selected
>> by default after reset and need to be selected when device isn't
>> used, for example:
>> _MUXMODE - Functional multiplexing selection for pad
>> 0x0: Select usbb1_hsic_data
>> 0x3: Select gpio_96
>> 0x7: Select safe_mode <<--- pin unused
>
> The off mode bits can be enabled continuously, the mux hardware
> automatically sets them. So sounds like you don't need any
> separate "idle" "sleep" and "off" states, the following should
> do:
>
> "default" (or "static")	static pins that don't need to be touched
> 			after consumer driver probe
>
> "active"		dynamic pins that are not a subset of
> 			"default" needed for runtime; these pins
> 			are the same as "idle" below, but with
> 			different muxing or pinconf device
> 			runtime
>
> "idle"			dynamic pins that are not a subset of
> 			"default" needed for various idle modes;
> 			these pins are the same as "active" above,
> 			but with different muxing or pinconf for
> 			various idle states
>
> Can you please confirm that these named modes are enough for
> your needs?
  Confirm )
>
> If your hardware does not have specific off mode bits, then
> I can understand that you may need one mor state "off".
>
> Regards,
>
> Tony
>

Regards,
-grygorii
