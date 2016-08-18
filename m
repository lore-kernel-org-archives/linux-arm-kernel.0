From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 18 Aug 2016 11:04:34 -0700
Subject: [PATCH 03/14] rpmsg: rpmsg_send() operations takes rpmsg_endpoint
In-Reply-To: <D0C04901035AEF47BB4C8387F4AA41F53C5CB2@SAFEX1NODE23.st.com>
References: <1471306640-29917-1-git-send-email-bjorn.andersson@linaro.org>
 <1471306640-29917-4-git-send-email-bjorn.andersson@linaro.org>
 <D0C04901035AEF47BB4C8387F4AA41F53C5CB2@SAFEX1NODE23.st.com>
Message-ID: <20160818180434.GT26240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 18 Aug 00:36 PDT 2016, Loic PALLARDY wrote:

> 
> 
> > -----Original Message-----
> > From: linux-remoteproc-owner at vger.kernel.org [mailto:linux-remoteproc-
[..]
> > The rpmsg_send() operations has been taking a rpmsg_device, but this
> > forces users of secondary rpmsg_endpoints to use the rpmsg_sendto()
> > interface - by extracting source and destination from the given data
> > structures. If we instead pass the rpmsg_endpoint to these functions a
> > service can use rpmsg_sendto() to respond to messages, even on secondary
> > endpoints.
> > 
> > In addition this would allow us to support operations on multiple
> > channels in future backends that does not support off-channel
> > operations.
> > 
> Hi Bjorn,
> 
> This patch is modifying rpmsg API by using rpmsg_endpoint as argument
> instead of rpmsg_device.
> But associated port of rpmsg_client_sample driver is missing in your patch series.
> 

Right, I will update the sample code as well.

> Please find inline few comments.
> 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c |  4 +--
> >  include/linux/rpmsg.h            | 70 +++++++++++++++++++++++-----------------
> >  2 files changed, 42 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
> > b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index c4bd89ea7681..1b63f4b7c2bd 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -382,7 +382,7 @@ static int rpmsg_dev_probe(struct device *dev)
> >  		nsm.addr = rpdev->src;
> 
> Since endpoint is now used to indicate source, I'm wondering if it is possible
> to suppress src field from struct rpmsg_channel and rely only on endpoint addr?
> Else maybe confusing (which src addr used at the end: rpdev or ept?)
> 

The rpdev src and dst fields are used to pass information from
rpmsg_create_channel() to the probe() where we create the associated
endpoint. So I believe the rpdev has to carry this information, in some
way.

In this particular case I believe it would be better to use
rpdev->ept->addr, to clarify that we're announcing the primary endpoints
existence.

> >  		nsm.flags = RPMSG_NS_CREATE;
> > 
> > -		err = rpmsg_sendto(rpdev, &nsm, sizeof(nsm),
> > RPMSG_NS_ADDR);
> > +		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm),
> > RPMSG_NS_ADDR);
> >  		if (err)
> >  			dev_err(dev, "failed to announce service %d\n", err);
> >  	}
> > @@ -407,7 +407,7 @@ static int rpmsg_dev_remove(struct device *dev)
> >  		nsm.addr = rpdev->src;
> >  		nsm.flags = RPMSG_NS_DESTROY;
> > 
> > -		err = rpmsg_sendto(rpdev, &nsm, sizeof(nsm),
> > RPMSG_NS_ADDR);
> > +		err = rpmsg_sendto(rpdev->ept, &nsm, sizeof(nsm),
> > RPMSG_NS_ADDR);
> >  		if (err)
> >  			dev_err(dev, "failed to announce service %d\n", err);
> >  	}
> > diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
[..]
> > -static inline int rpmsg_send(struct rpmsg_channel *rpdev, void *data, int
> > len)
> > +static inline int rpmsg_send(struct rpmsg_endpoint *ept, void *data, int
> > len)
> >  {
> > -	u32 src = rpdev->src, dst = rpdev->dst;
> > +	struct rpmsg_channel *rpdev = ept->rpdev;
> > +	u32 src = ept->addr, dst = rpdev->dst;
> As this function is part of rpmsg API, it will be good to verify pointers before use.

I don't think we should be too friendly to miss-usage of the API, as
this would likely indicate a bug in the client.

That said, we can make it verbose and remove the panic by adding:

if (WARN_ON(!ept))
	return -EINVAL;

Does that sound okay?

[..]
> > +
> >  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, true);
> >  }
> > 
> >  /**
> >   * rpmsg_send() - send a message across to the remote processor
> Function name and description not aligned with code.
> Should be rpmsg_trysend
> May be in another patch...
> 

Yeah, I noticed this too, but not until it would be annoying to rebase
my patches ontop the change; so I was planning to fix that ontop, rather
than before this refactoring.

> > - * @rpdev: the rpmsg channel
> > + * @ept: the rpmsg endpoint
> >   * @data: payload of message
> >   * @len: length of payload
> >   *
> > - * This function sends @data of length @len on the @rpdev channel.
> > - * The message will be sent to the remote processor which the @rpdev
> > - * channel belongs to, using @rpdev's source and destination addresses.
> > + * This function sends @data of length @len on the @ept endpoint.
> > + * The message will be sent to the remote processor which the @ept
> > + * endpoint belongs to, using @ept's addres as source and its associated
> > + * rpdev's address as destination.
> >   * In case there are no TX buffers available, the function will immediately
> >   * return -ENOMEM without waiting until one becomes available.
> >   *

Thanks for your feedback.

Regards,
Bjorn
