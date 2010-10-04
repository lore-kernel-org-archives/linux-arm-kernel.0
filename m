From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon, 04 Oct 2010 17:15:35 +0200
Subject: [PATCH] ulpi: add i.MX25 & 35 internal PHY ID
In-Reply-To: <4CA9EAA0.2060608@ru.mvista.com>
References: <1286195012-18999-1-git-send-email-eric@eukrea.com>
	<4CA9EAA0.2060608@ru.mvista.com>
Message-ID: <4CA9EF97.5040908@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 On 10/04/10 16:54, Sergei Shtylyov wrote:
> Hello.
>
> Eric B?nard wrote:
>
>> without this patch, the initialization of the OTG port in host mode
>> fails with :
>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>> mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
>> ULPI transceiver vendor/product ID 0x0000/0x0000
>> ULPI ID does not match any known transceiver.
>> mxc-ehci mxc-ehci.0: unable to init transceiver, probably missing
>
>> Signed-off-by: Eric B?nard <eric@eukrea.com>
>> ---
>>  drivers/usb/otg/ulpi.c |    5 ++++-
>>  1 files changed, 4 insertions(+), 1 deletions(-)
>
>    You should have CC'ed linux-usb at vger.kernel.org.
>
>> diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
>> index ccc8195..e802e44 100644
>> --- a/drivers/usb/otg/ulpi.c
>> +++ b/drivers/usb/otg/ulpi.c
>> @@ -34,7 +34,10 @@
>>  /* ULPI hardcoded IDs, used for probing */
>>  static unsigned int ulpi_ids[] = {
>>      ULPI_ID(0x04cc, 0x1504),    /* NXP ISP1504 */
>> -    ULPI_ID(0x0424, 0x0006),        /* SMSC USB3319 */
>> +    ULPI_ID(0x0424, 0x0006),    /* SMSC USB3319 */
>> +#if (defined(CONFIG_ARCH_MX25) || defined(CONFIG_ARCH_MX35))
>> +    ULPI_ID(0x0000, 0x0000),    /* i.MX25 & i.MX35 internal PHY */
>> +#endif
>
>    I don't know why this table is at all used in the first place. IMO, checking for the vendor/device ID serves no purpose...

Well, it was there in first place, when Daniel merged this.
May be it was taken from Sascha.
I think its purpose to check if there is a ulpi transceiver out there,
although, ulpi defines a special scratch register for testing purposes.

>
> WBR, Sergei
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Regards,
Igor.
