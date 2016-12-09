From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 9 Dec 2016 21:23:51 +0100
Subject: [PATCH v2 1/2] firmware: arm_scpi: zero RX buffer before
 requesting data from the mbox
In-Reply-To: <f544a379-a6a0-7839-85c3-a22449fecc46@arm.com>
References: <20161124001845.20830-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-1-martin.blumenstingl@googlemail.com>
 <20161125005432.1205-2-martin.blumenstingl@googlemail.com>
 <f544a379-a6a0-7839-85c3-a22449fecc46@arm.com>
Message-ID: <CAFBinCD9wgoA0CSsvje=P9Dk5T3-XWvnrPm9J8GLekMx1RS8iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 7:17 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 25/11/16 00:54, Martin Blumenstingl wrote:
>> The original code was relying on the fact that the SCPI firmware
>> responds with the same number of bytes (or more, all extra data would be
>> ignored in that case) as requested.
>> However, we have some pre-v1.0 SCPI firmwares which are responding with
>> less data for some commands (sensor_value.hi_val did not exist in the
>> old implementation). This means that some data from the previous
>> command's RX buffer was leaked into the current command (as the RX
>> buffer is re-used for all commands on the same channel). Clearing the
>> RX buffer before (re-) using it ensures we get a consistent result, even
>> if the SCPI firmware returns less bytes than requested.
>>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> ---
>>  drivers/firmware/arm_scpi.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
>> index 70e1323..8c183d8 100644
>> --- a/drivers/firmware/arm_scpi.c
>> +++ b/drivers/firmware/arm_scpi.c
>> @@ -259,6 +259,7 @@ struct scpi_chan {
>>       struct mbox_chan *chan;
>>       void __iomem *tx_payload;
>>       void __iomem *rx_payload;
>> +     resource_size_t max_payload_len;
>>       struct list_head rx_pending;
>>       struct list_head xfers_list;
>>       struct scpi_xfer *xfers;
>> @@ -470,6 +471,20 @@ static void scpi_tx_prepare(struct mbox_client *c, void *msg)
>>       if (t->rx_buf) {
>>               if (!(++ch->token))
>>                       ++ch->token;
>> +
>> +             /* clear the RX buffer as it is shared across all commands on
>> +              * the same channel (to make sure we're not leaking data from
>> +              * the previous response into the current command if the SCPI
>> +              * firmware writes less data than requested).
>> +              * This is especially important for pre-v1.0 SCPI firmwares
>> +              * where some fields in the responses do not exist (while they
>> +              * exist but are optional in newer versions). One example for
>> +              * this problem is sensor_value.hi_val, which would contain
>> +              * ("leak") the second 4 bytes of the RX buffer from the
>> +              * previous command.
>> +              */
>> +             memset_io(ch->rx_payload, 0, ch->max_payload_len);
>> +
>
> This looks like a overkill to me. I prefer your first approach over
> this, if it's only this command that's affected. I am still not sure
> why Neil Armstrong mentioned that it worked for him with 64-bit read.
OK, I'm fine with that. I also had a look at the patch you posted in
the cover-letter (I did not have time to test it yet though, I'll give
feedback tomorrow) - this looks better than my v1.

I think the explanation why it worked for Neil is pretty simple:
it depends on the SCPI command which was executed before the "read
sensor" command:
if that command returned [4 bytes with any value]0x00000000[any number
of bytes] then he got a valid result
