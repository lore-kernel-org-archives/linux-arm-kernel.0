From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Fri, 16 Nov 2012 15:53:21 +0100
Subject: [PATCH 7/9] usb: chipidea: udc: add force-full-speed option
In-Reply-To: <87wqxl679k.fsf@ashishki-desk.ger.corp.intel.com>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-8-git-send-email-m.grzeschik@pengutronix.de>
 <87wqxl679k.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <50A65361.5070209@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Shishkin a ?crit :
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> 
>> This patch makes it possible to set the chipidea udc
>> into full-speed only mode. It can be set by the oftree
>> property "force-full-speed".
>>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/usb/chipidea/bits.h  |    1 +
>>  drivers/usb/chipidea/core.c  |    5 +++++
>>  include/linux/usb/chipidea.h |    1 +
>>  3 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
>> index 3cded5f..85b6b09 100644
>> --- a/drivers/usb/chipidea/bits.h
>> +++ b/drivers/usb/chipidea/bits.h
>> @@ -51,6 +51,7 @@
>>  #define PORTSC_PTS            (BIT(31) | BIT(30))
>>  #define PORTSC_PTW            BIT(28)
>>  #define PORTSC_STS            BIT(29)
>> +#define PORTSC_PFSC           BIT(24)
> 
> Same for this one, it's in DEVLC in my spec.
> 
Yes it depends it device support lpm or not.

We have the same problem with hw_port_is_high_speed [1]. Mapping is different
according lpm support for some register.

Matthieu

[1]
drivers/usb/chipidea/udc.c
static int hw_port_is_high_speed(struct ci13xxx *ci)
{
    return ci->hw_bank.lpm ? hw_read(ci, OP_DEVLC, DEVLC_PSPD) :
        hw_read(ci, OP_PORTSC, PORTSC_HSP);
}
