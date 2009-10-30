From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Fri, 30 Oct 2009 02:40:32 +0100
Subject: S3C6410 board (SmartQ 7) USB host issues
In-Reply-To: <20091030003601.GF8096@trinity.fluff.org>
References: <4AEA3240.10105@gmail.com>
	<20091030003601.GF8096@trinity.fluff.org>
Message-ID: <4AEA4410.7060207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 30-10-09 01:36, Ben Dooks schreef:
> On Fri, Oct 30, 2009 at 01:24:32AM +0100, Maurus Cuelenaere wrote:
>    
>> Hi,
>>
>> I'm working on getting mainline Linux working on the SmartQ 7, a Samsung
>> S3C6410 board.
>>
>> I'm having issues getting USB host to work, when I try to attach a
>> device (Logitech mouse in this case) to it I get "device descriptor
>> read/64, error -62" errors. Then it gets a new address assigned and gets
>> back to the same error (this loops around 4 times, then Linux seems to
>> give up).
>>      
> That could be due to a number of things, such as:
>
> 1) Unstable clock (need to verify the clock below is happening)
> 2) Interface problems - does the board have the correct pull ups
> 3) Does the interface have power control that needs to be set?
>    

It does, but I'm already enabling that.

>> This board doesn't have a separate 48M clock source, so I'm currently
>> changing the USB host clock source to EPLL in my board config like this:
>>      
> What is the current EPLL rate?
>
>    
>> struct clk * usb_clock, * mout_epll;
>>
>> usb_clock = clk_get(NULL, "usb-bus-host");
>> if(usb_clock == NULL) {
>>      pr_err("%s: failed to get usb-bus-host clock\n", __func__);
>>      return -ENXIO;
>> }
>> mout_epll = clk_get(NULL, "mout_epll");
>> if(mout_epll == NULL) {
>>      pr_err("%s: failed to get mout_epll clock\n", __func__);
>>      clk_put(usb_clock);
>>      return -ENXIO;
>> }
>>
>> /* setup clock */
>> clk_set_parent(usb_clock, mout_epll);
>> clk_set_rate(usb_clock, 48000000);
>>      
> does clk_get_rate() here show 48MHz, or something 'close' ?
>
> currently we do not have support for setting the EPLL, so you
> may be getting a best-effort value from the divider chain.
>    

Looks like EPLL runs at 24Mhz, so I probably need to look into modifying 
my bootloader to run it higher (the original firmware seems to run it at 
192Mhz).

Also what's the preferred way of setting the USB host clock source: 
doing this in the bootloader or in the Linux mach file?

Regards,
Maurus Cuelenaere
