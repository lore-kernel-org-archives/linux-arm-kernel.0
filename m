From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Sat, 05 Oct 2013 19:57:09 +0200
Subject: [PATCH|RFC] of: let of_match_device() always return best match
In-Reply-To: <CAOMZO5BekS_BvJzrt8vM1=7LjsiO=3hKL=mMfTjxkO3aZ4qwRQ@mail.gmail.com>
References: <1380826284-18381-1-git-send-email-mkl@pengutronix.de>
 <CAOMZO5BekS_BvJzrt8vM1=7LjsiO=3hKL=mMfTjxkO3aZ4qwRQ@mail.gmail.com>
Message-ID: <525052F5.5080204@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2013 07:46 PM, Fabio Estevam wrote:
> Hi Marc,
> 
> On Thu, Oct 3, 2013 at 3:51 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
>> For example:
>>
>> The imx28.dtsi gives this compatible string for its CAN core:
>>
>>>       compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
>>
>> The flexcan driver defines:
>>
>>> static const struct of_device_id flexcan_of_match[] = {
>>>       { .compatible = "fsl,p1010-flexcan", .data = &fsl_p1010_devtype_data, },
>>>       { .compatible = "fsl,imx28-flexcan", .data = &fsl_imx28_devtype_data, },
>>>       { .compatible = "fsl,imx6q-flexcan", .data = &fsl_imx6q_devtype_data, },
>>>       { /* sentinel */ },
>>> };
>>
>> The "p1010" was the first Freescale SoC with the flexcan core. But this SoC has
>> a bug, so a workaround has to be enabled in the driver. The mx28 has this bug
>> fixed, so we don't need this quite costly workaround.
> 
> What about defining in imx28.dtsi:
> compatible = "fsl,imx28-flexcan".

It already works with changing only the driver.

> and the in the flexcan driver we could do the same as in the fec_main driver:
> 
> static struct platform_device_id fec_devtype[] = {

For DT based probing I need to modify the struct of_device_id, but I got
the idea :)

>     {
>         /* keep it for coldfire */
>         .name = DRIVER_NAME,
>         .driver_data = 0,
>     }, {
>         .name = "imx25-fec",
>         .driver_data = FEC_QUIRK_USE_GASKET,
>     }, {
>         .name = "imx27-fec",
>         .driver_data = 0,
>     }, {
>         .name = "imx28-fec",
>         .driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_SWAP_FRAME,
>     }, {
>         .name = "imx6q-fec",
>         .driver_data = FEC_QUIRK_ENET_MAC | FEC_QUIRK_HAS_GBIT |
>                 FEC_QUIRK_HAS_BUFDESC_EX | FEC_QUIRK_HAS_CSUM |
>                 FEC_QUIRK_HAS_VLAN | FEC_QUIRK_ERR006358,
>     }, {
>         .name = "mvf600-fec",
>         .driver_data = FEC_QUIRK_ENET_MAC,
>     }, {
>         /* sentinel */
>     }
> };
> 
> So that we know which SoC needs to have the workaround applied or not.

I've already created a patch that rearranges the struct of_device_id in
the driver, works for me. I posted it (with another fix) for review on
linux-can[1].

Thanks,
Marc

[1] http://comments.gmane.org/gmane.linux.can/4050
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131005/12ed57bb/attachment.sig>
