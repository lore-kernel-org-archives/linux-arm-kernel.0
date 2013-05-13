From: maarten.lankhorst@canonical.com (Maarten Lankhorst)
Date: Mon, 13 May 2013 10:00:52 +0200
Subject: Introduce a new helper framework for buffer synchronization
In-Reply-To: <CAAQKjZNNw4qddo6bE5OY_CahrqDtqkxdO7Pm9RCguXyj9F4cMQ@mail.gmail.com>
References: <CAAQKjZNNw4qddo6bE5OY_CahrqDtqkxdO7Pm9RCguXyj9F4cMQ@mail.gmail.com>
Message-ID: <51909DB4.2060208@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 09-05-13 09:33, Inki Dae schreef:
> Hi all,
>
> This post introduces a new helper framework based on dma fence. And the
> purpose of this post is to collect other opinions and advices before RFC
> posting.
>
> First of all, this helper framework, called fence helper, is in progress
> yet so might not have enough comments in codes and also might need to be
> more cleaned up. Moreover, we might be missing some parts of the dma fence.
> However, I'd like to say that all things mentioned below has been tested
> with Linux platform and worked well.

> ....
>
> And tutorial for user process.
>         just before cpu access
>                 struct dma_buf_fence *df;
>
>                 df->type = DMA_BUF_ACCESS_READ or DMA_BUF_ACCESS_WRITE;
>                 ioctl(fd, DMA_BUF_GET_FENCE, &df);
>
>         after memset or memcpy
>                 ioctl(fd, DMA_BUF_PUT_FENCE, &df);
NAK.

Userspace doesn't need to trigger fences. It can do a buffer idle wait, and postpone submitting new commands until after it's done using the buffer.
Kernel space doesn't need the root hole you created by giving a dereferencing a pointer passed from userspace.
Your next exercise should be to write a security exploit from the api you created here. It's the only way to learn how to write safe code. Hint: df.ctx = mmap(..);

~Maarten
