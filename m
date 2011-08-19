From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 19 Aug 2011 10:19:33 +0800
Subject: [PATCH] pcmcia/pxa2xx_sharpsl: retain ops structure on collie
In-Reply-To: <CALT56yPWBNgPONQfTCtN9rZLTWrXx53m3Dk-xx8XshPNwsrnqQ@mail.gmail.com>
References: <1312715131-3956-1-git-send-email-dbaryshkov@gmail.com>
	<CALT56yPWBNgPONQfTCtN9rZLTWrXx53m3Dk-xx8XshPNwsrnqQ@mail.gmail.com>
Message-ID: <CAMPhdO-80Zd3uxTe8U-EKMooQUd6iucq05bxp2puMRrCtCbwVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2011 at 7:46 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> On Sun, Aug 7, 2011 at 3:05 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> The pxa2xx_sharpsl driver part is also used on collie, which (as
>> a StrongARM board) has different expectations for PCMCIA drivers.
>> So, on collie place sharpsl_pcmcia_ops in .data section rather than
>> in __initdata.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> Cc: stable at kernel.org
>
> Any comments on this patch?
>
>> diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
>> index 69ae2fd..f2405dc 100644
>> --- a/drivers/pcmcia/pxa2xx_sharpsl.c
>> +++ b/drivers/pcmcia/pxa2xx_sharpsl.c
>> @@ -219,7 +219,11 @@ static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
>> ? ? ? ?sharpsl_pcmcia_init_reset(skt);
>> ?}
>>
>> +#ifdef CONFIG_SA1100_COLLIE
>> +static struct pcmcia_low_level sharpsl_pcmcia_ops = {
>> +#else
>> ?static struct pcmcia_low_level sharpsl_pcmcia_ops __initdata = {
>> +#endif

Looks OK, and maybe we can put it even simpler by just removing __initdata.

>> ? ? ? ?.owner ? ? ? ? ? ? ? ? ?= THIS_MODULE,
>> ? ? ? ?.hw_init ? ? ? ? ? ? ? ?= sharpsl_pcmcia_hw_init,
>> ? ? ? ?.hw_shutdown ? ? ? ? ? ?= sharpsl_pcmcia_hw_shutdown,
>> --
>> 1.7.2.5
>>
>>
>
>
>
> --
> With best wishes
> Dmitry
>
