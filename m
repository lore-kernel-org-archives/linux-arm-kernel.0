From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 03 Oct 2013 23:51:23 +0200
Subject: [PATCH|RFC] of: let of_match_device() always return best match
In-Reply-To: <524DD5A6.6020204@gmail.com>
References: <1380826284-18381-1-git-send-email-mkl@pengutronix.de>
 <524DD5A6.6020204@gmail.com>
Message-ID: <524DE6DB.1070003@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/2013 10:37 PM, Rob Herring wrote:
> On 10/03/2013 01:51 PM, Marc Kleine-Budde wrote:
>> The function of_match_device() should tell if a struct device matches an
>> of_device_id list and return the specific entry of that table matches the
>> device best.
>>
>> The underlying __of_match_node() implements the wrong search algorithm. It
>> iterates over the list of of_device_ids, comparing the first compatible with
>> _all_ compatibles of the struct device, then the second compatible of
>> of_device_id and so on.
>>
>> This leads to a problem, if the device has more than one compatible that match
>> the of_device_id list. The implemented search algorithm may find not the "best"
>> match. As the compatible list in the device is sorted from most to least
>> specific.
>>
>> For example:
>>
>> The imx28.dtsi gives this compatible string for its CAN core:
>>
>>> 	compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
>>
>> The flexcan driver defines:
>>
>>> static const struct of_device_id flexcan_of_match[] = {
>>> 	{ .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
>>> 	{ .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
>>> 	{ .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
>>> 	{ /* sentinel */ },
>>> };
>>
>> The "p1010" was the first Freescale SoC with the flexcan core. But this SoC has
>> a bug, so a workaround has to be enabled in the driver. The mx28 has this bug
>> fixed, so we don't need this quite costly workaround.
>>
>> The __of_match_node() will compare:
>>
>>     from  of_device_id		from device
>>     fsl,p1010-flexcan		fsl,imx28-flexcan
>>     fsl,p1010-flexcan		fsl,p1010-flexcan	-> MATCH
>>
>> The of_match_device() function as it currently is implemented will always
>> return p1010 not the mx28.
>>
>> This patch fixes the problem by exchanging outer and inner loop. The first
>> compatible of a device is compared against all compatible from the of_device_id
>> list, then the second device compatible and so on.
> 
> This has been an issue for some time. A fix has been attempted before
> and reverted if you look at the git history:

..should have done this before creating the patch.

> commit bc51b0c22cebf5c311a6f1895fcca9f78efd0478
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Tue Jul 10 12:49:32 2012 -0700
> 
>     Revert "of: match by compatible property first"
> 
>     This reverts commit 107a84e61cdd3406c842a0e4be7efffd3a05dba6.
> 
>     Meelis Roos reports a regression since 3.5-rc5 that stops Sun Fire V100
>     and Sun Netra X1 sparc64 machines from booting, hanging after enabling
>     serial console.  He bisected it to commit 107a84e61cdd.
> 
>     Rob Herring explains:
>      "The problem is match combinations of compatible plus name and/or type
>       fail to match correctly.  I have a fix for this, but given how late it
>       is for 3.5 I think it is best to revert this for now.  There could be
>       other cases that rely on the current although wrong behavior.  I will
>       post an updated version for 3.6."
> 
>     Bisected-and-reported-by: Meelis Roos <mroos@linux.ee>
>     Requested-by: Rob Herring <rob.herring@calxeda.com>
>     Cc: Thierry Reding <thierry.reding@avionic-design.de>
>     Cc: Grant Likely <grant.likely@secretlab.ca>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
> There was also a fix attempted for this and the discussion here:
> 
> http://www.mail-archive.com/linuxppc-dev at lists.ozlabs.org/msg60163.html
> 
> You patch would hit the same issues I believe.

Yes probably, are the OF patterns from the failing sparcs available
somewhere, so that we can test a better implementation?

I'll rearrange the drivers instead. BTW: what about the patch you
mentioned in the above revert?

tnx,
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
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131003/6d4b1794/attachment-0001.sig>
