From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Sun, 7 Apr 2013 15:50:45 +0300
Subject: [PATCH v9 1/6] rpmsg: Process all available messages in virtqueue
 callback
In-Reply-To: <1364521307-1219-2-git-send-email-rtivy@ti.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-2-git-send-email-rtivy@ti.com>
Message-ID: <CAK=WgbaCtACsvt9cqQmGqXsADFb_3bfnNKeWq9iijR2vkYVuQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 4:41 AM, Robert Tivy <rtivy@ti.com> wrote:
> Change virtqueue callback function rpmsg_recv_done() to process all
> available messages instead of just one message.
>
> Signed-off-by: Robert Tivy <rtivy@ti.com>

I'm thinking instead of adding an indentation level, let's split the
_recv function.

This is what I have in mind - let me know if it works for you - thanks:

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index a59684b..42b9872 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -776,22 +776,11 @@ out:
 }
 EXPORT_SYMBOL(rpmsg_send_offchannel_raw);

-/* called when an rx buffer is used, and it's time to digest a message */
-static void rpmsg_recv_done(struct virtqueue *rvq)
+static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
+                            struct rpmsg_hdr *msg, unsigned int len)
 {
-       struct rpmsg_hdr *msg;
-       unsigned int len;
        struct rpmsg_endpoint *ept;
        struct scatterlist sg;
-       struct virtproc_info *vrp = rvq->vdev->priv;
-       struct device *dev = &rvq->vdev->dev;
-       int err;
-
-       msg = virtqueue_get_buf(rvq, &len);
-       if (!msg) {
-               dev_err(dev, "uhm, incoming signal, but no used buffer ?\n");
-               return;
-       }

        dev_dbg(dev, "From: 0x%x, To: 0x%x, Len: %d, Flags: %d, Reserved: %d\n",
                                        msg->src, msg->dst, msg->len,
@@ -806,7 +795,7 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
        if (len > RPMSG_BUF_SIZE ||
                msg->len > (len - sizeof(struct rpmsg_hdr))) {
                dev_warn(dev, "inbound msg too big: (%d, %d)\n", len, msg->len);
-               return;
+               return -EINVAL;
        }

        /* use the dst addr to fetch the callback of the appropriate user */
@@ -842,9 +831,39 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
        err = virtqueue_add_buf(vrp->rvq, &sg, 0, 1, msg, GFP_KERNEL);
        if (err < 0) {
                dev_err(dev, "failed to add a virtqueue buffer: %d\n", err);
+               return err;
+       }
+
+       return 0;
+}
+
+/* called when an rx buffer is used, and it's time to digest a message */
+static void rpmsg_recv_done(struct virtqueue *rvq)
+{
+       struct virtproc_info *vrp = rvq->vdev->priv;
+       struct device *dev = &rvq->vdev->dev;
+       struct rpmsg_hdr *msg;
+       unsigned int len, msgs_received = 0;
+       int err;
+
+       msg = virtqueue_get_buf(rvq, &len);
+       if (!msg) {
+               dev_err(dev, "uhm, incoming signal, but no used buffer ?\n");
                return;
        }

+       while (msg) {
+               err = rpmsg_recv_single(vrp, dev, msg, len);
+               if (err)
+                       break;
+
+               msgs_received++;
+
+               msg = virtqueue_get_buf(rvq, &len);
+       };
+
+       dev_dbg(dev, "Received %u messages\n", msgs_received);
+
        /* tell the remote processor we added another available rx buffer */
        virtqueue_kick(vrp->rvq);
 }
