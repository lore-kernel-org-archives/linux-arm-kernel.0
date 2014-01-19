From: tj@kernel.org (Tejun Heo)
Date: Sun, 19 Jan 2014 06:38:38 -0500
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
Message-ID: <20140119113838.GE11123@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 19, 2014 at 12:48:50AM +0100, Hans de Goede wrote:
> @@ -126,7 +151,7 @@ static void ahci_put_clks(struct ahci_host_priv *hpriv)
>  static int ahci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct ahci_platform_data *pdata = dev_get_platdata(dev);
> +	const struct ahci_platform_data *pdata = ahci_get_pdata(dev);

Let's please not add const.  For data types which are known to be
terminal, const more or less works, I suppose but for anything even
mildly complicated it ends up being more of a headache.  C just
doesn't have enough language support to make const actually useful.
e.g. now if somebody wants to add an accessor to ahci_platform_data()
which is applicable to both readers and writers, we either need two
separate accessors for const and !const paths or have to cast away
const.

Thanks.

-- 
tejun
