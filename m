From: balbi@kernel.org (Felipe Balbi)
Date: Tue, 17 Jan 2017 12:45:19 +0200
Subject: [PATCH v3 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <DB5PR0401MB1813548526D3C8D34B9CCE52FE7C0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
References: <1482139554-13618-1-git-send-email-jerry.huang@nxp.com>
 <1482139554-13618-2-git-send-email-jerry.huang@nxp.com>
 <20161222184514.hfd4g7ifrz5cv627@rob-hp-laptop>
 <DB5PR0401MB1813E210B2ADE1C9493F7768FE950@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <CAL_JsqJuifiSQAt-6FgtYYSukAnjzOLuTGEsO-Spn5LxkU-iwQ@mail.gmail.com>
 <DB5PR0401MB18132BB4CDE32EEA8F479E55FE7D0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
 <87tw8zo0c0.fsf@linux.intel.com>
 <DB5PR0401MB1813548526D3C8D34B9CCE52FE7C0@DB5PR0401MB1813.eurprd04.prod.outlook.com>
Message-ID: <8737gikls0.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Jerry Huang <jerry.huang@nxp.com> writes:

<snip>

>> >> So, I think we still need two vaue to specify INCRBrstEna and INCRx
>> >> burst type.
>> > Hi, Balbi,
>> > It seems there is no feedback for my comment, so these patches can be
>> accepted?
>> 
>> probably not, we need to really understand what information we need so it
>> can be described properly. The last thing we want is unnecessary DT
>> properties.
>> 
>> It seems to me that we can extrapolate INCRBrstEna based on which burst
>> modes are enabled. If only 0 is passed, then that bit should be 1, if 0 and any
>> other size is passed, then that bit should be 0, no?
> Hi, Balbi,
> Below is the definition for this property,
> snps,incr-burst-type-adjustment = <x>, <y>
> x: Undefined Length INCR Burst Type Enable (INCRBrstEna)
>     0 - INCRX burst mode (not enable INCRBrstEna)
>     1 - INCR (undefined length) burst mode (enable INCRBrstEna)
> y: the burst length
>
> 1> if x = 0: means INCRBrstEna not enabled, set bit0 to zero (or clear
> it) , we select one of
> INCR1/INCR4/INCR8/INCR16/INCR32/INCR64/INCR128/INCR256 (pass this
> value through "y")to set the fix burst length controller supported.
>
> For example:
>
> 	snps,incr-burst-type-adjustment = <0>, <16>
>
> driver will set bit0 to zero and set bit3 to 1 (INCR16 Burst Type
> Enabled), controller will use INCR16 (with 16 bytes) to transfer data.
>
> 2> if x = 1: means INCRBrstEna enabled, we select one of
> INCR4/INCR8/INCR16/INCR32/INCR64/INCR128/INCR256 (pass this value
> through "y") to set the burst length, and controller will use any
> length less than or equal to that we selected.
>
> For example:
>
> 	snps,incr-burst-type-adjustment = <1>, <32>
>
> driver will set bit0 to 1 and set bit4 to 1 (INCR32 Burst Type
> Enabled), controller will use any burst length less than (such as 4,
> 8, 16 byte) or equal to 32 byte to transfer data.
>
> Therefore, I think this two fileds are needed. Do you think about it?

no, I don't think two values are needed, because first value can be
extrapolated from the second. Something like this:

	snps,incr-burst-type-adjustment = <4>, <8>, <16>, <32>;

This is basically telling us that we can support anything in this
list. So INCRBrstEna should be set to 1.

If DT, on the other hand, says:

	snps,incr-burst-type-adjustment = <32>;

this means that we can only support INCR32, so INCRBrstEna should be
cleared to 0.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/596669fd/attachment.sig>
