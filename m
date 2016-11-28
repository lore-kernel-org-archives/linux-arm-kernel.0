From: eric@anholt.net (Eric Anholt)
Date: Mon, 28 Nov 2016 12:30:38 -0800
Subject: [PATCH V8 2/6] thermal: bcm2835: add thermal driver for bcm2835
 soc
In-Reply-To: <20161125052008.GA8342@localhost.localdomain>
References: <1478081906-12009-1-git-send-email-kernel@martin.sperl.org>
 <1478081906-12009-3-git-send-email-kernel@martin.sperl.org>
 <20161117021107.GA2647@localhost.localdomain>
 <766e1b70-d83a-eb52-fa2b-aec435e85673@martin.sperl.org>
 <20161117151019.GA3115@localhost.localdomain>
 <7957B3CC-0E18-4B27-82EB-EF88B7695E28@martin.sperl.org>
 <20161119042224.GA25063@localhost.localdomain>
 <28F93ABE-8210-4389-AE77-4D5E830E669B@martin.sperl.org>
 <20161125052008.GA8342@localhost.localdomain>
Message-ID: <87twarz6s1.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eduardo Valentin <edubezval@gmail.com> writes:

> Hello,
>
> On Tue, Nov 22, 2016 at 03:28:04PM +0100, Martin Sperl wrote:
>> Hi Eduardo!
>> 
>> On 19.11.2016 05:22, Eduardo Valentin wrote:
>> > Hello Martin,
>
> <cut>
>
>> 
>> I was asked to implement the "initialize" case just in case FW ever
>> stopped setting up the device itself, so that is why this code is
>> included.
>
> OK. Looks like we (like, we in the Linux side) do not understand the
> conditions that firmware fails to initialize the thermal device, but we
> still want to force an initialization, hoping to get the device in a sane
> state, even if we do not know if the firmware is correctly booted or
> not. And that is done silently, with no notification to user. I see.

The firmware today always initializes thermal.  I suggested adding the
init code because we (myself and the Pi Foundation) would like to reduce
how much closed firmware code is required in the platform, and the Linux
driver doing this would help make that possible in the future.

>> > Who has the ownership of this device?
>> 
>> Joined ownership I suppose...
>> 
>
> with no synchronization mechanism?

Correct, because none is necessary.

>> >> The above mentioned ?configuration if not running? reflect the values that
>> >> the FW is currently setting. We should not change those values as long as the
>> >> Firmware is also reading the temperature on its own.
>> > 
>> > hmm.. that looks like racy to me. Again, How do you synchronize accesses to
>> > this device? What if you configure the device and right after the
>> > firmware updates the configs? How do you make sure the configs you are
>> > writing here are the same used by the firmware? What if the firmware
>> > version changes? What versions of the firmware does this driver support?
>> > 
>> > Would it make sense to simply always initialize the device? Do you have
>> > a way to tell the firmware that it should not use the device?
>> > 
>> > Or, if you want to keep the device driver simply being a dummy reader,
>> > would it make sense to simply avoid writing configurations to the
>> > device, and simply retry to check if the firmware gets the device
>> > initialized?
>> 
>> Again: the device registers are only ever written if the device is not started
>> already. Otherwise the driver only reads for the ADC register, so there
>> is no real race here.
>> 
>
> and no race?
>
> To me, there is a race when you write to the config of this device,
> given that there is no sync between the two. We do not know if the
> firmware would be still attempting to initialize the device or not, do
> we? 

Either the device was initialized by the firmware before handing off to
ARM (today's firmware) or it never will be (potential future firmware).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161128/af046805/attachment.sig>
