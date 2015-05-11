From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 11 May 2015 20:14:12 +0200
Subject: [linux-sunxi] Re: [PATCH v2 04/13] musb: Do not use musb_read[b|w]
 / _write[b|w] wrappers in generic fifo functions
In-Reply-To: <20150511155846.GH19476@saruman.tx.rr.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <1426878682-14521-5-git-send-email-hdegoede@redhat.com>
 <20150511155846.GH19476@saruman.tx.rr.com>
Message-ID: <5550F174.6000709@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-05-15 17:58, Felipe Balbi wrote:
> On Fri, Mar 20, 2015 at 08:11:13PM +0100, Hans de Goede wrote:
>> The generic fifo functions already use non wrapped accesses in various
>> cases through the iowrite#_rep functions, and all platforms which override
>> the default musb_read[b|w] / _write[b|w] functions also provide their own
>> fifo access functions, so we can safely drop the unnecessary indirection
>> from the fifo access functions.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/usb/musb/musb_core.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>> index 01ed3a6..016b5b9 100644
>> --- a/drivers/usb/musb/musb_core.c
>> +++ b/drivers/usb/musb/musb_core.c
>> @@ -313,7 +313,7 @@ static void musb_default_write_fifo(struct musb_hw_ep *hw_ep, u16 len,
>>   				index += len & ~0x03;
>>   			}
>>   			if (len & 0x02) {
>> -				musb_writew(fifo, 0, *(u16 *)&src[index]);
>> +				__raw_writew(*(u16 *)&src[index], fifo);
>
> not all architectures provide __raw_* accessors, right ?

As Arnd mentions in his reply, these are available everywhere.

Also note, that as I've tried to explain in the commit message already this commit
makes no functional changes what so ever, the generic musb_default_read/write_fifo
functions are only used by musb platforms which do not overwrite musb_write* /
musb_read* and musb_write* / musb_read* are already just thin wrappers around
the __raw_* functions.

Regards,

Hans
