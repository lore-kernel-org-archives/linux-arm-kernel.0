From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 8 Oct 2013 18:34:42 -0700
Subject: [PATCH] DMA: extend documentation to provide more API details
In-Reply-To: <20131007103936.GH2954@intel.com>
References: <Pine.LNX.4.64.1310051925170.8097@axis700.grange>
 <20131005190200.GZ12758@n2100.arm.linux.org.uk>
 <Pine.LNX.4.64.1310052203060.8097@axis700.grange>
 <20131005233137.GA12758@n2100.arm.linux.org.uk>
 <20131006052029.GE2954@intel.com>
 <Pine.LNX.4.64.1310071233340.20796@axis700.grange>
 <20131007111728.GM12758@n2100.arm.linux.org.uk>
 <20131007103936.GH2954@intel.com>
Message-ID: <CAA9_cmdSh8j5rmzZ=SsOG_pRa+Aq1odEEWKvVNOUv9G0Ma=dEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 7, 2013 at 3:39 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Mon, Oct 07, 2013 at 12:17:28PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Oct 07, 2013 at 12:45:33PM +0200, Guennadi Liakhovetski wrote:
>> > No, not something in the middle. I was thinking about
>> >
>> > (1) cookie 1-3 are submitted
>> > (2) cookie 1 succeeds
>> > (3) a DMA error occurs, cookies 2-3 are discarded
> discarded using terminate_all right?
>
>> > (4) cookie 4 is submitted and succeeds
>> > (5) the user requests status of cookie 2 and gets success back, AFAICS
> No you cant!, you can only request for 4..
>>
>> This is a side effect of using a sequential cookie based system to indicate
>> whether a descriptor has succeeded or not.
> In the above case, since user calls terminate_all we can put a rule that
> terminate should reset the cookie counter.
> So after the terminate_all the cookies are sequentially valid!

I think you and Guennadi address this later in the thread, but I think
cookie values should always increase.  I see nothing but trouble if
cookie values are allowed to go backwards.

> Anyways as pointed above user shouldnt check for 2, he should have removed all
> refs till 3 before calling terminate.
>
>> What may be better is to change the wording here: not DMA_SUCCESS but
>> DMA_COMPLETED.  That doesn't imply that it has been successful, merely
>> that the DMA engine has finished with the transaction.
> Agreed that its not indication of success but of DMA completetion. I have seen
> cases where slave perhiphral got stuck while sending last FIFO but since DMA
> finished transferiing to FIFO it says complete.
>
> Dan do you agree?

Yes, it's an indication of completion, not necessarily success.

--
Dan
