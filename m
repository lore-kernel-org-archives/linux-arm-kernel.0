From: sf84@laposte.net (Sebastian Frias)
Date: Tue, 6 Dec 2016 14:42:21 +0100
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <CAD=FV=WyoTQudydKXnA-8DKvywXXoEOJyV8Vvt5GOBgKXEN+vg@mail.gmail.com>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <CAD=FV=UhVtQQ1PPtLrvra20ja1k9GKs9hyFcrjBUYmyUmQK45Q@mail.gmail.com>
 <9d63ea01-a5d1-603d-1ad4-6c6320022de8@laposte.net>
 <CAD=FV=WyoTQudydKXnA-8DKvywXXoEOJyV8Vvt5GOBgKXEN+vg@mail.gmail.com>
Message-ID: <d981cdd0-856c-7c7c-57ee-a8b38e0673df@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/12/16 17:30, Doug Anderson wrote:
<snip>
> 
> AKA: you are setting up various "corecfg" stuff that's documented in
> the generic Arasan docs.  Others SDHCI-Arasan implementations might
> want to set the same things, but those values may be stored elsewhere
> for them.

Exactly, that is what I'm trying to find out.
To me, one good place to store this would be DT.

> 
> So if _all_ Arasan implementations need these same values or need the
> same logic to figure out these values, then you should do something
> that's not chip-specific but something generic.
> 

It depends on where this needs to be set, and why am I the first to need
to set this up.

> If you've got a specific weird quirk that's specific to your platform,
> then you could do that in a chip-specific init.

Yes, or in the set_ios you talked earlier.

> 
> Presumably many of the above could just be hardcoded on some
> implementations, so they might not be available in a memory-mapped
> implementation...
> 

Exactly.

> 
>> which seems much easier to handle (and portable).
>>
>> At any rate, one thing to note from this is that many of these
>> bits should probably be initialised based on DT, right?
> 
> Probably, or by proving the voltage value of regulations.  Note that I
> think DT already gets parsed and sets up caps.  I'm not really an
> expert here and I'd let someone who actually knows / maintains SDMMC
> comment.  I know for sure that dw_mmc (which I'm way more familiar
> with) does things very differently than sdhci (which I'm barely
> familiar with).

Thanks.
Could somebody else comment please?

Best regards,

Sebastian

> 
> 
>> For example, the DT has a "non-removable" property, which I think
>> should be used to setup SLOT_TYPE_EMBEDDED (if the property is
>> present) or SLOT_TYPE_REMOVABLE (if the property is not present)
>>
>> Looking at Documentation/devicetree/bindings/mmc/mmc.txt we can see
>> more related properties:
>>
>> Optional properties:
>> - bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
>>   will be <1> if the property is absent.
>> - wp-gpios: Specify GPIOs for write protection, see gpio binding
>> - cd-inverted: when present, polarity on the CD line is inverted. See the note
>>   below for the case, when a GPIO is used for the CD line
>> - wp-inverted: when present, polarity on the WP line is inverted. See the note
>>   below for the case, when a GPIO is used for the WP line
>> - disable-wp: When set no physical WP line is present. This property should
>>   only be specified when the controller has a dedicated write-protect
>>   detection logic. If a GPIO is always used for the write-protect detection
>>   logic it is sufficient to not specify wp-gpios property in the absence of a WP
>>   line.
>> - max-frequency: maximum operating clock frequency
>> - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>>   this system, even if the controller claims it is.
>> - cap-sd-highspeed: SD high-speed timing is supported
>> - cap-mmc-highspeed: MMC high-speed timing is supported
>> - sd-uhs-sdr12: SD UHS SDR12 speed is supported
>> - sd-uhs-sdr25: SD UHS SDR25 speed is supported
>> - sd-uhs-sdr50: SD UHS SDR50 speed is supported
>> - sd-uhs-sdr104: SD UHS SDR104 speed is supported
>> - sd-uhs-ddr50: SD UHS DDR50 speed is supported
>> ...
>>
>> which makes me wonder, what is the recommended way of dealing with this?
>> - Should I use properties on the DT? If so, then I need to add code to set
>> up the register properly.
>> - Should I hardcode these values use a minimal DT? If so, then I need an
>> init function to put all this.
>> - Should I hardcode stuff at u-Boot level? If so, nothing is required and
>> should work without any modifications to the Arasan Linux driver.
>>
>> It appears that the Linux driver is expecting most of these fields to be
>> hardcoded and "pre-set" before (maybe by the bootloader) it starts, hence
>> the lack of any "init" function so far.
>>
>>>
>>> In your platform-specific init you're proposing you could set
>>> tango_pad_mode to 0.  That seems tango-specific.
>>>
>>> You'd want to hook into "set_ios" for setting sel_sdio or not.  That's
>>> important if anyone ever wants to plug in an external SDIO card to
>>> your slot.  This one good argument for putting this in
>>> sdhci_arasan_soc_ctl_map, since you wouldn't want to do a
>>> compatibility matching every time set_ios is called.
>>
>> Thanks for the advice, I will look into that.
>>
>>>
>>> I'd have to look more into the whole SD/WP polarity issue.  There are
>>> already so many levels of inversion for these signals in Linux that
>>> it's confusing.  It seems like you might just want to hardcode them to
>>> "0" and let users use all the existing ways to invert things...  You
>>> could either put that hardcoding into your platform init code or (if
>>> you're using sdhci_arasan_soc_ctl_map) put it in the main init code so
>>> that if anyone else needs to init similar signals then they can take
>>> advantage of it.
>>
>> Yes, I think I will leave them to 0.
>>
>>>
>>> --
>>>
>>> One random side note is that as currently documented you need to
>>> specify a "shift" of -1 for any sdhci_arasan_soc_ctl_map fields you
>>> aren't using.  That seems stupid--not sure why I did that.  It seems
>>> better to clue off "width = 0" so that you could just freely not init
>>> any fields you don't need.
>>
>> I see.
>> So far I'm not really convinced about using "soc_ctl_map" because what I
>> have so far is more portable, and can easily be put as is somewhere else
>> (i.e.: in different flavors of bootloaders)
> 
> Well, most of your parameters are generic corecfg parameters for
> Asasan.  Seems like they would fit into the map nicely...
> 
> -Doug
> 
