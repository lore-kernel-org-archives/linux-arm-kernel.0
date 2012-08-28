From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 28 Aug 2012 11:38:23 +0300
Subject: [PATCH v2 05/11] USB: chipidea: don't let probe fail if otg
 controller start one role failed
In-Reply-To: <1346137397-32374-6-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-6-git-send-email-richard.zhao@freescale.com>
Message-ID: <87ligz2yyo.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> One role failed, but the other role will possiblly still work.
> For example, when udc start failed, if plug in a host device,
> it works.

If you're a host device, ci->role should be HOST at this point and
ci_role_start() shouldn't fail. If ci->role is detected wrongly, the
role detection must be fixed. If ci_role_start() fails for host, but it
still works when it's called again after the id pin change is detected,
again, the problem is elsewhere.

>
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  drivers/usb/chipidea/core.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
> index 19ef324..8fd390a 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -473,8 +473,11 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
>  	ret = ci_role_start(ci, ci->role);
>  	if (ret) {
>  		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
> -		ret = -ENODEV;
> -		goto rm_wq;
> +		ci->role = CI_ROLE_END;

So are you relying on id pin interrupt for initializing the role after
this? Can you provide more details?

Regards,
--
Alex
