From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Mon, 7 Jul 2014 04:12:15 -0700
Subject: Issue found in Armada 370: 10Mbps ethernet connection can't get IP
In-Reply-To: <20140707110014.3cbe98a0@free-electrons.com>
References: <CAB8gEUtaKwE5ax8_-+jb4pS08CO0V_CFdcEW47ej5YLaU=sb5A@mail.gmail.com>
 <20140707110014.3cbe98a0@free-electrons.com>
Message-ID: <CAB8gEUsipA--K8_XYjTO3TQtQEsUj8GHUyE6yLGkDMrqca8fHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
Good day.

Thank you very much for the quick feedback.
I will apply this patch and send you the results by tomorrow 07/08
morning (it is currently 07/07 evening as of this e-mail).

Regards,
Maggie Roxas

On Mon, Jul 7, 2014 at 2:00 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Maggie Mae Roxas,
>
> On Sun, 6 Jul 2014 19:56:27 -0700, Maggie Mae Roxas wrote:
>
>> We just found out last week that 10Mbps ethernet (SGMII) connection
>> can't obtain IP in recent kernel versions (3.10.x and above). Here are
>> the details:
>>
>> Processor: Armada 370 88F6707
>> Board: Custom
>> Kernel versions tried:
>> 3.10.24 (issue exists)
>> 3.13.9 (issue exists)
>> 3.2.43 (issue does NOT exist)
>> U-Boot versions tried: 2012_Q4 and 2013_Q1 from Marvell extranet
>>
>> Some more important notes:
>> Both 100Mbps and 1000Mbps have no issues.
>> Issue does not exist at u-boot level (via static IP address, confirmed
>> via ping - results: 'x.x.x.x is alive')
>> We have different LED configs for 10, 100 and 1000 Mbps - and LED
>> shows 10Mbps is established (even ethtool does). However, we just
>> can't obtain IP.
>> Our kernel version 3.2.43 have patches from Marvell extranet (for Armada 370)
>>
>> Is there a known issue for this?
>
> Thanks for the report. Can you test the patch below?
>
> Thanks,
>
> Thomas
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 45beca1..d49f08d 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2529,7 +2529,7 @@ static void mvneta_adjust_link(struct net_device *ndev)
>
>                         if (phydev->speed == SPEED_1000)
>                                 val |= MVNETA_GMAC_CONFIG_GMII_SPEED;
> -                       else
> +                       else if (phydev->speed == SPEED_100)
>                                 val |= MVNETA_GMAC_CONFIG_MII_SPEED;
>
>                         mvreg_write(pp, MVNETA_GMAC_AUTONEG_CONFIG, val);
>
>
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
