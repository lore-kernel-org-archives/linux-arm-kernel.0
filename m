From: per.forlin@linaro.org (Per Forlin)
Date: Fri, 1 Jul 2011 15:29:25 +0200
Subject: [PATCH v8 05/12] mmc: mmc_test: add test for non-blocking
	transfers
In-Reply-To: <1309248717-14606-6-git-send-email-per.forlin@linaro.org>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-6-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTi=-Nn0HjLgmTsCs9zoQt4By-6-KZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2011 10:11, Per Forlin <per.forlin@linaro.org> wrote:
> Add four tests for read and write performance per
> different transfer size, 4k to 4M.
> ?* Read using blocking mmc request
> ?* Read using non-blocking mmc request
> ?* Write using blocking mmc request
> ?* Write using non-blocking mmc request
>
> The host dirver must support pre_req() and post_req()
> in order to run the non-blocking test cases.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> ?drivers/mmc/card/mmc_test.c | ?311 +++++++++++++++++++++++++++++++++++++++++-
> ?1 files changed, 303 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> +static int mmc_test_nonblock_transfer(struct mmc_test_card *test,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct scatterlist *sg, unsigned sg_len,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned dev_addr, unsigned blocks,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned blksz, int write, int count)
> +{
> + ? ? ? struct mmc_request mrq1;
> + ? ? ? struct mmc_command cmd1;
> + ? ? ? struct mmc_command stop1;
> + ? ? ? struct mmc_data data1;
> +
> + ? ? ? struct mmc_request mrq2;
> + ? ? ? struct mmc_command cmd2;
> + ? ? ? struct mmc_command stop2;
> + ? ? ? struct mmc_data data2;
> +
> + ? ? ? struct mmc_test_async_req test_areq[2];
> + ? ? ? struct mmc_async_req *done_areq;
> + ? ? ? struct mmc_async_req *cur_areq = &test_areq[0].areq;
> + ? ? ? struct mmc_async_req *other_areq = &test_areq[1].areq;
> + ? ? ? int i;
> + ? ? ? int ret;
> +
> + ? ? ? test_areq[0].test = test;
> + ? ? ? test_areq[1].test = test;
> +
> + ? ? ? if (!test->card->host->ops->pre_req ||
> + ? ? ? ? ? ? ? !test->card->host->ops->post_req)
> + ? ? ? ? ? ? ? return -RESULT_UNSUP_HOST;
Remove this error check. It is fine to run this test without these
hooks, but there will be no performance gain compared to blocking
request.

...

> +/*
> + * Multiple blocking write 4k to 4 MB chunks
> + */
> +static int mmc_test_profile_mult_write_blocking_perf(struct mmc_test_card *test)
> +{
> + ? ? ? unsigned int bs[] = {1 << 12, 1 << 13, 1 << 14, 1 << 15, 1 << 16,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?1 << 17, 1 << 18, 1 << 19, 1 << 20, 1 << 22};
> + ? ? ? struct mmc_test_multiple_rw test_data = {
> + ? ? ? ? ? ? ? .bs = bs,
> + ? ? ? ? ? ? ? .size = 128*1024*1024,
I got this comment from Linus W.
Use TEST_AREA_MAX_SIZE instead of hard coded 128*1024*1024. update all
relevant functions.

/Per
