From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 16 Jan 2013 11:23:57 +0100
Subject: [PATCH V3] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <20130113192428.GU23505@n2100.arm.linux.org.uk>
References: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
 <20130113192428.GU23505@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFrV8h+2ebfT6AK-ACfr716CE-f7+HGuh_+rOjbVnGOdfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2013 20:24, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 07, 2013 at 03:58:27PM +0100, Ulf Hansson wrote:
>> @@ -374,19 +415,12 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>>        * contiguous buffers.  On TX, we'll get a FIFO underrun error.
>>        */
>>       if (status & MCI_RXDATAAVLBLMASK) {
>> -             dmaengine_terminate_all(chan);
>> -             if (!data->error)
>> -                     data->error = -EIO;
>> -     }
>> -
>> -     if (data->flags & MMC_DATA_WRITE) {
>> -             dir = DMA_TO_DEVICE;
>> -     } else {
>> -             dir = DMA_FROM_DEVICE;
>> +             data->error = -EIO;
>> +             mmci_dma_data_error(host);
>
> Please explain the change of behaviour here.  Before your change, we _only_
> set data->error if the error is not set.  Here, we overwrite the error code
> no matter what.  What is the reasoning for that change?
>
> The reason the code is like it _was_ is so that any bytes remaining in the
> FIFO are _only_ reported as an error if there wasn't a preceding error.
> That is the behaviour I desired when I wrote this code.

Since we need to do dmaengine_terminate_all(chan), that will mean
another request could potentially already be prepared and thus it
could also be terminated.

Then by always reporting an error the async request handling in the
mmc protocol layer, can do proper error handling and clean up the
previously prepared request.

Kind regards
Ulf Hansson
