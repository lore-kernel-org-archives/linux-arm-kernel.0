From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 5 Dec 2014 09:15:29 +0100
Subject: [PATCH v2 1/3] i2c: cadence: Handle > 252 byte transfers
In-Reply-To: <CAA7nrtg_G+U2EVxy0joZC+fBGyXS_uOwe1RZ8PyoDv7icu6OBw@mail.gmail.com>
References: <1417610126-7957-1-git-send-email-harinik@xilinx.com>
 <1417610126-7957-2-git-send-email-harinik@xilinx.com>
 <CAA7nrtg_G+U2EVxy0joZC+fBGyXS_uOwe1RZ8PyoDv7icu6OBw@mail.gmail.com>
Message-ID: <66a490c827bc47d98a0118a58d7060e7@BN1BFFO11FD054.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2014 06:41 AM, rajeev kumar wrote:
> On Wed, Dec 3, 2014 at 6:05 PM, Harini Katakam <harinik@xilinx.com> wrote:
>> The I2C controller sends a NACK to the slave when transfer size register
>> reaches zero, irrespective of the hold bit. So, in order to handle transfers
>> greater than 252 bytes, the transfer size register has to be maintained at a
>> value >= 1. This patch implements the same.
> 
> Why 252 Bytes ?  Is it word allign or what ?
> 
>> The interrupt status is cleared at the beginning of the isr instead of
>> the end, to avoid missing any interrupts - this is in sync with the new
>> transfer handling.
>>
> 
> No need to write this, actually this is the correct way of handling interrupt.
> 
>> Signed-off-by: Harini Katakam <harinik@xilinx.com>
>> ---
>>
>> v2:
>> No changes
>>
>> ---
>>  drivers/i2c/busses/i2c-cadence.c |  156 ++++++++++++++++++++------------------
>>  1 file changed, 81 insertions(+), 75 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
>> index 63f3f03..e54899e 100644
>> --- a/drivers/i2c/busses/i2c-cadence.c
>> +++ b/drivers/i2c/busses/i2c-cadence.c
>> @@ -126,6 +126,7 @@
>>   * @suspended:         Flag holding the device's PM status
>>   * @send_count:                Number of bytes still expected to send
>>   * @recv_count:                Number of bytes still expected to receive
>> + * @curr_recv_count:   Number of bytes to be received in current transfer
> 
> Please do the alignment properly

Alignments are correct when you apply this patch.
Please let us know if you see any problem.

Thanks,
Michal
