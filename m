From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 20:01:18 +0200
Subject: [PATCH 2/6] ASoC: samsung: smdk_wm8580: Remove old platforms and
 drop mach-types usage
In-Reply-To: <9ef6c39c-e7a2-4591-380f-07f92317313b@metafoo.de>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
 <1479566911-5580-3-git-send-email-krzk@kernel.org>
 <8248c49a-1108-7fce-ed99-01653e11c670@metafoo.de>
 <90e0f455-fa24-f643-fa07-67efe217188a@metafoo.de>
 <9ef6c39c-e7a2-4591-380f-07f92317313b@metafoo.de>
Message-ID: <20161119180118.GA9513@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 19, 2016 at 04:48:26PM +0100, Lars-Peter Clausen wrote:
> On 11/19/2016 04:45 PM, Lars-Peter Clausen wrote:
> > On 11/19/2016 04:42 PM, Lars-Peter Clausen wrote:
> >> On 11/19/2016 03:48 PM, Krzysztof Kozlowski wrote:
> >> [...]
> >>> @@ -206,15 +204,10 @@ static int __init smdk_audio_init(void)
> >>>  	int ret;
> >>>  	char *str;
> >>>  
> >>> -	if (machine_is_smdkc100()
> >>> -			|| machine_is_smdkv210() || machine_is_smdkc110()) {
> >>> -		smdk.num_links = 3;
> >>> -	} else if (machine_is_smdk6410()) {
> >>> -		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> >>> -		str[strlen(str) - 1] = '2';
> >>> -		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> >>> -		str[strlen(str) - 1] = '2';
> >>> -	}
> >>> +	str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> >>> +	str[strlen(str) - 1] = '2';
> >>> +	str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> >>> +	str[strlen(str) - 1] = '2';
> >>
> >> This could be further simplified by just updating the initial cpu_dai_name
> >> string in the dai_link struct.
> >>
> >> Especially considering that the cpu_dai_name is a string literal and the ARM
> >> kernel now has rodata write protection enabled by default, so modifying it
> >> will crash the kernel.
> > 
> > Spoke too soon, you fix this up in the next patch. But I'd just squash that
> > change into this patch. I think it is pretty safe to assume that it is correct.

Yes, I wanted to split trivial change from something which would be nice
to test (I did not test it). However you're right that logically this is
the same change.

> And another thing. Since num_links is always 2 now the last entry from the
> smdk_dai array can be removed and num_links can be initialized using
> ARRAY_SIZE().

Ahh, indeed. The third DAI link (SEC_PLAYBACK) could be removed now.

Thanks for feedback,
Krzysztof
