From: javi.merino@arm.com (Javi Merino)
Date: Tue, 15 Nov 2011 15:51:18 +0000
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't
 any active transfer
In-Reply-To: <CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
 <CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>
Message-ID: <4EC28A76.7080606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/11 07:51, Jassi Brar wrote:
> On 2 November 2011 20:00, Javi Merino <javi.merino@arm.com> wrote:
>> If there are no transactions running it is not only wrong but
>> potentially dangerous to call the callbacks.
>>
> The idea was to have dmac drivers not touch the xfer after it has been submitted
> and before the callback is made upon successful transmission or abort/flush.

Right.

>> There can be a stale struct pl330_req pointer from a previous run, but the
>> memory may be free already.
>>
> Sorry I am unable to fathom the scenario. The pl330_request_channel resets
> both pl330_req pointers. Maybe some real failure you saw, could help
> me understand.

You request a channel, submit a xfer, it finishes successfully and
pl330_update() is called, which calls r->xfer_cb() and marks the request
as done by making req->mc_len = 0 .  Then, if you call
pl330_release_channel(), _callback(thrd->req[0].r, PL330_ERR_ABORT) is
called and, as thrd_req[0].r and thrd_req[0].r->xfer_cb are not null,
r->xfer_cb() is called again.  That's wrong, the xfer finished (maybe
long time ago) and the callback was called back then.  You shouldn't
call it again with an error.  You should only do so if the transfer was
running or scheduled to run, that's why I suggest calling _callback() if
!IS_FREE(req).

I'm not sure if this was clear enough, but I always hit this when
releasing channels that I've used.  Cheers,
Javi

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
