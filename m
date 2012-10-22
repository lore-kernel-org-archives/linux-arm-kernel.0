From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 10:53:01 +0200
Subject: [PATCH 07/10] pinctrl: remove mutex lock in groups show
In-Reply-To: <50808200.3080207@wwwdotorg.org>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-7-git-send-email-haojian.zhuang@gmail.com>
 <50808200.3080207@wwwdotorg.org>
Message-ID: <CACRpkdYV=xr8j_7E_mMTQ3m7SS_X0P4=NbO_QCWYZX+n1dRMww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 12:26 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/18/2012 03:07 AM, Haojian Zhuang wrote:
>> Mutex is locked duplicatly by pinconf_groups_show() and
>> pin_config_group_get(). It results dead lock. So avoid to lock mutex
>> in pinconf_groups_show().
>
> With this outer lock removed, how do we ensure that the pinctrl driver
> that is being called into remains loaded? Does the existence of the
> debugfs file ensure this, such that if it's open, the pinctrl driver
> can't be removed?

No, don't think so, dangling debugfs files is a common problem.

> Related, I wonder if much of the variable setup at the start of the
> function shouldn't happen inside the lock instead of outside:
>
> static int pinconf_groups_show(struct seq_file *s, void *what)
> {
>         struct pinctrl_dev *pctldev = s->private;
>         const struct pinctrl_ops *pctlops = pctldev->desc->pctlops;
>         const struct pinconf_ops *ops = pctldev->desc->confops;
>         unsigned ngroups = pctlops->get_groups_count(pctldev);
>
> since what if s->private is unregistered/destroyed while this function
> is running?

The debugfs code is fragile by nature I think, that's why we are
usually a bit relaxed here and it's also why it should be disabled
on production systems.

But any hardening patches are welcome, however we need to
get around the deadlock Haojian was seeing, maybe we should
introduce a separate debugfs mutex?

/me is slightly confused though...

Yours,
Linus Walleij
