From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Tue, 6 Sep 2011 17:52:19 +0530
Subject: [PATCH v8 04/16] DMA: PL330: Remove the start operation for
	handling DMA_TERMINATE_ALL command
In-Reply-To: <1314924284-25554-5-git-send-email-boojin.kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1314924284-25554-5-git-send-email-boojin.kim@samsung.com>
Message-ID: <CABb+yY1QN9CzT=CGJ1n-pk8_QyeEK1Sx=HT2n8SMB9O-XrsXDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 2, 2011 at 6:14 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
> Origianl code carries out the start operation after flush operation.
> But start operation is not required for DMA_TERMINATE_ALL command.
> So, This patch removes the unnecessary start operation and only carries out
> the flush oeration for handling DMA_TERMINATE_ALL command.

Not exactly. The 'start' is impotent when called from this path because there
is nothing left queued after the call to 'flush'.
pl330_tasklet() is called because that is a common function that does the
house-keeping acc to what's presently in 'work' and 'done' lists.

Though as a side-effect, your patch does avoid doing callbacks on submitted
xfers during DMA_TERMINATE_ALL - which may or may not be the right thing
to do.
I remember seeing some dmac drivers doing the callbacks while some
specifically avoiding them during DMA_TERMINATE_ALL.
While I personally prefer the former, I guess it's for maintainers to
decide. Vinod ?
