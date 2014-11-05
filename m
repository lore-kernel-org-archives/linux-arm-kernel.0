From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 05 Nov 2014 14:19:22 +0100
Subject: [PATCH V2 1/4] can: m_can: update to support CAN FD features
In-Reply-To: <545A21AD.5040608@hartkopp.net>
References: <1415174326-6623-1-git-send-email-b29396@freescale.com>
 <5459F808.3020903@hartkopp.net>
 <20141105112639.GB4007@shlinux1.ap.freescale.net>
 <545A21AD.5040608@hartkopp.net>
Message-ID: <545A23DA.7030303@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 02:10 PM, Oliver Hartkopp wrote:
> On 05.11.2014 12:26, Dong Aisheng wrote:
>> On Wed, Nov 05, 2014 at 11:12:24AM +0100, Oliver Hartkopp wrote:
>>> On 05.11.2014 08:58, Dong Aisheng wrote:
> 
> 
>>> Unfortunately No. Here it becomes complicated due to the fact that
>>> the revision 3.0.x does not support per-frame switching for FD/BRS
>>> ...
>>
>> I'm not sure i got your point.
>>  From m_can spec, it allows switch CAN mode by setting CMR bit.
>>
>> Bits 11:10 CMR[1:0]: CAN Mode Request
>> A change of the CAN operation mode is requested by writing to this bit
>> field. After change to the
>> requested operation mode the bit field is reset to ?00? and the status
>> flags FDBS and FDO are set
>> accordingly. In case the requested CAN operation mode is not enabled,
>> the value written to CMR is
>> retained until it is overwritten by the next mode change request. In
>> case CME = ?01?/?10?/?11? a
>> change to CAN operation according to ISO 11898-1 is always possible.
>> Default is CAN operation
>> according to ISO11898-1.
>> 00 unchanged
>> 01 Request CAN FD operation
>> 10 Request CAN FD operation with bit rate switching
>> 11 Request CAN operation according ISO11898-1
>>
>> So what's the difference between this function and the per-frame
>> switching
>> you mentioned?
>>
>>>
>>> When (priv->can.ctrlmode & CAN_CTRLMODE_FD) is true this *only*
>>> tells us, that the controller is _capable_ to send either CAN or CAN
>>> FD frames.
>>>
>>> It does not configure the controller into one of these specific
>>> settings!
>>>
>>> Additionally: AFAIK when writing to the CCCR you have to make sure
>>> that there's currently no ongoing transfer.
>>>
>>
>> I don't know about it before.
>> By searching m_can user manual v302 again, i still did not find this
>> limitation. Can you point me if you know where it is?
>>
>> BTW, since we only use one Tx Buffer for transmission currently, so we
>> should not meet that case that CAN mode is switched during transfer.
>> So the issue you concern may not happen.
> 
> Yes. You are right. Having a FIFO with a size of 1 will help here :-)

Errrr....sorry...no.

Taking an easy route here but making it x times harder to extend the
driver to make use of the FIFO is not an option.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141105/d1e64e16/attachment-0001.sig>
