From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 7 Sep 2011 13:19:05 +0530
Subject: [PATCH v8 04/16] DMA: PL330: Remove the start operation for
	handling DMA_TERMINATE_ALL command
In-Reply-To: <000c01cc6d2e$fa01d8d0$ee058a70$%kim@samsung.com>
References: <1314924284-25554-1-git-send-email-boojin.kim@samsung.com>
	<1314924284-25554-5-git-send-email-boojin.kim@samsung.com>
	<CABb+yY1QN9CzT=CGJ1n-pk8_QyeEK1Sx=HT2n8SMB9O-XrsXDg@mail.gmail.com>
	<20110906122718.GP6619@n2100.arm.linux.org.uk>
	<CAJe_ZhfaYmgPFhU-KJ3Oj6jdPN0i584yzziSzQzd_6uNSXodHQ@mail.gmail.com>
	<000c01cc6d2e$fa01d8d0$ee058a70$%kim@samsung.com>
Message-ID: <CAJe_ZhefAqspzm8nKKVdKkhorYVLJnLwdmmfUtq41gGczMRPnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 September 2011 12:53, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Jassi Brar wrote:
>>
>> On 6 September 2011 17:57, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > On Tue, Sep 06, 2011 at 05:52:19PM +0530, Jassi Brar wrote:
>> >> On Fri, Sep 2, 2011 at 6:14 AM, Boojin Kim <boojin.kim@samsung.com> wrote:
>> >> > Origianl code carries out the start operation after flush operation.
>> >> > But start operation is not required for DMA_TERMINATE_ALL command.
>> >> > So, This patch removes the unnecessary start operation and only carries out
>> >> > the flush oeration for handling DMA_TERMINATE_ALL command.
>> >>
>> >> Not exactly. The 'start' is impotent when called from this path because there
>> >> is nothing left queued after the call to 'flush'.
>> >> pl330_tasklet() is called because that is a common function that does the
>> >> house-keeping acc to what's presently in 'work' and 'done' lists.
>> >>
>> >> Though as a side-effect, your patch does avoid doing callbacks on submitted
>> >> xfers during DMA_TERMINATE_ALL - which may or may not be the right thing
>> >> to do.
>> >
>> > It is defined that DMA_TERMINATE_ALL does not call the callbacks:
>> >
>> > 1. int dmaengine_terminate_all(struct dma_chan *chan)
>> >
>> > ? This causes all activity for the DMA channel to be stopped, and may
>> > ? discard data in the DMA FIFO which hasn't been fully transferred.
>> > ? No callback functions will be called for any incomplete transfers.
>> >
>> Ok, thanks for the info.
>>
>> Boojin Kim, please re-write the changelog to state only preventing
>> callbacks during DMA_TERMINATE_ALL as the reason.
>
> As above, we don't need callback as well start operation in DMA_TERMIANTE_ALL command and her patch just removed them for DMA_TERMINATE_ALL here. So current git message seems to have proper behavior of patch.
>
Nopes.

No modification to current code is needed if only the following is to
be the reason.
{
Origianl code carries out the start operation after flush operation.
But start operation is not required for DMA_TERMINATE_ALL command.
So, This patch removes the unnecessary start operation and only carries out
the flush oeration for handling DMA_TERMINATE_ALL command.
}

The patch, however, has unintended good effect of "preventing callbacks
from DMA_TERMINATE_ALL".
The only valid reason, and which is no way implied by the changelog.
