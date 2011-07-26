From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 27 Jul 2011 08:17:18 +0900
Subject: [PATCH v4 2/3] mmc: core: add random fault injection
In-Reply-To: <1311711119-6286-3-git-send-email-per.forlin@linaro.org>
References: <1311711119-6286-1-git-send-email-per.forlin@linaro.org>
	<1311711119-6286-3-git-send-email-per.forlin@linaro.org>
Message-ID: <CAC5umygcfno0-=rA9G0OcxuVK2YK9UokfoYoy45qBT8w0+ytvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/27 Per Forlin <per.forlin@linaro.org>:
> This adds support to inject data errors after a completed host transfer.
> The mmc core will return error even though the host transfer is successful.
> This simple fault injection proved to be very useful to test the
> non-blocking error handling in the mmc_blk_issue_rw_rq().
> Random faults can also test how the host driver handles pre_req()
> and post_req() in case of errors.

Looks good but I have one question.

> @@ -304,6 +307,10 @@ struct mmc_host {
>
> ? ? ? ?struct mmc_async_req ? ?*areq; ? ? ? ? ?/* active async req */
>
> +#ifdef CONFIG_FAIL_MMC_REQUEST
> + ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?make_it_fail;
> + ? ? ? struct fault_attr ? ? ? fail_mmc_request;
> +#endif
> ? ? ? ?unsigned long ? ? ? ? ? private[0] ____cacheline_aligned;
> ?};

I think make_it_fail is not needed anymore because if fail_attr is
defined per-host then you can enable it by setting probability=0
or times=0 per-host.
