From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 18 Jul 2012 11:21:49 +0200
Subject: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
In-Reply-To: <20486.31827.477680.302450@ipc1.ka-ro>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de>
 <50061B86.7080200@gmail.com> <500675C2.9090303@pengutronix.de>
 <20486.31827.477680.302450@ipc1.ka-ro>
Message-ID: <5006802D.8070707@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 11:05 AM, Lothar Wa?mann wrote:
> Hi,
> 
> Marc Kleine-Budde writes:
>> On 07/18/2012 04:12 AM, Hui Wang wrote:
>>> Marc Kleine-Budde wrote:
>>>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>>
>>>> This patch add support for a second clock to the flexcan driver. On
>>>> modern
>>>> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and "per")
>>>> must be enabled in order to access the CAN core.
>>>> -        clock_freq = clk_get_rate(clk);
>>>>      }
>>>>  
>>>>      mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> @@ -1039,7 +1052,8 @@ static int __devinit flexcan_probe(struct
>>>> platform_device *pdev)
>>>>          CAN_CTRLMODE_BERR_REPORTING;
>>>>      priv->base = base;
>>>>      priv->dev = dev;
>>>> -    priv->clk = clk;
>>>> +    priv->clk_ipg = clk_ipg;
>>>> +    priv->clk_per = clk_per;
>>>>      priv->pdata = pdev->dev.platform_data;
>>>>      priv->devtype_data = devtype_data;
>>>>  
>>>> @@ -1067,9 +1081,11 @@ static int __devinit flexcan_probe(struct
>>>> platform_device *pdev)
>>>>   failed_map:
>>>>      release_mem_region(mem->start, mem_size);
>>>>   failed_get:
>>>> -    if (clk)
>>>> -        clk_put(clk);
>>>>   failed_clock:
>>>> +    if (clk_per)
>>>>   
>>> Use if (!IS_ERR(clk_per))
>>
>> Yes, good catch.
>>
>> Is it allowed to call clk_put with a NULL pointer? Both clocks can be
>> NULL, if the frequency is defined via the device tree, this is case for
>> powerpc.
>>
> This has been discussed here already several times. Everything
> returned by clk_get() that does not satisfy the IS_ERR() check, is a
> valid clk cookie and can be used for the clk API calls.

I've switched to devm completely (see Patch v2), so the clk_put is obsolete.

In this particular driver the NULL pointer in question is not returned
via the clk_get(). On powerpc we don't use clk_get(), because it's not
working (AFIAK) on the p1010 (the powerpc arch that has a flexcan).

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
Size: 262 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120718/34408bf6/attachment.sig>
