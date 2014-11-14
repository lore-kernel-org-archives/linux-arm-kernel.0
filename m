From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri, 14 Nov 2014 09:54:37 +0100
Subject: [PATCH v2] can: Fix bug in suspend/resume
In-Reply-To: <e7070431858e49e29cd03d76fd7a66c3@BN1AFFO11FD055.protection.gbl>
References: <e7070431858e49e29cd03d76fd7a66c3@BN1AFFO11FD055.protection.gbl>
Message-ID: <5465C34D.4030805@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14/2014 09:16 AM, Kedareswara rao Appana wrote:
> The drvdata in the suspend/resume is of type struct net_device,
> not the platform device.Enable the clocks in the suspend before
> accessing the registers of the CAN.
> 
> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Changes for v2:
>   - Removed the struct platform_device* from suspend/resume
>     as suggest by Lothar.
>   - The clocks are getting disabled and un prepared at the end of the probe. 
>     In the suspend the driver is doing a register write.In order
>     To do that register write we have to again enable and prepare the clocks.

Please look the at suspend/resume code and count the
clock_enable/disable manually. After a suspend/resume cycle, you have
enabled the clock twice, but disabled it once.

I think you have to abstract the clock handling behind runtime PM. I
haven't done this myself yet, but the strong feeling that this is a
possible solution to your problem. These links might help:

http://lwn.net/Articles/505683/
http://www.slideshare.net/linaroorg/runtime-pm
http://www.slideshare.net/linaroorg/lca14-407-deployingruntimepmonarmsocs
http://www.slideshare.net/SamsungOSG/shuah-khan-lpcpmops

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/aed04c6b/attachment.sig>
