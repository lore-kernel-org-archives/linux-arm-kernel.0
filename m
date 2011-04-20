From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 20 Apr 2011 17:30:22 +0200
Subject: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
In-Reply-To: <20110420140120.GF1965@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
	<20110417164830.GE17935@S2100-06.ap.freescale.net>
	<BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
	<20110420140120.GF1965@S2100-06.ap.freescale.net>
Message-ID: <BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 April 2011 16:01, Shawn Guo <shawn.guo@freescale.com> wrote:
> On Wed, Apr 20, 2011 at 10:01:22AM +0200, Per Forlin wrote:
>> On 17 April 2011 18:48, Shawn Guo <shawn.guo@freescale.com> wrote:
>> > On Mon, Apr 18, 2011 at 12:33:30AM +0800, Shawn Guo wrote:
>> >> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
>> >> If not calling pre_req() before mxs_mmc_request(), request()
>> >> will prepare the cache just like it did it before.
>> >> It is optional to use pre_req() and post_req().
>> >>
>> >> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> >> ---
>> >> ?drivers/mmc/host/mxs-mmc.c | ? 75 ++++++++++++++++++++++++++++++++++++++++++--
>> >> ?1 files changed, 72 insertions(+), 3 deletions(-)
>> >>
>> >
>> > Here is the result of mmc_test case 37 ~ 40, which are designed to see
>> > the performance improvement introduced by non-blocking changes.
>> >
>> > Honestly, the improvement is not so impressive. ?Not sure if the patch
>> > for mxs-mmc pre_req and post_req support was correctly produced. ?So
>> > please help review ...
>> My guess is that dma_unmap is not run in parallel with transfer.
>> Please look at my patch reply.
>>
> Got it fixed in v2 posted just now. ?Please take another look.
> Unfortunately, I do not see noticeable difference than v1 in terms
> of mmc_test result.
>
Remove dma_map and dma_unmap from your host driver and run the tests
(obviously nonblocking and blocking will have the same results). If
there is still no performance gain the cache penalty is very small on
your platform and therefore nonblocking doesn't improve things much.
Please let me know the result.

BR,
Per
