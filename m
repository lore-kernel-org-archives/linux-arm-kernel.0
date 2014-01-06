From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 06 Jan 2014 21:37:09 +0400
Subject: [PATCH 2/2] phy-core: Don't propagate -ENOSUPP from
 phy_pm_runtime_get_sync to caller
In-Reply-To: <1388963189-13556-2-git-send-email-hdegoede@redhat.com>
References: <1388963189-13556-1-git-send-email-hdegoede@redhat.com>
 <1388963189-13556-2-git-send-email-hdegoede@redhat.com>
Message-ID: <52CAE9C5.5050307@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06-01-2014 3:06, Hans de Goede wrote:

> The phy-core allows phy_init and phy_power_on to be called multiple times,
> but before this patch -ENOSUPP from phy_pm_runtime_get_sync would be
> propagated to the caller for the 2nd and later calls.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/phy/phy-core.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index d7b992e..8ee6157 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -161,7 +161,8 @@ int phy_init(struct phy *phy)
>   			dev_err(&phy->dev, "phy init failed --> %d\n", ret);
>   			goto out;
>   		}
> -	}
> +	} else
> +		ret = 0; /* Override possible ret == -ENOTSUPP */

    *else* arm should have {} when the *if* arm has it.

> @@ -209,7 +210,8 @@ int phy_power_on(struct phy *phy)
>   			dev_err(&phy->dev, "phy poweron failed --> %d\n", ret);
>   			goto out;
>   		}
> -	}
> +	} else
> +		ret = 0; /* Override possible ret == -ENOTSUPP */

    Same here.

WBR, Sergei
