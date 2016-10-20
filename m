From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 20 Oct 2016 16:20:38 -0700
Subject: [PATCH v5 23/23] phy: Add support for Qualcomm's USB HS phy
In-Reply-To: <20161018015636.11701-24-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-24-stephen.boyd@linaro.org>
Message-ID: <147700563857.2550.16732518381302920183@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2016-10-17 18:56:36)
> +
> +static int
> +qcom_usb_hs_phy_vbus_notifier(struct notifier_block *nb, unsigned long event,
> +                             void *ptr)
> +{
> +       struct qcom_usb_hs_phy *uphy;
> +       int is_host;
> +       u8 addr;
> +
> +       uphy = container_of(nb, struct qcom_usb_hs_phy, vbus_notify);
> +       is_host = extcon_get_cable_state_(uphy->id_edev, EXTCON_USB_HOST);

Please don't apply this patch. This call now deadlocks on v4.9-rc1
because of how extcon_get_cable_state_() now grabs a lock that is
already held here when we're inside the notifier. It's not really
required that we grab the lock in extcon there, but this has exposed a
flaw in the logic anyway. We don't know if the id pin is going to toggle
before or after this function is called, so we should really keep track
of both vbus and id state in this driver and then do the same ulpi
writes from two different notifiers for both vbus and id pin. We would
be duplicating work sometimes, but that's pretty much the best solution
I can come up with. Otherwise it's racy.
