From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 15 Nov 2011 22:30:59 +0530
Subject: [PATCH 1/4] ARM: PL330: Don't call the callbacks if there isn't
 any active transfer
In-Reply-To: <4EC28A76.7080606@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
 <CAJe_Zhf+PAeM+wquQykXNDG74Nc+jQNXrp+RLMKSySCNPum8Tg@mail.gmail.com>
 <4EC28A76.7080606@arm.com>
Message-ID: <CABb+yY1atyLA8Ej57JBEM0JL3oK5e6+1vO0UH5VTNiBsKQPueA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2011 at 9:21 PM, Javi Merino <javi.merino@arm.com> wrote:
> On 15/11/11 07:51, Jassi Brar wrote:
>>> There can be a stale struct pl330_req pointer from a previous run, but the
>>> memory may be free already.
>>>
>> Sorry I am unable to fathom the scenario. The pl330_request_channel resets
>> both pl330_req pointers. Maybe some real failure you saw, could help
>> me understand.
>
> You request a channel, submit a xfer, it finishes successfully and
> pl330_update() is called, which calls r->xfer_cb() and marks the request
> as done by making req->mc_len = 0 . ?Then, if you call
> pl330_release_channel(), _callback(thrd->req[0].r, PL330_ERR_ABORT) is
> called and, as thrd_req[0].r and thrd_req[0].r->xfer_cb are not null,
> r->xfer_cb() is called again. ?That's wrong, the xfer finished (maybe
> long time ago) and the callback was called back then. ?You shouldn't
> call it again with an error. ?You should only do so if the transfer was
> running or scheduled to run, that's why I suggest calling _callback() if
> !IS_FREE(req).
>
Usually flush is called before releasing the channel, which would
have taken care of it. But I agree, flush shouldn't be necessary.

MARK_FREE(_pl330_req)  with _pl330_req.r != NULL   doesn't look neat.
So maybe we should move   _pl330_req.r = NULL   into MARK_FREE macro.
Which would require moving 'struct list_head rqd' from _pl330_req to
pl330_req, that should be ok though I think.
