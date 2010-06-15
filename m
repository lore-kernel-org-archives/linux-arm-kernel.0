From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Jun 2010 10:27:59 -0600
Subject: [PATCH 03/12] phylib: add a driver method for the SIOCSHWTSTAMP
	ioctl.
In-Reply-To: <77fe18d640e35dcbfad1e117a4321f935500d5ac.1276615626.git.richard.cochran@omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<77fe18d640e35dcbfad1e117a4321f935500d5ac.1276615626.git.richard.cochran@omicron.at>
Message-ID: <AANLkTiml5FyHstY-0ZPHxFDvA349BZv3TeX9gXtURFFN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> This patch adds a phy driver method for configuring hardware time stamping.
> Drivers may optionally implement this function.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Adding an ioctl to the userspace ABI.  Make sure you cc: linux-kernel
on the next spin of this series.

g.

> ---
> ?drivers/net/phy/phy.c | ? ?5 +++++
> ?include/linux/phy.h ? | ? ?3 +++
> ?2 files changed, 8 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index bd88d81..5130db8 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -361,6 +361,11 @@ int phy_mii_ioctl(struct phy_device *phydev,
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?break;
>
> + ? ? ? case SIOCSHWTSTAMP:
> + ? ? ? ? ? ? ? if (phydev->drv->hwtstamp)
> + ? ? ? ? ? ? ? ? ? ? ? return phydev->drv->hwtstamp(phydev, ifr);
> + ? ? ? ? ? ? ? /* fall through */
> +
> ? ? ? ?default:
> ? ? ? ? ? ? ? ?return -EOPNOTSUPP;
> ? ? ? ?}
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index d63736a..a5e9df1 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -402,6 +402,9 @@ struct phy_driver {
> ? ? ? ?/* Clears up any memory if needed */
> ? ? ? ?void (*remove)(struct phy_device *phydev);
>
> + ? ? ? /* Handles SIOCSHWTSTAMP ioctl for hardware time stamping. */
> + ? ? ? int (*hwtstamp)(struct phy_device *phydev, struct ifreq *ifr);
> +
> ? ? ? ?struct device_driver driver;
> ?};
> ?#define to_phy_driver(d) container_of(d, struct phy_driver, driver)
> --
> 1.6.3.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
