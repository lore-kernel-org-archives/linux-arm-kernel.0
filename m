From: per.forlin@linaro.org (Per Forlin)
Date: Fri, 1 Jul 2011 15:33:19 +0200
Subject: [PATCH v8 06/12] mmc: mmc_test: test to measure how sg_len affect
	performance
In-Reply-To: <1309248717-14606-7-git-send-email-per.forlin@linaro.org>
References: <1309248717-14606-1-git-send-email-per.forlin@linaro.org>
	<1309248717-14606-7-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTimuvUcJyrO0S+Odmz2Vz0YDwyY9Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2011 10:11, Per Forlin <per.forlin@linaro.org> wrote:
> test that measures how the mmc bandwidth depends on the numbers of sg elements
> in the sg list. The transfer size if fixed and sg length goes from a few up
> to 512. The purpose is to measure overhead caused by multiple sg elements.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> ?drivers/mmc/card/mmc_test.c | ?151 +++++++++++++++++++++++++++++++++++++++----
> ?1 files changed, 139 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> -static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long sz,
> +static int mmc_test_map_sg(struct mmc_test_mem *mem, unsigned long size,
> ? ? ? ? ? ? ? ? ? ? ? ? ? struct scatterlist *sglist, int repeat,
> ? ? ? ? ? ? ? ? ? ? ? ? ? unsigned int max_segs, unsigned int max_seg_sz,
> - ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int *sg_len)
> + ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned int *sg_len, int min_sg_len)
> ?{
> ? ? ? ?struct scatterlist *sg = NULL;
> ? ? ? ?unsigned int i;
> + ? ? ? unsigned long sz = size;
>
> ? ? ? ?sg_init_table(sglist, max_segs);
> + ? ? ? if (min_sg_len > max_segs)
> + ? ? ? ? ? ? ? min_sg_len = max_segs;
>
> ? ? ? ?*sg_len = 0;
> ? ? ? ?do {
> ? ? ? ? ? ? ? ?for (i = 0; i < mem->cnt; i++) {
> ? ? ? ? ? ? ? ? ? ? ? ?unsigned long len = PAGE_SIZE << mem->arr[i].order;
>
> + ? ? ? ? ? ? ? ? ? ? ? if (min_sg_len && (size / min_sg_len < len))
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? len = size / min_sg_len;
Make aligned to 512
len = ALIGN(size / min_sg_len, 512);

I run into this issue running on arm realview with max test size 128k
instead of 128M.

/Per
