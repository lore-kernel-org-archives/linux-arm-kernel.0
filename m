From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Mar 2015 13:29:56 -0600
Subject: [PATCH 3/4 v4] mailbox: Enable BCM2835 mailbox support
In-Reply-To: <87wq2bk2ez.fsf@eliezer.anholt.net>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <1426213936-4139-3-git-send-email-eric@anholt.net>
 <5507A095.5090805@wwwdotorg.org> <87619xq414.fsf@eliezer.anholt.net>
 <550BA6B4.3030604@wwwdotorg.org> <87wq2bk2ez.fsf@eliezer.anholt.net>
Message-ID: <550C7534.8070100@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2015 11:24 AM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
>
>> On 03/18/2015 05:28 PM, Eric Anholt wrote:
>>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>>
>>>> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>>>>> diff --git a/drivers/mailbox/bcm2835-mailbox.c
>>>>> b/drivers/mailbox/bcm2835-mailbox.c
>>>>
>>>>> +#define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) &
>>>>> 0xf)) +#define MBOX_CHAN(msg)			((msg) & 0xf) +#define
>>>>> MBOX_DATA28(msg)		((msg) & ~0xf)
>>>>
>>>> Even the concept of storing channel IDs in the LSBs feels like it
>>>> might be RPi-firmware-specific rather than HW-specific?
>>>
>>> I guess?  If we found another firmware protocol, we could have
>>> that device's dt just specify a different compatible string.  But
>>> in the absence of another firmware to talk to, I'm not sure what
>>> you want here.
>>
>> I would expect the mailbox driver to expose a single channel that just
>> transports 32-bit values, since the HW doesn't impose any kind of
>> structure on the values it transports AFAIK. Clients of the mailbox
>> driver would formulate the messages they send through the mailox using
>> the macros above.
>>
>> I'm not sure whether the mailbox core allows multiple clients for the
>> same mailbox channel though? This HW appears to require it.
>
> Yeah, that's the problem.

I expect you'd end up representing the low-level mbox HW and the remote 
firmware as separate nodes in DT. There's certainly precedent for 
representing firmware in DT as a separate node. Perhaps something like:

// Exports just one channel, since there's 1 channel in HW
// Driver solely transports u32s through the registers and nothing else
// Driver allows a single client on the channel
mailbox: mailbox at 7e00b800 {
	compatible = "brcm,bcm2835-mbox";
	reg = <0x7e00b880 0x40>;
	interrupts = <0 1>;
	#mbox-cells = <1>;
};

// implements all RPI- (rather than bcm2835-)specific aspects of the
// firmware interface, such as merging data and channel ID into the data
// sent into the mailbox registers, handling multiple clients on a
// channel, etc.
firmware {
	compatible = "raspberrypi,firmware";
	mboxes = <&mailbox 8>;
};

The driver for the FW node could either register itself with all the 
relevant subsystems (power domains, clocks, ...) or in turn exports its 
services to other nodes like:

   firmware {
   	compatible = "raspberrypi,firmware";
   	mboxes = <&mailbox 8>;
+ 	#fw-cells = <1>; # or whatever's needed
   };

clocks {
	compatible = "raspberrypi,clocks";
	fw = <&firmware 0>; // or whatever channel # clocks are on
};
