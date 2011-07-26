From: per.forlin@linaro.org (Per Forlin)
Date: Tue, 26 Jul 2011 22:08:25 +0200
Subject: [PATCH v3 2/3] mmc: core: add random fault injection
In-Reply-To: <CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
References: <1311199321-4618-1-git-send-email-per.forlin@linaro.org>
	<1311199321-4618-3-git-send-email-per.forlin@linaro.org>
	<CAC5umyg44tQxrFEYRL-tjzBMA2+KNXjB+nQveH3KcB_LPmYVHw@mail.gmail.com>
Message-ID: <CAJ0pr18wJ4YiPu9emO9acLDhVpfzDm7UQB-F3C+Vzy84bnJKrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 July 2011 17:58, Akinobu Mita <akinobu.mita@gmail.com> wrote:
> 2011/7/21 Per Forlin <per.forlin@linaro.org>:
>> This adds support to inject data errors after a completed host transfer.
>> The mmc core will return error even though the host transfer is successful.
>> This simple fault injection proved to be very useful to test the
>> non-blocking error handling in the mmc_blk_issue_rw_rq().
>> Random faults can also test how the host driver handles pre_req()
>> and post_req() in case of errors.
>
> Looks good to me.
>
>> @@ -82,6 +87,66 @@ static void mmc_flush_scheduled_work(void)
>> ? ? ? ?flush_workqueue(workqueue);
>> ?}
>>
>> +#ifdef CONFIG_FAIL_MMC_REQUEST
>> +
>> +static DECLARE_FAULT_ATTR(fail_mmc_request);
>
> I think the fail_attr should be defined for each mmc_host like make_it_fail
> in struct mmc_host and debugfs entries should also be created in a
> subdirectory of mmc host debugfs.
>
> And I know that init_fault_attr_dentries() can only create a
> subdirectory in debugfs root directory. ?But I have a patch which
> support for creating it in arbitrary directory. ?Could you take a look
> at this? (Note that this patch is based on mmotm and not yet tested)
>
I tested your patch on a Snowball board. I had two active mmc cards
and did various fault injection configurations on the two cards
together with dd. I did only test MMC IO fault injection and not any
of the other fault injection clients.
Tested-by: Per Forlin <per.forlin@linaro.org>

Regards,
Per
