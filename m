From: dianders@chromium.org (Doug Anderson)
Date: Mon, 5 Dec 2016 08:30:16 -0800
Subject: Adding a .platform_init callback to sdhci_arasan_ops
In-Reply-To: <9d63ea01-a5d1-603d-1ad4-6c6320022de8@laposte.net>
References: <d50dcd8a-2489-4e82-1dc7-13e93e38d5ff@laposte.net>
 <982d633b-e9c4-0f10-052b-e324f094d0f5@xilinx.com>
 <2a949ade-edd7-4690-cd6a-434ae1e663dc@intel.com>
 <66751ab5-59a4-ec30-07cd-44ca03694723@laposte.net>
 <d1801c1e-cd74-b79c-0280-8fb5dc377c91@intel.com>
 <e32d2a01-ba3c-6127-51ba-a1fd4176e32c@laposte.net>
 <CAD=FV=UhVtQQ1PPtLrvra20ja1k9GKs9hyFcrjBUYmyUmQK45Q@mail.gmail.com>
 <9d63ea01-a5d1-603d-1ad4-6c6320022de8@laposte.net>
Message-ID: <CAD=FV=WyoTQudydKXnA-8DKvywXXoEOJyV8Vvt5GOBgKXEN+vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 5, 2016 at 4:29 AM, Sebastian Frias <sf84@laposte.net> wrote:
> Hi Doug,
>
> On 28/11/16 19:02, Doug Anderson wrote:
>> Hi,
>>
>> On Mon, Nov 28, 2016 at 5:28 AM, Sebastian Frias <sf84@laposte.net> wrote:
>>> +static void sdhci_tango4_platform_init(struct sdhci_host *host)
>>> +{
>>> +       printk("%s\n", __func__);
>>> +
>>> +       /*
>>> +         pad_mode[2:0]=0    must be 0
>>> +         sel_sdio[3]=1      must be 1 for SDIO
>>> +         inv_sdwp_pol[4]=0  if set inverts the SD write protect polarity
>>> +         inv_sdcd_pol[5]=0  if set inverts the SD card present polarity
>>> +       */
>>> +       sdhci_writel(host, 0x00000008, 0x100 + 0x0);
>>
>> If I were doing this, I'd probably actually add these fields to the
>> "sdhci_arasan_soc_ctl_map", then add a 3rd option to
>> sdhci_arasan_syscon_write().  Right now it has 2 modes: "hiword
>> update" and "non-hiword update".  You could add a 3rd indicating that
>> you set config registers by just writing at some offset of the main
>> SDHCI registers space.
>>
>> So you'd add 4 fields:
>>
>> .tango_pad_mode = { .reg = 0x0000, .width = 3, .shift = 0 },
>> .sel_sdio = { .reg = 0x0000, .width = 1, .shift = 3},
>> .inv_sdwp_pol = { .reg = 0x0000, .width = 1, .shift = 4},
>> .inv_sdcd_pol = { .reg = 0x0000, .width = 1, .shift = 5},
>
> Right now I'm using something like:

So taking a very quick gander at
<https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf>
and comparing the "corecfg" things to what you're setting, I find many
matches.  I didn't look very hard, so probably could find matches for
the rest?


> +       val = 0;
> +       val |= PAD_MODE(0); /* must be 0 */
> +       val |= SEL_SDIO;    /* enable SDIO */
> +       sdhci_writel(host, val, 0x100 + 0x0);
> +
> +       val = 0;
> +       val |= TIMEOUT_CLK_UNIT_MHZ;         /* unit: MHz */
> +       val |= TIMEOUT_CLK_FREQ(52);         /* timeout clock: 52MHz */

corecfg_timeoutclkfreq[5:0] ?

> +       val |= BUS_CLK_FREQ_FOR_SD_CLK(200); /* SDIO clock: 200MHz (TODO: get from DT) */
> +       val |= MAX_BLOCK_LENGTH(3);          /* max block size: 4096 bytes */
> +       val |= EXTENDED_MEDIA_BUS_SUPPORTED; /* DT? */
> +       val |= ADMA2_SUPPORTED;              /* DT? */

corecfg_adma2support

> +       val |= HIGH_SPEED_SUPPORTED;         /* DT? */

corecfg_highspeedsupport

> +       val |= SDMA_SUPPORTED;               /* DT? */

corecfg_sdmasupport

> +       val |= SUSPEND_RESUME_SUPPORTED;     /* DT? */

corecfg_suspressupport

> +       val |= VOLTAGE_3_3_V_SUPPORTED;      /* DT? */

corecfg_3p3voltsupport

> +#if 0
> +       val |= VOLTAGE_1_8_V_SUPPORTED;      /* DT? */

corecfg_1p8voltsupport

> +#endif
> +       val |= ASYNCHRONOUS_IRQ_SUPPORTED;   /* DT? */

corecfg_asyncintrsupport

> +       val |= SLOT_TYPE_REMOVABLE;          /* DT? */

corecfg_slottype[1:0]

> +       val |= SDR50_SUPPORTED;              /* DT? */

corecfg_sdr50support

> +       sdhci_writel(host, val, 0x100 + 0x40);
> +
> +       val = 0;
> +       val |= TIMER_COUNT_FOR_RETUNING(1);  /* DT? */

corecfg_retuningtimercnt[3:0]

> +       val |= CLOCK_MULTIPLIER(0);          /* DT? */
> +       val |= SPI_MODE_SUPPORTED;           /* DT? */

corecfg_spisupport

> +       val |= SPI_BLOCK_MODE_SUPPORTED;     /* DT? */

corecfg_spiblkmode

> +       sdhci_writel(host, val, 0x100 + 0x44);
> +
> +       sdhci_writel(host, 0x0004022c, 0x100 + 0x28);
> +       sdhci_writel(host, 0x00000002, 0x100 + 0x2c);
> +
> +       sdhci_writel(host, 0x00600000, 0x100 + 0x50);

AKA: you are setting up various "corecfg" stuff that's documented in
the generic Arasan docs.  Others SDHCI-Arasan implementations might
want to set the same things, but those values may be stored elsewhere
for them.

So if _all_ Arasan implementations need these same values or need the
same logic to figure out these values, then you should do something
that's not chip-specific but something generic.

If you've got a specific weird quirk that's specific to your platform,
then you could do that in a chip-specific init.

Presumably many of the above could just be hardcoded on some
implementations, so they might not be available in a memory-mapped
implementation...


> which seems much easier to handle (and portable).
>
> At any rate, one thing to note from this is that many of these
> bits should probably be initialised based on DT, right?

Probably, or by proving the voltage value of regulations.  Note that I
think DT already gets parsed and sets up caps.  I'm not really an
expert here and I'd let someone who actually knows / maintains SDMMC
comment.  I know for sure that dw_mmc (which I'm way more familiar
with) does things very differently than sdhci (which I'm barely
familiar with).


> For example, the DT has a "non-removable" property, which I think
> should be used to setup SLOT_TYPE_EMBEDDED (if the property is
> present) or SLOT_TYPE_REMOVABLE (if the property is not present)
>
> Looking at Documentation/devicetree/bindings/mmc/mmc.txt we can see
> more related properties:
>
> Optional properties:
> - bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
>   will be <1> if the property is absent.
> - wp-gpios: Specify GPIOs for write protection, see gpio binding
> - cd-inverted: when present, polarity on the CD line is inverted. See the note
>   below for the case, when a GPIO is used for the CD line
> - wp-inverted: when present, polarity on the WP line is inverted. See the note
>   below for the case, when a GPIO is used for the WP line
> - disable-wp: When set no physical WP line is present. This property should
>   only be specified when the controller has a dedicated write-protect
>   detection logic. If a GPIO is always used for the write-protect detection
>   logic it is sufficient to not specify wp-gpios property in the absence of a WP
>   line.
> - max-frequency: maximum operating clock frequency
> - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
>   this system, even if the controller claims it is.
> - cap-sd-highspeed: SD high-speed timing is supported
> - cap-mmc-highspeed: MMC high-speed timing is supported
> - sd-uhs-sdr12: SD UHS SDR12 speed is supported
> - sd-uhs-sdr25: SD UHS SDR25 speed is supported
> - sd-uhs-sdr50: SD UHS SDR50 speed is supported
> - sd-uhs-sdr104: SD UHS SDR104 speed is supported
> - sd-uhs-ddr50: SD UHS DDR50 speed is supported
> ...
>
> which makes me wonder, what is the recommended way of dealing with this?
> - Should I use properties on the DT? If so, then I need to add code to set
> up the register properly.
> - Should I hardcode these values use a minimal DT? If so, then I need an
> init function to put all this.
> - Should I hardcode stuff at u-Boot level? If so, nothing is required and
> should work without any modifications to the Arasan Linux driver.
>
> It appears that the Linux driver is expecting most of these fields to be
> hardcoded and "pre-set" before (maybe by the bootloader) it starts, hence
> the lack of any "init" function so far.
>
>>
>> In your platform-specific init you're proposing you could set
>> tango_pad_mode to 0.  That seems tango-specific.
>>
>> You'd want to hook into "set_ios" for setting sel_sdio or not.  That's
>> important if anyone ever wants to plug in an external SDIO card to
>> your slot.  This one good argument for putting this in
>> sdhci_arasan_soc_ctl_map, since you wouldn't want to do a
>> compatibility matching every time set_ios is called.
>
> Thanks for the advice, I will look into that.
>
>>
>> I'd have to look more into the whole SD/WP polarity issue.  There are
>> already so many levels of inversion for these signals in Linux that
>> it's confusing.  It seems like you might just want to hardcode them to
>> "0" and let users use all the existing ways to invert things...  You
>> could either put that hardcoding into your platform init code or (if
>> you're using sdhci_arasan_soc_ctl_map) put it in the main init code so
>> that if anyone else needs to init similar signals then they can take
>> advantage of it.
>
> Yes, I think I will leave them to 0.
>
>>
>> --
>>
>> One random side note is that as currently documented you need to
>> specify a "shift" of -1 for any sdhci_arasan_soc_ctl_map fields you
>> aren't using.  That seems stupid--not sure why I did that.  It seems
>> better to clue off "width = 0" so that you could just freely not init
>> any fields you don't need.
>
> I see.
> So far I'm not really convinced about using "soc_ctl_map" because what I
> have so far is more portable, and can easily be put as is somewhere else
> (i.e.: in different flavors of bootloaders)

Well, most of your parameters are generic corecfg parameters for
Asasan.  Seems like they would fit into the map nicely...

-Doug
