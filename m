From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:29:14 +0100
Subject: [PATCH] mmc: mmci: Do not release spinlock in request_end
In-Reply-To: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20111013142914.GZ21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
> The patch "mmc: core: move ->request() call from atomic context",
> is the reason to why this change is possible. This simplifies the
> error handling code execution path quite a lot and potentially also
> fixes some error handling hang problems.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

This doesn't look right:

void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
{
        if (err && cmd->retries) {
                host->ops->request(host, mrq);

So, not dropping the spinlock results in calling the request function
with the spinlock held - and as the request function then goes on to
lock the spinlock, we will deadlock.

I don't see anything in current mainline which addresses this, so I'm
not able to queue this patch.
