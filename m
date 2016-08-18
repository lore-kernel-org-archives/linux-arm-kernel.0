From: loic.pallardy@st.com (Loic PALLARDY)
Date: Thu, 18 Aug 2016 12:14:19 +0000
Subject: [PATCH 06/14] rpmsg: Indirect all virtio related function calls
In-Reply-To: <1471306640-29917-7-git-send-email-bjorn.andersson@linaro.org>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
 <1471306640-29917-7-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <D0C04901035AEF47BB4C8387F4AA41F53C5D85@SAFEX1NODE23.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-remoteproc-owner at vger.kernel.org [mailto:linux-remoteproc-
> owner at vger.kernel.org] On Behalf Of Bjorn Andersson
> Sent: Tuesday, August 16, 2016 2:17 AM
> To: Ohad Ben-Cohen <ohad@wizery.com>; Bjorn Andersson
> <bjorn.andersson@linaro.org>
> Cc: linux-remoteproc at vger.kernel.org; linux-arm-msm at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: [PATCH 06/14] rpmsg: Indirect all virtio related function calls
> 
> Create indirections for functions in prepration for splitting the rpmsg
> core functionality from the virtio backend.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/rpmsg/virtio_rpmsg_bus.c | 131
> +++++++++++++++++++++++++++++++++++----
>  include/linux/rpmsg.h            |  23 ++++++-
>  2 files changed, 139 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
> b/drivers/rpmsg/virtio_rpmsg_bus.c
> index a9f8cc8d968b..1dc7a1149c51 100644
> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> @@ -119,6 +119,17 @@ struct rpmsg_channel_info {
>  /* Address 53 is reserved for advertising remote services */
>  #define RPMSG_NS_ADDR			(53)
> 
> +static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int
> len);
> +static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int
> len,
> +			       u32 dst);
> +static int virtio_rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32
> src,
> +					u32 dst, void *data, int len);
> +static int virtio_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int
> len);
> +static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
> +				  int len, u32 dst);
> +static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept,
> u32 src,
> +					   u32 dst, void *data, int len);
> +
>  /* sysfs show configuration fields */
>  #define rpmsg_show_attr(field, path, format_string)			\
>  static ssize_t								\
> @@ -297,10 +308,17 @@ free_ept:
>  struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
>  					rpmsg_rx_cb_t cb, void *priv, u32
> addr)
>  {
> -	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
> +	return rpdev->create_ept(rpdev, cb, priv, addr);
Hi Bjorn,

It will be good to test if pointer is valid before calling function.

>  }
>  EXPORT_SYMBOL(rpmsg_create_ept);
> 
> +static struct rpmsg_endpoint *virtio_rpmsg_create_ept(struct
> rpmsg_device *rpdev,
> +						      rpmsg_rx_cb_t cb,
> +						      void *priv, u32 addr)
> +{
> +	return __rpmsg_create_ept(rpdev->vrp, rpdev, cb, priv, addr);
> +}
> +
>  /**
>   * __rpmsg_destroy_ept() - destroy an existing rpmsg endpoint
>   * @vrp: virtproc which owns this ept
> @@ -336,10 +354,15 @@ __rpmsg_destroy_ept(struct virtproc_info *vrp,
> struct rpmsg_endpoint *ept)
>   */
>  void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
>  {
> -	__rpmsg_destroy_ept(ept->rpdev->vrp, ept);
> +	ept->rpdev->destroy_ept(ept);
Ditto

>  }
>  EXPORT_SYMBOL(rpmsg_destroy_ept);
> 
> +static void virtio_rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
> +{
> +	__rpmsg_destroy_ept(ept->rpdev->vrp, ept);
> +}
> +
>  /*
>   * when an rpmsg driver is probed with a channel, we seamlessly create
>   * it an endpoint, binding its rx callback to a unique local rpmsg
> @@ -352,7 +375,6 @@ static int rpmsg_dev_probe(struct device *dev)
>  {
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
>  	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
> -	struct virtproc_info *vrp = rpdev->vrp;
>  	struct rpmsg_endpoint *ept;
>  	int err;
> 
> @@ -373,6 +395,18 @@ static int rpmsg_dev_probe(struct device *dev)
>  		goto out;
>  	}
> 
> +	if (rpdev->announce_create)
> +		err = rpdev->announce_create(rpdev);
> +out:
> +	return err;
> +}
> +
> +static int virtio_rpmsg_announce_create(struct rpmsg_device *rpdev)
> +{
> +	struct virtproc_info *vrp = rpdev->vrp;
> +	struct device *dev = &rpdev->dev;
> +	int err = 0;
> +
>  	/* need to tell remote processor's name service about this channel ?
> */
>  	if (rpdev->announce &&
>  	    virtio_has_feature(vrp->vdev, VIRTIO_RPMSG_F_NS)) {
> @@ -387,15 +421,13 @@ static int rpmsg_dev_probe(struct device *dev)
>  			dev_err(dev, "failed to announce service %d\n", err);
>  	}
> 
> -out:
>  	return err;
>  }
> 
> -static int rpmsg_dev_remove(struct device *dev)
> +static int virtio_rpmsg_announce_destroy(struct rpmsg_device *rpdev)
>  {
> -	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> -	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
>  	struct virtproc_info *vrp = rpdev->vrp;
> +	struct device *dev = &rpdev->dev;
>  	int err = 0;
> 
>  	/* tell remote processor's name service we're removing this channel
> */
> @@ -412,6 +444,18 @@ static int rpmsg_dev_remove(struct device *dev)
>  			dev_err(dev, "failed to announce service %d\n", err);
>  	}
> 
> +	return err;
> +}
> +
> +static int rpmsg_dev_remove(struct device *dev)
> +{
> +	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> +	struct rpmsg_driver *rpdrv = to_rpmsg_driver(rpdev->dev.driver);
> +	int err = 0;
> +
> +	if (rpdev->announce_destroy)
> +		err = rpdev->announce_destroy(rpdev);
> +
>  	rpdrv->remove(rpdev);
> 
>  	rpmsg_destroy_ept(rpdev->ept);
> @@ -485,6 +529,19 @@ static int rpmsg_device_match(struct device *dev,
> void *data)
>  	return 1;
>  }
> 
> +static const struct rpmsg_device virtio_rpmsg_ops = {
> +	.create_ept = virtio_rpmsg_create_ept,
> +	.destroy_ept = virtio_rpmsg_destroy_ept,
> +	.send = virtio_rpmsg_send,
> +	.sendto = virtio_rpmsg_sendto,
> +	.send_offchannel = virtio_rpmsg_send_offchannel,
> +	.trysend = virtio_rpmsg_trysend,
> +	.trysendto = virtio_rpmsg_trysendto,
> +	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
> +	.announce_create = virtio_rpmsg_announce_create,
> +	.announce_destroy = virtio_rpmsg_announce_destroy,
> +};
Why not creating a dedicated ops struct like other framework?
Here ops are mixed with other parameters.

> +
>  /*
>   * create an rpmsg channel using its name and address info.
>   * this function will be used to create both static and dynamic
> @@ -511,6 +568,9 @@ static struct rpmsg_device
> *rpmsg_create_channel(struct virtproc_info *vrp,
>  	if (!rpdev)
>  		return NULL;
> 
> +	/* Assign callbacks for rpmsg_channel */
> +	*rpdev = virtio_rpmsg_ops;
It is not a simple affectation behind this operation, more a memcopy of the complete struct.
Not easy to read from my pov.
> +
>  	rpdev->vrp = vrp;
>  	rpdev->src = chinfo->src;
>  	rpdev->dst = chinfo->dst;
> @@ -793,11 +853,17 @@ out:
>  int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int len)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpdev->send(ept, data, len);
Test pointer before using it

> +}
> +
> +static int virtio_rpmsg_send(struct rpmsg_endpoint *ept, void *data, int
> len)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
>  	u32 src = ept->addr, dst = rpdev->dst;
> 
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
>  }
> -EXPORT_SYMBOL(rpmsg_send);
> 
>  /**
>   * rpmsg_sendto() - send a message across to the remote processor, specify
> dst
> @@ -820,11 +886,19 @@ EXPORT_SYMBOL(rpmsg_send);
>  int rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int len, u32 dst)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpdev->sendto(ept, data, len, dst);
Ditto

> +}
> +EXPORT_SYMBOL(rpmsg_sendto);
> +
> +static int virtio_rpmsg_sendto(struct rpmsg_endpoint *ept, void *data, int
> len,
> +			       u32 dst)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
>  	u32 src = ept->addr;
> 
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
>  }
> -EXPORT_SYMBOL(rpmsg_sendto);
> 
>  /**
>   * rpmsg_send_offchannel() - send a message using explicit src/dst
> addresses
> @@ -851,10 +925,18 @@ int rpmsg_send_offchannel(struct rpmsg_endpoint
> *ept, u32 src, u32 dst,
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> 
> -	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
> +	return rpdev->send_offchannel(ept, src, dst, data, len);
>  }
>  EXPORT_SYMBOL(rpmsg_send_offchannel);
> 
> +static int virtio_rpmsg_send_offchannel(struct rpmsg_endpoint *ept, u32
> src,
> +					u32 dst, void *data, int len)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
> +}
> +
>  /**
>   * rpmsg_send() - send a message across to the remote processor
>   * @ept: the rpmsg endpoint
> @@ -875,11 +957,18 @@ EXPORT_SYMBOL(rpmsg_send_offchannel);
>  int rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int len)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpdev->trysend(ept, data, len);
ditto
> +}
> +EXPORT_SYMBOL(rpmsg_trysend);
> +
> +static int virtio_rpmsg_trysend(struct rpmsg_endpoint *ept, void *data, int
> len)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
>  	u32 src = ept->addr, dst = rpdev->dst;
> 
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>  }
> -EXPORT_SYMBOL(rpmsg_trysend);
> 
>  /**
>   * rpmsg_sendto() - send a message across to the remote processor, specify
> dst
> @@ -901,11 +990,19 @@ EXPORT_SYMBOL(rpmsg_trysend);
>  int rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data, int len, u32
> dst)
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpdev->trysendto(ept, data, len, dst);
ditto
> +}
> +EXPORT_SYMBOL(rpmsg_trysendto);
> +
> +static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
> +				  int len, u32 dst)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
>  	u32 src = ept->addr;
> 
>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>  }
> -EXPORT_SYMBOL(rpmsg_trysendto);
> 
>  /**
>   * rpmsg_send_offchannel() - send a message using explicit src/dst
> addresses
> @@ -931,10 +1028,18 @@ int rpmsg_trysend_offchannel(struct
> rpmsg_endpoint *ept, u32 src, u32 dst,
>  {
>  	struct rpmsg_device *rpdev = ept->rpdev;
> 
> -	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
> +	return rpdev->trysend_offchannel(ept, src, dst, data, len);
ditto
>  }
>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
> 
> +static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept,
> u32 src,
> +					   u32 dst, void *data, int len)
> +{
> +	struct rpmsg_device *rpdev = ept->rpdev;
> +
> +	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
> +}
> +
>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>  			     struct rpmsg_hdr *msg, unsigned int len)
>  {
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 3e3d5b1c154a..0b290ae18e70 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -96,6 +96,10 @@ enum rpmsg_ns_flags {
>  #define RPMSG_ADDR_ANY		0xFFFFFFFF
> 
>  struct virtproc_info;
> +struct rpmsg_device;
> +struct rpmsg_endpoint;
> +
> +typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
> u32);
> 
>  /**
>   * rpmsg_device - device that belong to the rpmsg bus
> @@ -115,9 +119,24 @@ struct rpmsg_device {
>  	u32 dst;
>  	struct rpmsg_endpoint *ept;
>  	bool announce;
> -};
> 
> -typedef void (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *,
> u32);
> +	struct rpmsg_endpoint *(*create_ept)(struct rpmsg_device *rpdev,
> +					    rpmsg_rx_cb_t cb, void *priv, u32
> addr);
> +	void (*destroy_ept)(struct rpmsg_endpoint *ept);
> +
> +	int (*send)(struct rpmsg_endpoint *ept, void *data, int len);
> +	int (*sendto)(struct rpmsg_endpoint *ept, void *data, int len, u32
> dst);
> +	int (*send_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32 dst,
> +				  void *data, int len);
> +
> +	int (*trysend)(struct rpmsg_endpoint *ept, void *data, int len);
> +	int (*trysendto)(struct rpmsg_endpoint *ept, void *data, int len, u32
> dst);
> +	int (*trysend_offchannel)(struct rpmsg_endpoint *ept, u32 src, u32
> dst,
> +			     void *data, int len);
> +
> +	int (*announce_create)(struct rpmsg_device *ept);
> +	int (*announce_destroy)(struct rpmsg_device *ept);
> +};
It will be nice to document if ops are mandatory or optional.

Regards,
Loic
> 
>  /**
>   * struct rpmsg_endpoint - binds a local rpmsg address to its user
> --
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-remoteproc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
