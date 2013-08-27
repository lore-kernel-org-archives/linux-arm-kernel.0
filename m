From: s-anna@ti.com (Suman Anna)
Date: Tue, 27 Aug 2013 11:03:25 -0500
Subject: [PATCHv3 7/8] mailbox/omap: add code to support the wkupm3
 operations
In-Reply-To: <87li3n6bcc.fsf@linaro.org>
References: <1375825238-18299-1-git-send-email-s-anna@ti.com>
 <87li3n6bcc.fsf@linaro.org>
Message-ID: <521CCDCD.90207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On 08/26/2013 10:50 PM, Kevin Hilman wrote:
> Suman Anna <s-anna@ti.com> writes:
> 
>> The WkupM3 mailbox used for triggering PM operations such as suspend
>> and resume on AM33x/AM43x is special in that the M3 processor cannot
>> access the mailbox registers. However, an interrupt is needed to be
>> sent to request the M3 to perform a desired PM operation. This patch
>> adds the support for this special mailbox through separate ops for
>> this mailbox. These ops are designed to have the WkupM3's Rx interrupt
>> programmed within the driver, during transmission of a message. The
>> message is immediately read back and the internal mailbox interrupt
>> acknowledged as well to avoid triggering any spurious interrupts to
>> the M3.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> 
> Dumb Q: why does all this extra logic belong in the mailbox driver and
> not in the wkup_m3 driver?  To me, this seems like part of the IPC
> protocol between the MPU and M3 firmware, and not an inherent part of
> the AM33xx mbox.

The IPC protocol state machine for the PM operations is still very much
handled in the WkupM3 driver. The IPC registers in Control module
provide the messaging payloads, but unfortunately it is not associated
with any direct interrupts to make it a separate driver. As far as the
WkupM3 driver is concerned, it is just using the mailbox for signalling
- the internals of which would involve accessing the various mailbox
registers including interrupt configuration and clearing. It is
preferable to have the various operations on mailbox registers handled
by the mailbox driver with the API supporting the necessary operations.

The previous version from Vaibhav added a new API to mailbox driver for
clearing out the Tx fifo, which is non-standard. The mailboxes on AM335
will also be used for IPC with the Programmable Real-time Unit (PRU)
subsystem, which will use separate mbox devices. This version handles
the wkup_m3 mbox device using its device-specific ops without the need
for any new API, and not having to expose the mailbox registers outside.

regards
Suman
