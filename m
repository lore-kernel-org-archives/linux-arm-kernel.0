From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 10 Feb 2015 09:25:38 +0800
Subject: [PATCH 1/3] USB: gadget: at91_udc: add at91sam9n12 support
In-Reply-To: <20150209111434.GN3715@piout.net>
References: <1423472572-19824-1-git-send-email-voice.shen@atmel.com>
 <1423472572-19824-2-git-send-email-voice.shen@atmel.com>
 <20150209111434.GN3715@piout.net>
Message-ID: <54D95E12.50308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On 02/09/2015 07:14 PM, Alexandre Belloni wrote:
> Hi Bo,
>
> On 09/02/2015 at 17:02:50 +0800, Bo Shen wrote :
>> Add at91sam9n12 SoC support.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   drivers/usb/gadget/udc/at91_udc.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
>> index c862656..f4c785f 100644
>> --- a/drivers/usb/gadget/udc/at91_udc.c
>> +++ b/drivers/usb/gadget/udc/at91_udc.c
>> @@ -931,7 +931,8 @@ static void pullup(struct at91_udc *udc, int is_on)
>>   		at91_udp_write(udc, AT91_UDP_TXVC, 0);
>>   		if (cpu_is_at91rm9200())
>>   			gpio_set_value(udc->board.pullup_pin, active);
>> -		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() || cpu_is_at91sam9g20()) {
>> +		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() ||
>> +			 cpu_is_at91sam9g20() || cpu_is_at91sam9n12()) {
>
> cpu_is_at91xx have been removed from the kernel, using the correct
> compatible should be enough, see
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/usb/gadget/udc/at91_udc.c?id=f0bceab4e3b528e799aba8fda8d2936fcfd41f1f

Thanks for you information. Missing this patch, check the next-20150209, 
it is here. I will base on next-20150209, so this patch no need anymore, 
only need to change the dts(i) file now.

Thanks again.

>
>>   			u32	txvc = at91_udp_read(udc, AT91_UDP_TXVC);
>>
>>   			txvc |= AT91_UDP_TXVC_PUON;
>> @@ -949,7 +950,8 @@ static void pullup(struct at91_udc *udc, int is_on)
>>   		at91_udp_write(udc, AT91_UDP_TXVC, AT91_UDP_TXVC_TXVDIS);
>>   		if (cpu_is_at91rm9200())
>>   			gpio_set_value(udc->board.pullup_pin, !active);
>> -		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() || cpu_is_at91sam9g20()) {
>> +		else if (cpu_is_at91sam9260() || cpu_is_at91sam9263() ||
>> +			 cpu_is_at91sam9g20() || cpu_is_at91sam9n12()) {
>>   			u32	txvc = at91_udp_read(udc, AT91_UDP_TXVC);
>>
>>   			txvc &= ~AT91_UDP_TXVC_PUON;
>> @@ -1758,7 +1760,8 @@ static int at91udc_probe(struct platform_device *pdev)
>>   	}
>>
>>   	/* newer chips have more FIFO memory than rm9200 */
>> -	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20()) {
>> +	if (cpu_is_at91sam9260() || cpu_is_at91sam9g20() ||
>> +	    cpu_is_at91sam9n12()) {
>>   		udc->ep[0].maxpacket = 64;
>>   		udc->ep[3].maxpacket = 64;
>>   		udc->ep[4].maxpacket = 512;
>> --
>> 2.3.0.rc0

Best Regards,
Bo Shen
