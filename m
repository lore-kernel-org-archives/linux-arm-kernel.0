From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 19 Nov 2016 16:42:33 +0100
Subject: [PATCH 2/6] ASoC: samsung: smdk_wm8580: Remove old platforms and
 drop mach-types usage
In-Reply-To: <1479566911-5580-3-git-send-email-krzk@kernel.org>
References: <1479566911-5580-1-git-send-email-krzk@kernel.org>
 <1479566911-5580-3-git-send-email-krzk@kernel.org>
Message-ID: <8248c49a-1108-7fce-ed99-01653e11c670@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2016 03:48 PM, Krzysztof Kozlowski wrote:
[...]
> @@ -206,15 +204,10 @@ static int __init smdk_audio_init(void)
>  	int ret;
>  	char *str;
>  
> -	if (machine_is_smdkc100()
> -			|| machine_is_smdkv210() || machine_is_smdkc110()) {
> -		smdk.num_links = 3;
> -	} else if (machine_is_smdk6410()) {
> -		str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> -		str[strlen(str) - 1] = '2';
> -		str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> -		str[strlen(str) - 1] = '2';
> -	}
> +	str = (char *)smdk_dai[PRI_PLAYBACK].cpu_dai_name;
> +	str[strlen(str) - 1] = '2';
> +	str = (char *)smdk_dai[PRI_CAPTURE].cpu_dai_name;
> +	str[strlen(str) - 1] = '2';

This could be further simplified by just updating the initial cpu_dai_name
string in the dai_link struct.

Especially considering that the cpu_dai_name is a string literal and the ARM
kernel now has rodata write protection enabled by default, so modifying it
will crash the kernel.
