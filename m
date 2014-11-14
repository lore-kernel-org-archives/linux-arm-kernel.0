From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Nov 2014 16:35:05 +0100
Subject: [PATCH v2] can: Fix bug in suspend/resume
In-Reply-To: <8d29d376aa02429dabd754b505fb336d@BN1BFFO11FD041.protection.gbl>
References: <e7070431858e49e29cd03d76fd7a66c3@BN1AFFO11FD055.protection.gbl>
 <5465C34D.4030805@pengutronix.de>
 <e5f5913b51a54222aa1bb0680a77e56d@BN1AFFO11FD055.protection.gbl>
 <54661B2F.2000704@pengutronix.de>
 <8d29d376aa02429dabd754b505fb336d@BN1BFFO11FD041.protection.gbl>
Message-ID: <54662129.3020907@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 04:20 PM, S?ren Brinkmann wrote:
>>>> Please look the at suspend/resume code and count the
>>>> clock_enable/disable manually. After a suspend/resume cycle, you have
>>>> enabled the clock twice, but disabled it once.
>>>>
>>>> I think you have to abstract the clock handling behind runtime PM. I
>>>> haven't done this myself yet, but the strong feeling that this is a
>>>> possible solution to your problem. These links might help:
>>>
>>> I agree, the clock handling looks weird. Also the clk_disable calls in
>>> xcan_get_berr_counter() look suspicious to me, but I might be wrong.
>>> I think you can take a look at gpio-zynq for an example for runtime_pm
>>> usage. I think the usage model in that driver is similar to here.
>>
>> The xcan_get_berr_counter() function is correct, when doing manual (i.e.
>> non runtime-pm) clock handling. This function might be called if the
>> interface is down, this means clocks are disabled.
> 
> I see, thanks for the clarification. Guess that should become
> pm_runtime_get_sync() and pm_runtime_put() when converting to
> runtime_pm.

Yes, as far as I understand runtime pm.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/9605cd8f/attachment.sig>
