From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 05 Oct 2010 14:59:49 +0200
Subject: [PATCH] ulpi: add i.MX25 & 35 internal PHY ID
In-Reply-To: <20101005054225.GK7159@buzzloop.caiaq.de>
References: <1286195012-18999-1-git-send-email-eric@eukrea.com>
	<4CA9EAA0.2060608@ru.mvista.com> <4CA9EF97.5040908@compulab.co.il>
	<20101005054225.GK7159@buzzloop.caiaq.de>
Message-ID: <4CAB2145.8050605@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi,

On 10/05/10 07:42, Daniel Mack wrote:
> On Mon, Oct 04, 2010 at 05:15:35PM +0200, Igor Grinberg wrote:
>>  On 10/04/10 16:54, Sergei Shtylyov wrote:
>>> Hello.
>>>
>>> Eric B?nard wrote:
>>>
>>>> without this patch, the initialization of the OTG port in host mode
>>>> fails with :
>>>> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
>>>> mxc-ehci mxc-ehci.0: initializing i.MX USB Controller
>>>> ULPI transceiver vendor/product ID 0x0000/0x0000
>>>> ULPI ID does not match any known transceiver.
>>>> mxc-ehci mxc-ehci.0: unable to init transceiver, probably missing
>>>> Signed-off-by: Eric B?nard <eric@eukrea.com>
>>>> ---
>>>>  drivers/usb/otg/ulpi.c |    5 ++++-
>>>>  1 files changed, 4 insertions(+), 1 deletions(-)
>>>    You should have CC'ed linux-usb at vger.kernel.org.
>>>
>>>> diff --git a/drivers/usb/otg/ulpi.c b/drivers/usb/otg/ulpi.c
>>>> index ccc8195..e802e44 100644
>>>> --- a/drivers/usb/otg/ulpi.c
>>>> +++ b/drivers/usb/otg/ulpi.c
>>>> @@ -34,7 +34,10 @@
>>>>  /* ULPI hardcoded IDs, used for probing */
>>>>  static unsigned int ulpi_ids[] = {
>>>>      ULPI_ID(0x04cc, 0x1504),    /* NXP ISP1504 */
>>>> -    ULPI_ID(0x0424, 0x0006),        /* SMSC USB3319 */
>>>> +    ULPI_ID(0x0424, 0x0006),    /* SMSC USB3319 */
>>>> +#if (defined(CONFIG_ARCH_MX25) || defined(CONFIG_ARCH_MX35))
>>>> +    ULPI_ID(0x0000, 0x0000),    /* i.MX25 & i.MX35 internal PHY */
>>>> +#endif
>>>    I don't know why this table is at all used in the first place. IMO, checking for the vendor/device ID serves no purpose...
>> Well, it was there in first place, when Daniel merged this.
>> May be it was taken from Sascha.
>> I think its purpose to check if there is a ulpi transceiver out there,
>> although, ulpi defines a special scratch register for testing purposes.
> Correct, its primary purpose was to see whether the ULPI low-level
> communication works at all, and to bail out when it doesn't.
>
> I wasn't aware of that scratch register. If we don't need that table any
> more, feel free to drop it.

This driver is still in development stage and is not fully functional,
so I'd like to keep the table and ID info printing, but I really don't like
trivial IDs, like that of Eric.

How about something like the attached patch?

Eric, can you test if it works for you?

If it's good, I can send a prettier version of it for review and merging.

-- 
Regards,
Igor.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: ulpi.patch
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101005/87e8f647/attachment.ksh>
