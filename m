From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2012 08:48:32 +0000
Subject: [PATCH v4 10/10] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
References: <1331740593-10807-1-git-send-email-thierry.reding@avionic-design.de>
 <1331740593-10807-11-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <201203150848.32500.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 March 2012, Thierry Reding wrote:
> +
> +       pwm = of_pwm_request(node, "pwm", 0);
> +       if (IS_ERR(pwm))
> +               return PTR_ERR(pwm);

It's interesting that the (so far) only user of of_pwm_request() doesn't
actually give a meaningful argument as the name of the pwm property.

Maybe rename that function to of_pwm_request_named() and provide a helper
that just does this:?

static inline struct pwm_device *of_pwm_request(struct device_node *np, int index)
{
	return of_pwm_request_named(np, "pwm", index);
}

Any device that just has needs one pwm or uses more than one but has no
reason to name them can just use this helper then and use the default pwm
property name.

	Arnd
