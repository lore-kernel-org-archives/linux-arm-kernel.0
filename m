From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 08 Jul 2014 13:20:18 +0200
Subject: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
In-Reply-To: <20140708110820.GC21754@shlinux1.ap.freescale.net>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com>
 <53B69C55.8010901@pengutronix.de>
 <20140707071040.GA18505@shlinux1.ap.freescale.net>
 <53BA7543.70901@pengutronix.de>
 <20140708103009.GA21754@shlinux1.ap.freescale.net>
 <53BBCAE5.7040404@pengutronix.de>
 <20140708110820.GC21754@shlinux1.ap.freescale.net>
Message-ID: <53BBD3F2.5010806@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2014 01:08 PM, Dong Aisheng wrote:
> On Tue, Jul 08, 2014 at 12:41:41PM +0200, Marc Kleine-Budde wrote:
>> On 07/08/2014 12:30 PM, Dong Aisheng wrote:
>>>> Regarding the mram and the offsets:
>>>>
>>>>> 	fifo_addr = priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT_SIZE;
>>>>> 	fifo_addr = priv->mram_base + priv->mram_off + priv->txb_off;
>>>>
>>>> Why is rxf0_off used without the mram_off and txb_off with the mram_off?
>>>> Can you please test your driver with a mram offset != in your DT.
>>>>
>>>> If I understand the code in m_can_of_parse_mram() correctly the
>>>> individual *_off are already offsets to the *mram_base, so mram_off
>>>> should not be used within the driver.
>>>
>>> Good catch!
>>> You're right! I aslo found this recently!
>>> txb_off already includes the mram_off so should not plus mram_off again.
>>> The former test did not find it because it's still not exceed the 16K ram
>>> size for m_can0. But m_can1 has such issue.
>>>
>>>> I even think mram_off should be removed from the priv.
>>>
>>> Right, i also think so.
>>>
>>> It is used for debug information formerly that we need mram_off
>>> to calculate each element address in the fifo.
>>>
>>> By removing mram_off, i'm going to change the debug information to:
>>> dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 %x %d rxf1 %x %d rxb %x %d txe %x %d txb %x %d\n",
>>> 	priv->mram_base, priv->sidf_off, priv->sidf_elems,
>>> 	priv->xidf_off, priv->xidf_elems, priv->rxf0_off,
>>> 	priv->rxf0_elems, priv->rxf1_off, priv->rxf1_elems,
>>> 	priv->rxb_off, priv->rxb_elems, priv->txe_off,
>>> 	priv->txe_elems, priv->txb_off, priv->txb_elems);
>>>
>>> The annoying thing is the line has to be a much bigger one to avoid
>>> checkpatch warning of "WARNING: quoted string split across lines".
>>>
>>> What's your suggestion for such issue?
>>> Keeping the big line or split into two lines and leave checkpatch warning there?
>>
>> The idea behind the warning is, that you can grep for error messages
>> better, as normal grep wouldn't find an error string which spans two
>> lines. So make it a long line.
>>
>>>> Do the *_off and *_elems fit into a u8 or u16? If
>>>> so it makes sense to convert the priv accordingly.
>>>>
>>>
>>> Yes, *_off fit into u16 since MRAM has a maximum of 4352 words(17K).
>>> And *_elems fit into u8 since the max number is 128.
>>> I will change them accordingly.
>>>
>>>> What about putting the offset and the number of elements into a struct
>>>> and make use an array for rxf{0,1}?
>>>>
>>>
>>> You mean something like below?
>>> struct mram_cfg {
>>> 	u16 off;
>>> 	u8  elements;
>>> };
>>>
>>> struct m_can_priv {
>>> 	........
>>>
>>>         struct mram_cfg sidf;
>>>         struct mram_cfg xidf;
>>>         struct mram_cfg rxf0;
>>>         struct mram_cfg rxf1;
>>
>> struct mram_cfg rxf[2];
>>
> 
> It does not help too much and a bit strange for only make
> rxf0/rxf1 into array,
> 
> How about making them all:
> enum m_can_mram_cfg {
> 	SIDF = 0,
> 	XIDF,
> 	RXF0,
> 	RXF1,
> 	RXB,
> 	TXE,
> 	TXB,
> 	CFG_NUM,
> };
> 
> struct m_can_priv {
> 	........
> 	struct mram_cfg mcfg[CFG_NUM];
> };
> 
> Then in code:
> 
> priv->cfg[SIDF].off = 
> priv->cfg[SIDF].elements = 
> 
> But it could make code become much longer...

I like the idea, but can you add a common prefix to the enums. Though
makes the code even longer :)

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140708/55d16e8c/attachment.sig>
