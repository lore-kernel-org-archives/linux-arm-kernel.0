From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 20 Apr 2011 09:17:23 +0200
Subject: [PATCH v2 01/12] mmc: add none blocking mmc request function
In-Reply-To: <4DA81F42.3070208@csr.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1302116833-24540-2-git-send-email-per.forlin@linaro.org>
	<4DA81F42.3070208@csr.com>
Message-ID: <BANLkTimaTe0qD5sbEJj88YRv2DZv=1oxTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15 April 2011 12:34, David Vrabel <david.vrabel@csr.com> wrote:
> On 06/04/11 20:07, Per Forlin wrote:
>> Previously there has only been one function mmc_wait_for_req
>> to start and wait for a request. This patch adds
>> ?* mmc_start_req - starts a request wihtout waiting
>> ?* mmc_wait_for_req_done - waits until request is done
>> ?* mmc_pre_req - asks the host driver to prepare for the next job
>> ?* mmc_post_req - asks the host driver to clean up after a completed job
>
> If MMC core had a queue of requests internally you wouldn't need to
> provide mmc_pre_req() and mmc_post_req() functions outside of the core.
> ?i.e., the mmc block driver would just need to queue up two mmc requests
> and the core would take care of calling pre_req and post_req at the
> correct time.
>
Sorry for late response I have been out of office a couple of days.
Yes, it would be nice to not expose those hooks outside the core. I
will look into this in detail to see what it would take to implement
this and if there are any complications.

> Using a MMC request queue has other benefits -- it allows multiple users
> without having to claim/release the host. ?This would be useful for
> (especially multi-function) SDIO.
You mean claim and release would be done only within the mmc core. The
timed saved here would equal the time it takes to release and claim
the host.
Claim and release can also be used for power management to indicate if
any client is using the host, if not the power can be switched off.

> (especially multi-function) SDIO.
I just want to make sure I understand the multi-function SDIO case, I
haven't done any work with SDIO.
Can the SDIO functions compete over the same claim_host at the same time?
Example: if function 1 claims the host, function 2 and function 3 also
want to claim the host but have to wait for function 1 to release the
host.
What is the extra benefit of having the internal request queue for
multi function SDIO?
The functions must still wait for request completion before
acknowledge the SDIO client? Or could the functions acknowledge
immediately after the request is queued up in mmc core?

>
> David
> --
Thanks for your feedback,
Per
