From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 20 Apr 2011 10:19:17 +0200
Subject: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
	latency
In-Reply-To: <20110416154841.GA17935@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<20110416154841.GA17935@S2100-06.ap.freescale.net>
Message-ID: <BANLkTi=c6Fh24W6u-ikRfnfV922OuJnJ9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 April 2011 17:48, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Per,
>
> On Wed, Apr 06, 2011 at 09:07:01PM +0200, Per Forlin wrote:
> [...]
>>
>> Per Forlin (12):
>> ? mmc: add none blocking mmc request function
>> ? mmc: mmc_test: add debugfs file to list all tests
>> ? mmc: mmc_test: add test for none blocking transfers
>> ? mmc: add member in mmc queue struct to hold request data
>> ? mmc: add a block request prepare function
>> ? mmc: move error code in mmc_block_issue_rw_rq to a separate function.
>> ? mmc: add a second mmc queue request member
>> ? mmc: add handling for two parallel block requests in issue_rw_rq
>> ? mmc: test: add random fault injection in core.c
>> ? omap_hsmmc: use original sg_len for dma_unmap_sg
>> ? omap_hsmmc: add support for pre_req and post_req
>> ? mmci: implement pre_req() and post_req()
>>
>> ?drivers/mmc/card/block.c ? ? ?| ?493 +++++++++++++++++++++++++++--------------
>> ?drivers/mmc/card/mmc_test.c ? | ?342 ++++++++++++++++++++++++++++-
>> ?drivers/mmc/card/queue.c ? ? ?| ?171 +++++++++------
>> ?drivers/mmc/card/queue.h ? ? ?| ? 31 ++-
>> ?drivers/mmc/core/core.c ? ? ? | ?132 ++++++++++-
>> ?drivers/mmc/core/debugfs.c ? ?| ? ?5 +
>> ?drivers/mmc/host/mmci.c ? ? ? | ?146 +++++++++++-
>> ?drivers/mmc/host/mmci.h ? ? ? | ? ?8 +
>> ?drivers/mmc/host/omap_hsmmc.c | ? 90 +++++++-
>> ?include/linux/mmc/core.h ? ? ?| ? ?9 +-
>> ?include/linux/mmc/host.h ? ? ?| ? 13 +-
>> ?lib/Kconfig.debug ? ? ? ? ? ? | ? 11 +
>> ?12 files changed, 1172 insertions(+), 279 deletions(-)
>>
> I'm playing the patch set and seeing the following warnings.
>
> ?CC ? ? ?drivers/mmc/card/block.o
> drivers/mmc/card/block.c: In function ?mmc_blk_issue_rq?:
> drivers/mmc/card/block.c:429:6: warning: ?status? may be used uninitialized in this function
>
My bad, it should be:
+ int status = 0;

> ?CC ? ? ?drivers/mmc/core/core.o
> drivers/mmc/core/core.c: In function ?mmc_request_done?:
> drivers/mmc/core/core.c:163:3: warning: passing argument 2 of ?mmc_should_fail_request? from incompatible pointer type
> drivers/mmc/core/core.c:129:20: note: expected ?struct mmc_data *? but argument is of type ?struct mmc_request *?
The function within #ifdef CONFIG_FAIL_MMC_REQUEST is the correct one.
I will update this in the next version.


>
> --
> Regards,
> Shawn
Thanks,
Per
