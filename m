From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 21:54:06 +0800
Subject: [PATCH v2 14/15] ARM: mxs: Add initial mx28evk support
In-Reply-To: <AANLkTim4mD88r5r6Yw5syYasw53z1jXZoMhJ+xGdFehT@mail.gmail.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-11-git-send-email-shawn.guo@freescale.com>
	<20101208202822.GD17441@pengutronix.de>
	<AANLkTiny2P3RobZfq_G_OPHu_SLjZ2w9CFhU7HgL3VPx@mail.gmail.com>
	<20101209083237.GO17441@pengutronix.de>
	<AANLkTin3-f7x2BXS=zTYYw+uWiu9UYG8sPWdQXWcxpxn@mail.gmail.com>
	<20101209093746.GU17441@pengutronix.de>
	<AANLkTinwmdxEXNObEbHd10ZxfTmTCaWiHmwXpf8hs3f1@mail.gmail.com>
	<19712.52041.958400.447834@ipc1.ka-ro>
	<AANLkTim4mD88r5r6Yw5syYasw53z1jXZoMhJ+xGdFehT@mail.gmail.com>
Message-ID: <AANLkTindchqQ8EWRFSEN1sA4aAMsEYkVHGHw3OJxRDei@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 9, 2010 at 9:38 PM, Shawn Guo <shawn.gsc@gmail.com> wrote:
> Hi Lothar,
>
> On Thu, Dec 9, 2010 at 8:27 PM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
>> Shawn Guo writes:
>>> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>>> > Hello Shawn
>>> > On Thu, Dec 09, 2010 at 05:03:54PM +0800, Shawn Guo wrote:
>>> >> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>>> >> > Hello Shwan,
>>> > ups, sorry for mistyping your name.
>>> >
>>> >> > On Thu, Dec 09, 2010 at 03:04:37PM +0800, Shawn Guo wrote:
>>> >> >> 2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>>> >> >> > On Wed, Dec 08, 2010 at 12:32:02AM +0800, Shawn Guo wrote:
>>> >> >> >> +static iomux_cfg_t mx28evk_pads[] = {
>>> >> >> > This can be const and __initconst, ditto for mx23evk
>>> >> >> >
>>> >> >> With u64 iomux_cfg_t changes, I'm afraid the suggestion becomes invalid.
>>> >> > Really? Why?
>>> >> >
>>> >> I'm confused by the compiling error below when adding __initconst for
>>> >> mx28evk_pads[], and mistakenly blaming u64 iomux_cfg_t changes.
>>> >>
>>> >> arch/arm/mach-mxs/mach-mx28evk.c: In function ?mx28evk_init?:
>>> >> arch/arm/mach-mxs/mach-mx28evk.c:34: error: mx28_fec_pdata causes a
>>> >> section type conflict
>>> >> make[1]: *** [arch/arm/mach-mxs/mach-mx28evk.o] Error 1
>>> >> make: *** [arch/arm/mach-mxs] Error 2
>>> >>
>>> >> Actually it can be fixed by the following change.
>>> >>
>>> >> -static const struct fec_platform_data mx28_fec_pdata __initconst = {
>>> >> +static struct fec_platform_data mx28_fec_pdata __initconst = {
>>> >> ? ? ? ? ?.phy = PHY_INTERFACE_MODE_RMII,
>>> >> ?};
>>> > this change is wrong. ?You need to assert that all data being marked
>>> > with __initconst is const, too.
>>> >
>>> After adding const for mx28evk_pads[], I got the following error.
>>>
>>> ? CC ? ? ?arch/arm/mach-mxs/mach-mx28evk.o
>>> arch/arm/mach-mxs/mach-mx28evk.c: In function ?mx28evk_init?:
>>> arch/arm/mach-mxs/mach-mx28evk.c:102: warning: passing argument 1 of
>>> ?mxs_iomux_setup_multiple_pads? discards qualifiers from pointer
>>> target type
>>> arch/arm/mach-mxs/include/mach/iomux.h:115: note: expected
>>> ?iomux_cfg_t *? but argument is of type ?const iomux_cfg_t *?
>>>
>> The argument of mxs_iomux_setup_multiple_pads() should get the const
>> attribute:
>> -int mxs_iomux_setup_multiple_pads(iomux_cfg_t *pad_list, unsigned count)
>> +int mxs_iomux_setup_multiple_pads(const iomux_cfg_t *pad_list, unsigned count)
>>
>>> This takes me back to my first judgment. ?Is it proper to add
>>> __initconst for mx28evk_pads[]? We are changing iomux_cfg_t to u64 for
>>> making pad definition modifiable.
>>>
>> Modifiable in the sense that you can add platform specific PAD
>> settings by simply ORing them to the original pad definition so that
>> there is no need for runtime modifications like:
>> | ? ? ? iomux_v3_cfg_t power_key = MX51_PAD_EIM_A27__GPIO_2_21;
>> ...
>> | ? ? ? power_key.pad_ctrl = MX51_GPIO_PAD_CTRL_2;
>> | ? ? ? mxc_iomux_v3_setup_pad(&power_key);
>> but you can do:
>> | ? ? ? iomux_v3_cfg_t power_key = (MX51_PAD_EIM_A27__GPIO_2_21 &
>> | ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2;
>> ...
>> | ? ? ? mxc_iomux_v3_setup_pad(power_key);
>> instead. You can also augment the pad desc in a static table:
>> |static iomux_cfg_t pad_desc[] = {
>> | ? ? ? (MX51_PAD_EIM_A27__GPIO_2_21 & ~MUX_PAD_CTRL_MASK) | MX51_GPIO_PAD_CTRL_2,
>>
>>
> Thanks for the explanation. ?But I'm a little puzzled by the use of
> "const" here. Per your suggestion, I have the following.
>
> mach-28evk.c
> static const iomux_cfg_t mx28evk_pads[] __initconst = {
>
> iomux.h
> int mxs_iomux_setup_multiple_pads(const iomux_cfg_t *pad_list, unsigned count);
>
> iomux.c
> int mxs_iomux_setup_multiple_pads(const iomux_cfg_t *pad_list, unsigned count)
>
> Compiler complains as below.
>
> ?CC ? ? ?arch/arm/mach-mxs/iomux.o
> arch/arm/mach-mxs/iomux.c:89: error: conflicting types for
> ?mxs_iomux_setup_multiple_pads?
> arch/arm/mach-mxs/include/mach/iomux.h:115: note: previous declaration
> of ?mxs_iomux_setup_multiple_pads? was here
> make[1]: *** [arch/arm/mach-mxs/iomux.o] Error 1
> make: *** [arch/arm/mach-mxs] Error 2
>
> If I remove the "const" in iomux.h as below.
>
> iomux.h
> int mxs_iomux_setup_multiple_pads(iomux_cfg_t *pad_list, unsigned count);
>
> Compiler gives the following warning.
>
> ?CC ? ? ?arch/arm/mach-mxs/mach-mx28evk.o
> arch/arm/mach-mxs/mach-mx28evk.c: In function ?mx28evk_init?:
> arch/arm/mach-mxs/mach-mx28evk.c:102: warning: passing argument 1 of
> ?mxs_iomux_setup_multiple_pads? discards qualifiers from pointer
> target type
> arch/arm/mach-mxs/include/mach/iomux.h:115: note: expected
> ?iomux_cfg_t *? but argument is of type ?const iomux_cfg_t *?
>
> What's wrong here?
>
Sorry.  Please ignore this message.

-- 
Regards,
Shawn
