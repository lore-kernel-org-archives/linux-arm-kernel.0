From: socketcan@hartkopp.net (Oliver Hartkopp)
Date: Wed, 05 Nov 2014 14:10:05 +0100
Subject: [PATCH V2 1/4] can: m_can: update to support CAN FD features
In-Reply-To: <20141105112639.GB4007@shlinux1.ap.freescale.net>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
 <5459F808.3020903@hartkopp.net>
 <20141105112639.GB4007@shlinux1.ap.freescale.net>
Message-ID: <545A21AD.5040608@hartkopp.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.11.2014 12:26, Dong Aisheng wrote:
> On Wed, Nov 05, 2014 at 11:12:24AM +0100, Oliver Hartkopp wrote:
>> On 05.11.2014 08:58, Dong Aisheng wrote:


>> Unfortunately No. Here it becomes complicated due to the fact that
>> the revision 3.0.x does not support per-frame switching for FD/BRS
>> ...
>
> I'm not sure i got your point.
>  From m_can spec, it allows switch CAN mode by setting CMR bit.
>
> Bits 11:10 CMR[1:0]: CAN Mode Request
> A change of the CAN operation mode is requested by writing to this bit field. After change to the
> requested operation mode the bit field is reset to ?00? and the status flags FDBS and FDO are set
> accordingly. In case the requested CAN operation mode is not enabled, the value written to CMR is
> retained until it is overwritten by the next mode change request. In case CME = ?01?/?10?/?11? a
> change to CAN operation according to ISO 11898-1 is always possible. Default is CAN operation
> according to ISO11898-1.
> 00 unchanged
> 01 Request CAN FD operation
> 10 Request CAN FD operation with bit rate switching
> 11 Request CAN operation according ISO11898-1
>
> So what's the difference between this function and the per-frame switching
> you mentioned?
>
>>
>> When (priv->can.ctrlmode & CAN_CTRLMODE_FD) is true this *only*
>> tells us, that the controller is _capable_ to send either CAN or CAN
>> FD frames.
>>
>> It does not configure the controller into one of these specific settings!
>>
>> Additionally: AFAIK when writing to the CCCR you have to make sure
>> that there's currently no ongoing transfer.
>>
>
> I don't know about it before.
> By searching m_can user manual v302 again, i still did not find this
> limitation. Can you point me if you know where it is?
>
> BTW, since we only use one Tx Buffer for transmission currently, so we
> should not meet that case that CAN mode is switched during transfer.
> So the issue you concern may not happen.

Yes. You are right. Having a FIFO with a size of 1 will help here :-)

>
> Additionally it looks to me like m_can does allow set CMR bit at runtime
> since the mode change will take affect when controller becomes idle.
> See below:
>
> "A mode change requested by writing to CCCR.CMR will be executed next
> time the CAN protocol controller FSM reaches idle phase between CAN frames.
> Upon this event CCCR.CMR is reset to ?00? and the status flags CCCR.FDBS
> and CCCR.FDO are set accordingly. In case the requested
> CAN operation mode is not enabled, the value written to CCCR.CMR is
> retained until it is overwritten by the next mode change request.
> Default is CAN operation according to ISO11898-1."

Ah. I assumed we have to take care to set these bits in the idle state.

So when thinking about the one and only tx buffer your current approach should 
work indeed. Sorry for my confusion.

>
>> I would suggest the following approach to make the revision 3.0.x
>> act like a correct CAN FD capable controller:
>>
>> - create a helper function to switch FD and BRS while taking care of
>> ongoing transmissions
>>
>> - create a variable that knows the current tx_mode for FD and BRS
>>
>> When we need to send a CAN frame which doesn't fit the settings in
>> the tx_mode we need to switch the CCCR and update the tx_mode
>> variable.
>>
>> This at least reduces the needed CCCR operations.
>>
>
> Yes, i can do like that.
> But what i see by doing that is only reduces the needed CCCR operations?
> Any other benefits i missed?

No. I just thought about a function that also takes care of the idle phase to 
switch the bits. But now you made it clear that this is not needed - so you 
can stay on your current implementation: Setting the CCCR each time before 
sending the frame.

With the 3.1.x or 3.2.x this code will become obsolete then as the EDL and BRS 
seeting will get extra bits in the Tx Buffer.
But that's a future point.

> And the test for current code showed it seemed work well on the Mode
> switch among std frame/fd frame/brs frame.

Fine.

Btw. I would suggest to integrate patch [4/4] into [3/4].

Best regards,
Oliver
