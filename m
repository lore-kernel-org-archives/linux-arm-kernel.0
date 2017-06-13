From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 13 Jun 2017 12:24:42 +0200
Subject: [PATCH v15 2/7] power: add power sequence library
In-Reply-To: <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
References: <1497319166-17287-1-git-send-email-peter.chen@nxp.com>
 <1497319166-17287-3-git-send-email-peter.chen@nxp.com>
Message-ID: <CAPDyKFpOQWTPpdd__OBP1DcW58CbqnygGAOxiEFq5kqqvCm0QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> +
> +/**
> + * of_pwrseq_on - Carry out power sequence on for device node
> + *
> + * @np: the device node would like to power on
> + *
> + * Carry out a single device power on.  If multiple devices
> + * need to be handled, use of_pwrseq_on_list() instead.
> + *
> + * Return a pointer to the power sequence instance on success,
> + * or an error code otherwise.
> + */
> +struct pwrseq *of_pwrseq_on(struct device_node *np)
> +{
> +       struct pwrseq *pwrseq;
> +       int ret;
> +
> +       pwrseq = pwrseq_find_available_instance(np);
> +       if (!pwrseq)
> +               return ERR_PTR(-ENOENT);

In case the pwrseq instance hasn't been registered yet, then there is
no way to deal with -EPROBE_DEFER properly here.

I haven't been following the discussions in-depth during all
iterations, so perhaps you have already discussed why doing it like
this.

Anyway, that means all pwrseq instances needs to be registered an
early boot level, to be safe. To me, that seems like poor design
choice.

[...]

Otherwise I think this looks okay to me.

Kind regards
Uffe
