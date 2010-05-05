From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 5 May 2010 08:23:27 +0800
Subject: [PATCH] pxa: Remove unused MFP LPM definition
In-Reply-To: <4BE09D3A.3040100@gmail.com>
References: <4BD64FF1.2090007@gmail.com>
	<s2yf17812d71004262016xb120ea1j2d0d7dd14ebd3d28@mail.gmail.com>
	<4BE09D3A.3040100@gmail.com>
Message-ID: <w2qf17812d71005041723h1f70de11w8e3bc85ea3bde682@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 5, 2010 at 6:18 AM, David Hunter <hunterd42@gmail.com> wrote:
> On 4/26/2010 8:16 PM, Eric Miao wrote:
>>
>> Instead of removing this potentially useful low power mode pin status,
>> what
>> about the following patch:
>
> I think the name itself is confusing. All of the other MFP_LPM_ definitions
> state what the pin is going to do: drive high/low, pull high/low, or float.
> My (strictly document-derived) understanding of PXA27x is that you can only
> choose to drive or float a pin, while with PXA3xx you can do all of the
> above. What would MFP_LPM_INPUT do that MFP_LPM_FLOAT wouldn't?

I'm currently not sure of how input is implemented in pxa27x during
low power mode, but strictly, input != float. While float is usually a Hi-Z
without pull-up or pull-down, input could be different. That's why I still
intend to keep input there.

>
>> commit f5d406d50f924c82ddf469f120fa420f0499d901
>> Author: Eric Miao<eric.y.miao@gmail.com>
>> Date: ? Tue Apr 27 11:14:24 2010 +0800
>>
>> ? ? [ARM] pxa: allow MFP_LPM_INPUT to be explicitly specified
>>
>> ? ? Signed-off-by: Eric Miao<eric.y.miao@gmail.com>
>>
>> diff --git a/arch/arm/mach-pxa/mfp-pxa2xx.c
>> b/arch/arm/mach-pxa/mfp-pxa2xx.c
>> index e5b7921..1d1419b 100644
>> --- a/arch/arm/mach-pxa/mfp-pxa2xx.c
>> +++ b/arch/arm/mach-pxa/mfp-pxa2xx.c
>> @@ -81,6 +81,7 @@ static int __mfp_config_gpio(unsigned gpio, unsigned
>> long c)
>> ? ? ? ? ? ? ? ?PGSR(bank)&= ~mask;
>> ? ? ? ? ? ? ? ?is_out = 1;
>> ? ? ? ? ? ? ? ?break;
>> + ? ? ? case MFP_LPM_INPUT:
>> ? ? ? ?case MFP_LPM_DEFAULT:
>> ? ? ? ? ? ? ? ?break;
>
> If I read this correctly, _DEFAULT will, on entry to LPM, change the pin
> direction to the one implied by bit 23 (MFP_DIR_IN/MFP_DIR_OUT). For _INPUT
> to live up to its name, maybe it should always float the pin, like this:
>

Good catch.

> + ? ? ? case MFP_LPM_INPUT:
> + ? ? ? ? ? ? ? is_out = 0;
> + ? ? ? ? ? ? ? break;
> ? ? ? ?case MFP_LPM_DEFAULT:
> ? ? ? ? ? ? ? ?break;
>
> Also, I'm not sure what effect GAFR will have (if any) in LPM. Does the AF
> have to be set to GPIO to enable the PGSR/GPDR settings? Your original patch
> did just that:
>

My understanding is so. While PGSR will be loaded into GPSR or GPCR when
entering low power mode, and GPSR/GPCR is one of the mux input, which I'd
say making them to be GPIO will be safer to ensure the correct low power value.

> [http://www.spinics.net/lists/arm-kernel/msg55842.html]
>
>> diff --git a/arch/arm/plat-pxa/mfp.c b/arch/arm/plat-pxa/mfp.c
>> index be58f9f..b77e018 100644
>> --- a/arch/arm/plat-pxa/mfp.c
>> +++ b/arch/arm/plat-pxa/mfp.c
>> @@ -110,6 +110,7 @@ static const unsigned long mfpr_lpm[] = {
>> ? ? ? ?MFPR_LPM_PULL_LOW,
>> ? ? ? ?MFPR_LPM_PULL_HIGH,
>> ? ? ? ?MFPR_LPM_FLOAT,
>> + ? ? ? MFPR_LPM_INPUT,
>> ?};
>>
>> ?/* mapping of MFP_PULL_* definitions to MFPR_PULL_* register bits */
>
> This adds a bug, which I've been trying to find the right way to fix. It's
> the same case as MFPR_LPM_DEFAULT. Since MFPR_LPM_INPUT = 0,
> MFPR[SLEEP_OE_N] will be cleared at LPM, and the pin will be driven low.
> (Not a good idea for a "default".) Either MFPR_LPM_FLOAT, _PULL_LOW, or
> _PULL_HIGH should be used instead. And only the board code knows enough to
> pick the right one for each pin.
>

This looks odd to me as well, yet the setting is derived from some
piece of code long time ago, which I have no way to track. But yes,
feel free to submit patch for this. I'm yet not sure enough about which
low power state is most power conserving, before that's figured out,
I guess _FLOAT is a choice as it imposes minimum external effect
at least.

> I've been working to cobble together a patch to address this in my
> spare time, but don't have U-Boot running on Littleton yet. If you know
> of a way to get this going -- or something other way of loading the
> kernel -- I'd be grateful for the assist.

blob I'd say - but that's definitely not sexy. u-boot, on the other hand,
you can ask Marek for detail, he's managed to get it running on littleton
now. (I've got him CC'ed)

> The difference between blob's idea
> of bad block management vs. Linux's has me avoiding blob at all costs.
>
> -Dave
>
