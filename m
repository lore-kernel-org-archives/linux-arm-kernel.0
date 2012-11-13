From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 13 Nov 2012 17:10:26 +0800
Subject: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
In-Reply-To: <20121113083031.GP18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
 <20121113083031.GP18224@opensource.wolfsonmicro.com>
Message-ID: <50A20E82.9020704@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 11/13/2012 16:30, Mark Brown wrote:
> On Mon, Nov 12, 2012 at 03:40:26PM +0800, Bo Shen wrote:
>
>>   static struct platform_device sam9g20ek_audio_device = {
>>   	.name   = "at91sam9g20ek-audio",
>> -	.id     = -1,
>> +	.id     = 0,
>>   };
>
> Why are you changing this?  Single devices are supposed to specify -1 as
> their id.

This is for non-dt support, using the id to tell which ssc will be used 
to remap into audio subsystem. Maybe this is a mixed up usage, however I 
can not find good solution, any suggestions?

This is a similar implement as 7840487cd6298f9f931103b558290d8d98d41c49

>>   static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>>   			     struct snd_soc_dai *dai)
>>   {
>> -	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
>> +	struct atmel_ssc_info *ssc_p = &ssc_info;
>
> This seems like a very big step backwards, there's now a single global
> variable for the ssc_info which presumably means there can be only one
> SSC active in the system at once.  That's changing a lot more than just
> the registration...

This change won't broke other subsystem using ssc, only broke the audio 
subsystem if there are two codecs co-exist in a system.
I will fix this in next version.

Yes, this patch is a little more than registration, however when change 
the registration method, the related code will be affected, so also 
clean up them in this patch, do I need to split this patch?

Thanks.

Best Regards,
Bo Shen
