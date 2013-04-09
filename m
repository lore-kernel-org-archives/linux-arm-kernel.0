From: rtivy@ti.com (Tivy, Robert)
Date: Tue, 9 Apr 2013 20:56:54 +0000
Subject: [PATCH v9 1/6] rpmsg: Process all available messages in
 virtqueue callback
In-Reply-To: <CAK=WgbbpJuh8M4FLEgQKzbOPadJFHO=gvpA2jVOrN5N1g=1f2w@mail.gmail.com>
References: <1364521307-1219-1-git-send-email-rtivy@ti.com>
 <1364521307-1219-2-git-send-email-rtivy@ti.com>
 <CAK=WgbaCtACsvt9cqQmGqXsADFb_3bfnNKeWq9iijR2vkYVuQQ@mail.gmail.com>
 <13514BD7FAEBA745BBD7D8A672905C1431230345@DFLE12.ent.ti.com>
 <CAK=WgbbpJuh8M4FLEgQKzbOPadJFHO=gvpA2jVOrN5N1g=1f2w@mail.gmail.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C1431230582@DFLE12.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just one small fix needed (see below) and it's good-to-go.

> -----Original Message-----
> From: Ohad Ben-Cohen [mailto:ohad at wizery.com]
> Sent: Tuesday, April 09, 2013 1:26 AM
> 
> On Tue, Apr 9, 2013 at 1:56 AM, Tivy, Robert <rtivy@ti.com> wrote:
> > Shouldn't the virtqueue_kick() be called only when we successfully
> added a buffer with virtqueue_add_buf()?
> 
> Definitely, thanks for noticing!
> 
> Take 2:
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
> b/drivers/rpmsg/virtio_rpmsg_bus.c
> index a59684b..4ade672 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -776,22 +776,11 @@ out:
>  }
>  EXPORT_SYMBOL(rpmsg_send_offchannel_raw);
> 
> -/* called when an rx buffer is used, and it's time to digest a message
> */
> -static void rpmsg_recv_done(struct virtqueue *rvq)
> +static int rpmsg_recv_single(struct virtproc_info *vrp, struct device
> *dev,
> +                            struct rpmsg_hdr *msg, unsigned int len)
>  {
> -       struct rpmsg_hdr *msg;
> -       unsigned int len;
>         struct rpmsg_endpoint *ept;
>         struct scatterlist sg;
> -       struct virtproc_info *vrp = rvq->vdev->priv;
> -       struct device *dev = &rvq->vdev->dev;
> -       int err;

This new function also uses an 'int err;', so the above line should not be removed.

> -
> -       msg = virtqueue_get_buf(rvq, &len);
> -       if (!msg) {
> -               dev_err(dev, "uhm, incoming signal, but no used buffer
> ?\n");
> -               return;
> -       }
> 
>         dev_dbg(dev, "From: 0x%x, To: 0x%x, Len: %d, Flags: %d,
> Reserved: %d\n",
>                                         msg->src, msg->dst, msg->len,
> @@ -806,7 +795,7 @@ static void rpmsg_recv_done(struct virtqueue *rvq)
>         if (len > RPMSG_BUF_SIZE ||
>                 msg->len > (len - sizeof(struct rpmsg_hdr))) {
>                 dev_warn(dev, "inbound msg too big: (%d, %d)\n", len,
> msg->len);
> -               return;
> +               return -EINVAL;
>         }
> 
>         /* use the dst addr to fetch the callback of the appropriate
> user */
> @@ -842,11 +831,42 @@ static void rpmsg_recv_done(struct virtqueue
> *rvq)
>         err = virtqueue_add_buf(vrp->rvq, &sg, 0, 1, msg, GFP_KERNEL);
>         if (err < 0) {
>                 dev_err(dev, "failed to add a virtqueue buffer: %d\n",
> err);
> +               return err;
> +       }
> +
> +       return 0;
> +}
> +
> +/* called when an rx buffer is used, and it's time to digest a message
> */
> +static void rpmsg_recv_done(struct virtqueue *rvq)
> +{
> +       struct virtproc_info *vrp = rvq->vdev->priv;
> +       struct device *dev = &rvq->vdev->dev;
> +       struct rpmsg_hdr *msg;
> +       unsigned int len, msgs_received = 0;
> +       int err;
> +
> +       msg = virtqueue_get_buf(rvq, &len);
> +       if (!msg) {
> +               dev_err(dev, "uhm, incoming signal, but no used buffer
> ?\n");
>                 return;
>         }
> 
> +       while (msg) {
> +               err = rpmsg_recv_single(vrp, dev, msg, len);
> +               if (err)
> +                       break;
> +
> +               msgs_received++;
> +
> +               msg = virtqueue_get_buf(rvq, &len);
> +       };
> +
> +       dev_dbg(dev, "Received %u messages\n", msgs_received);
> +
>         /* tell the remote processor we added another available rx
> buffer */
> -       virtqueue_kick(vrp->rvq);
> +       if (msgs_received)
> +               virtqueue_kick(vrp->rvq);
>  }
> 
>  /*
> 
> > Thanks for the rewrite, looks better.  I'll give it a try and let you
> know how it goes.
> 
> Thanks!
> Ohad.

I added the above-mentioned 'int err;' to my tree's rpmsg_recv_single() and tested it out, it worked well.  So once that is corrected, you can add:
Acked-by: Robert Tivy <rtivy@ti.com>

Regards,

- Rob
