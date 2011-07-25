From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 26 Jul 2011 00:58:31 +0900
Subject: [PATCH v3 2/3] mmc: core: add random fault injection
In-Reply-To: <1311199321-4618-3-git-send-email-per.forlin@linaro.org>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
	<1311199321-4618-3-git-send-email-per.forlin@linaro.org>
Message-ID: <CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/21 Per Forlin <per.forlin@linaro.org>:
> This adds support to inject data errors after a completed host transfer.
> The mmc core will return error even though the host transfer is successful.
> This simple fault injection proved to be very useful to test the
> non-blocking error handling in the mmc_blk_issue_rw_rq().
> Random faults can also test how the host driver handles pre_req()
> and post_req() in case of errors.

Looks good to me.

> @@ -82,6 +87,66 @@ static void mmc_flush_scheduled_work(void)
> ? ? ? ?flush_workqueue(workqueue);
> ?}
>
> +#ifdef CONFIG_FAIL_MMC_REQUEST
> +
> +static DECLARE_FAULT_ATTR(fail_mmc_request);

I think the fail_attr should be defined for each mmc_host like make_it_fail
in struct mmc_host and debugfs entries should also be created in a
subdirectory of mmc host debugfs.

And I know that init_fault_attr_dentries() can only create a
subdirectory in debugfs root directory.  But I have a patch which
support for creating it in arbitrary directory.  Could you take a look
at this? (Note that this patch is based on mmotm and not yet tested)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-fault-injection-support-for-creating-debugfs-entries.patch
Type: text/x-diff
Size: 6870 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110726/5e2e0b6b/attachment.bin>
