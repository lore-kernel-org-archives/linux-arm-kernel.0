From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Nov 2014 10:24:23 +0100
Subject: [PATCH V4 2/3] can: m_can: update to support CAN FD features
In-Reply-To: <5464E2D7.7010906@hartkopp.net>
References: <1415349914-9145-1-git-send-email-b29396@freescale.com>
 <1415349914-9145-2-git-send-email-b29396@freescale.com>
 <54648382.9080105@pengutronix.de> <5464E2D7.7010906@hartkopp.net>
Message-ID: <5465CA47.4020802@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2014 05:56 PM, Oliver Hartkopp wrote:
> On 11/13/2014 11:10 AM, Marc Kleine-Budde wrote:
>> On 11/07/2014 09:45 AM, Dong Aisheng wrote:
> 
>>>  
>>> -	if (id & RX_BUF_RTR) {
>>> +	if (id & RX_BUF_ESI) {
>>> +		cf->flags |= CANFD_ESI;
>>> +		netdev_dbg(dev, "ESI Error\n");
>>> +	}
>>> +
>>> +	if (!(dlc & RX_BUF_EDL) && (id & RX_BUF_RTR)) {
>>>  		cf->can_id |= CAN_RTR_FLAG;
>>
>> I just noticed, that you don't set the cf->dlc (or cf->len) in the RTR
>> case. Please create a separate patch that fixes this problem.
>>
>>>  	} else {
>>>  		id = m_can_fifo_read(priv, fgi, M_CAN_FIFO_DLC);
>>> -		cf->can_dlc = get_can_dlc((id >> 16) & 0x0F);
>>> -		*(u32 *)(cf->data + 0) = m_can_fifo_read(priv, fgi,
>>> -							 M_CAN_FIFO_DATA(0));
>>> -		*(u32 *)(cf->data + 4) = m_can_fifo_read(priv, fgi,
>>> -							 M_CAN_FIFO_DATA(1));
>>> +		if (dlc & RX_BUF_EDL)
>>> +			cf->len = can_dlc2len((id >> 16) & 0x0F);
>>> +		else
>>> +			cf->len = get_can_dlc((id >> 16) & 0x0F);
>>> +
> 
> Grr. I missed that one too :-(
> 
> Thanks for catching it.
> 
> As you committed patch 1 & 3 you expect a new single patch containing the
> (fixed) content of this patch 2, right?

No, please make it two patches:

First the Bugfix: One setting the cf->dlc in the RTR case, too.
Then the new feature: The other one adding CAN-FD support.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/16d2ef11/attachment.sig>
