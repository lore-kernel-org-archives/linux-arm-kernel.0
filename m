From: lakshmi.sai.krishna.potthuri@xilinx.com (Lakshmi Sai Krishna Potthuri)
Date: Tue, 22 Mar 2016 06:39:51 +0000
Subject: [LINUX PATCH 1/2] mtd: Added dummy entry in the spi_transfer
 structure.
In-Reply-To: <20160321130734.GS2566@sirena.org.uk>
References: <1458562809-36114-1-git-send-email-lakshmis@xilinx.com>
 <20160321130734.GS2566@sirena.org.uk>
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C5902C6D34C@XAP-PVEXMBX02.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

<snip>
>On Mon, Mar 21, 2016 at 05:50:08PM +0530, P L Sai Krishna wrote:
>> This patch does following things.
>> 1. Added dummy entry in the spi_transfer structure.
>> 2. Assigned dummy cycles to dummy member in the transfer structure
>> during read operation.
>
>Please try to follow the patch submission process covered in
>SubmittingPatches, in particular please use subject lines reflecting the style
>for the subsystem (which helps people identify relevant changes to
>review) and...
>
>>  drivers/mtd/devices/m25p80.c | 1 +
>>  include/linux/spi/spi.h      | 2 ++
>>  2 files changed, 3 insertions(+)
>
>...split things up into individual patches, for example here you're both adding a
>new feature and adding a user of that feature in a single patch.

I will split the patch into two with appropriate commit messages.

>
>> + * @dummy: number of dummy cycles.
>
>This needs to be clearer about what a dummy cycle is and where it gets
>inserted.  We probably also want a better name, just "dummy" makes it look
>like a padding field in the structure.  How about dummy_cycles?

dummy_cycles is a better idea.
I will change it and add the usage of this in the description in a detailed manner.

>
>> @@ -752,6 +753,7 @@ struct spi_transfer {
>>      u8              bits_per_word;
>>      u16             delay_usecs;
>>      u32             speed_hz;
>> +    u32             dummy;
>>
>>      struct list_head transfer_list;
>>  };
>
>This isn't enough to add the feature - a client driver trying to make use of this
>needs to be able to tell if the cycles are actually going to be inserted.  I'd
>expect to see a capability flag that can be checked and some error checking so
>that if we try to do a transfer with dummy cycles and can't support it we don't
>silently ignore the dummy cycles, ideally also something that'll handle
>multiples of 8 bits with SPI controllers that don't otherwise support this
>feature.

Currently, all fast reads use 8 cycles or 1 byte of dummy. This generally works.
But it can be vary based on the flash and the type of read command.
Dummy bytes are taken care of in m25p80.c by adjusting the len field:
Length = size of (command + address + dummy byte)

There might be controllers (like ZynqMP GQSPI) that would be able to use
the information that dummy byte(s) were added and the precise number
of dummy cycles. This patch does not disturb the existing implementation
of adjusting length (as described above). It adds an additional optional feature.
So there is no harm to controllers that can't support it - they can ignore it and
still work with the existing "length adjustment" implementation.
If you think there value in adding a capability flag, please let me know.

Thanks for your review.

Regards,
Sai Krishna


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
