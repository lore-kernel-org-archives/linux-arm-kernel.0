From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 15 May 2013 13:59:29 +0930
Subject: [PATCH V2 2/3] Documentation: virtio: Add emergency write
 (emerg_wr) config register in virtio console.
In-Reply-To: <CAAHg+Hi6BHqwOznnC9qxkc5pBWz7r5qpz9Nhh=EeNenhjhHohg@mail.gmail.com>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
 <1367842791-30285-3-git-send-email-pranavkumar@linaro.org>
 <8761yn382w.fsf@rustcorp.com.au>
 <CAAHg+Hi6BHqwOznnC9qxkc5pBWz7r5qpz9Nhh=EeNenhjhHohg@mail.gmail.com>
Message-ID: <87hai427di.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
> Hi Rusty,
>
> On 13 May 2013 08:22, Rusty Russell <rusty@rustcorp.com.au> wrote:
>> Pranavkumar Sawargaonkar <pranavkumar@linaro.org> writes:
>>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>>> ---
>>>  Documentation/virtual/virtio-spec.txt |    8 +++++++-
>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> OK, I applied this to the lyx master, with three changes:
>> 1) Changed "filed" to "field".
>> 2) Added ", or even acknowledging the feature" after "without
>>    initializing virtio queues".
>> 3) Added an initial point to the Device Initialization section:
>>
>>    1. If the VIRTIO_CONSOLE_F_EMERG_WRITE feature is offered, the
>>    emerg_wr field of the configuration can be written at any time. Thus
>>    it should work for very early boot debugging output as well as
>>    catastophic OS failures (eg. virtio ring corruption).
>
> Thanks for applying this patch.
> Have you also applied first patch ([PATCH V2 1/3] virtio: console: Add
> emergency writeonly register to config space)
> with this?  (https://lkml.org/lkml/2013/5/6/169)

Would like Amit's Ack, since he's de-facto console maintainer.

I've reproduced it below.

Cheers,
Rusty.

Subject: [PATCH V2 1/3] virtio: console: Add emergency writeonly register to config space
Date: Mon,  6 May 2013 17:49:49 +0530
Message-Id: <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
X-Gm-Message-State: ALoCoQmDOoCdPmDpT+VgLwYAlJHmkUTB8sEAHVSbrNxWBzYgPHFT9rQ2A9dR8fToM81cHDZDppGx

This patch adds an emerg_wr register (writeonly) in config space
of virtio console device which can be used for debugging.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/uapi/linux/virtio_console.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index ee13ab6..3fd0dce 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -38,6 +38,7 @@
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
+#define VIRTIO_CONSOLE_F_EMERG_WRITE 2 /* Does host support emergency write? */
 
 #define VIRTIO_CONSOLE_BAD_ID		(~(u32)0)
 
@@ -48,6 +49,8 @@ struct virtio_console_config {
 	__u16 rows;
 	/* max. number of ports this device can hold */
 	__u32 max_nr_ports;
+	/* emergency write register */
+	__u32 emerg_wr;
 } __attribute__((packed));
 
 /*
