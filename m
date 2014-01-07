From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 7 Jan 2014 14:26:50 +0530
Subject: [PATCH 2/2] phy-core: Don't propagate -ENOSUPP from
 phy_pm_runtime_get_sync to caller
In-Reply-To: <1388963189-13556-2-git-send-email-hdegoede@redhat.com>
References: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
 <1388963189-13556-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52CBC152.3070403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 06 January 2014 04:36 AM, Hans de Goede wrote:
> The phy-core allows phy_init and phy_power_on to be called multiple times,
> but before this patch -ENOSUPP from phy_pm_runtime_get_sync would be
> propagated to the caller for the 2nd and later calls.

Thanks for fixing this. Have one minor comment below.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/phy/phy-core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index d7b992e..8ee6157 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -161,7 +161,8 @@ int phy_init(struct phy *phy)
>  			dev_err(&phy->dev, "phy init failed --> %d\n", ret);
>  			goto out;
>  		}
> -	}
> +	} else
> +		ret = 0; /* Override possible ret == -ENOTSUPP */

'should use braces in both branches'.
>  
>  out:
>  	mutex_unlock(&phy->mutex);
> @@ -209,7 +210,8 @@ int phy_power_on(struct phy *phy)
>  			dev_err(&phy->dev, "phy poweron failed --> %d\n", ret);
>  			goto out;
>  		}
> -	}
> +	} else
> +		ret = 0; /* Override possible ret == -ENOTSUPP */

same here..

Thanks
Kishon
