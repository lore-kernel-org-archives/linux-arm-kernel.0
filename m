From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 18 Aug 2016 11:13:52 -0700
Subject: [PATCH 06/14] rpmsg: Indirect all virtio related function calls
In-Reply-To: <D0C04901035AEF47BB4C8387F4AA41F53C5D85@SAFEX1NODE23.st.com>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
 <1471306640-29917-7-git-send-email-bjorn.andersson@linaro.org>
 <D0C04901035AEF47BB4C8387F4AA41F53C5D85@SAFEX1NODE23.st.com>
Message-ID: <20160818181352.GV26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 18 Aug 05:14 PDT 2016, Loic PALLARDY wrote:

> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
[..]
> >  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
> >  					rpmsg_rx_cb_t cb, void *priv, u32
> > addr)
> >  {
> > -	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
> > +	return rpdev->create_ept(rpdev, cb, priv, addr);
> Hi Bjorn,
> 
> It will be good to test if pointer is valid before calling function.
> 

Per the rpmsg_send() implementation, I can make it loud but friendlier
by:

if (WARN_ON(!rpdev))
	return -EINVAL;

[..]
> > 
> > +static const struct rpmsg_device virtio_rpmsg_ops = {
> > +	.create_ept = virtio_rpmsg_create_ept,
> > +	.destroy_ept = virtio_rpmsg_destroy_ept,
> > +	.send = virtio_rpmsg_send,
> > +	.sendto = virtio_rpmsg_sendto,
> > +	.send_offchannel = virtio_rpmsg_send_offchannel,
> > +	.trysend = virtio_rpmsg_trysend,
> > +	.trysendto = virtio_rpmsg_trysendto,
> > +	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
> > +	.announce_create = virtio_rpmsg_announce_create,
> > +	.announce_destroy = virtio_rpmsg_announce_destroy,
> > +};
> Why not creating a dedicated ops struct like other framework?
> Here ops are mixed with other parameters.
> 

That's a good suggestion...

> > +
> >  /*
> >   * create an rpmsg channel using its name and address info.
> >   * this function will be used to create both static and dynamic
> > @@ -511,6 +568,9 @@ static struct rpmsg_device
> > *rpmsg_create_channel(struct virtproc_info *vrp,
> >  	if (!rpdev)
> >  		return NULL;
> > 
> > +	/* Assign callbacks for rpmsg_channel */
> > +	*rpdev = virtio_rpmsg_ops;
> It is not a simple affectation behind this operation, more a memcopy of the complete struct.
> Not easy to read from my pov.

...and would clean this up. I'll do that.

> > +
> >  	rpdev->vrp = vrp;
> >  	rpdev->src = chinfo->src;
> >  	rpdev->dst = chinfo->dst;
> > @@ -793,11 +853,17 @@ out:
> >  int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
> >  {
> >  	struct rpmsg_device *rpdev = ept->rpdev;
> > +
> > +	return rpdev->send(ept, data, len);
> Test pointer before using it

Yeah, this would follow from the earlier patch.

> 
> > +}
> > +
[..]
> > diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
[..]
> > u32);
> > +	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
> > +					    rpmsg_rx_cb_t cb, void *priv, u32
> > addr);
> > +	void (*destroy_ept)(struct rpmsg_endpoint *ept);
> > +
> > +	int (*send)(struct rpmsg_endpoint *ept, void *data, int len);
> > +	int (*sendto)(struct rpmsg_endpoint *ept, void *data, int len, u32
> > dst);
> > +	int (*send_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> > +				  void *data, int len);
> > +
> > +	int (*trysend)(struct rpmsg_endpoint *ept, void *data, int len);
> > +	int (*trysendto)(struct rpmsg_endpoint *ept, void *data, int len, u32
> > dst);
> > +	int (*trysend_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32
> > dst,
> > +			     void *data, int len);
> > +
> > +	int (*announce_create)(struct rpmsg_device *ept);
> > +	int (*announce_destroy)(struct rpmsg_device *ept);
> > +};
> It will be nice to document if ops are mandatory or optional.
> 

I'll break them out in a ops struct and throw in some kerneldoc in both
cases.

Thanks for the feedback!

Regards,
Bjorn
