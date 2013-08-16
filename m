From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 16 Aug 2013 13:28:56 -0700
Subject: [PATCH RFC 1/3] spmi: Linux driver framework for SPMI
In-Reply-To: <20130816202110.GJ4035@joshc.qualcomm.com>
References: <cover.1376596224.git.joshc@codeaurora.org>
 <02deef1d90121011ab1df90ad704ef0ee36e2584.1376596224.git.joshc@codeaurora.org>
 <20130816184921.GB31510@kroah.com>
 <20130816202110.GJ4035@joshc.qualcomm.com>
Message-ID: <20130816202856.GA20882@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 03:21:10PM -0500, Josh Cartwright wrote:
> On Fri, Aug 16, 2013 at 11:49:21AM -0700, Greg Kroah-Hartman wrote:
> > On Fri, Aug 09, 2013 at 01:37:09PM -0700, Josh Cartwright wrote:
> > > +++ b/drivers/spmi/spmi.c
> > > @@ -0,0 +1,449 @@
> [..]
> > > +static void spmi_ctrl_release(struct device *dev)
> > > +{
> > > +	struct spmi_controller *ctrl = to_spmi_controller(dev);
> > > +	complete(&ctrl->dev_released);
> > 
> > When is this memory going to be freed?
> > 
> > Ah, you think it will be when you remove the device later on:
> > 
> > > +int spmi_del_controller(struct spmi_controller *ctrl)
> > > +{
> > > +	struct spmi_controller *found;
> > > +
> > > +	if (!ctrl)
> > > +		return -EINVAL;
> > > +
> > > +	/* Check that the ctrl has been added */
> > > +	mutex_lock(&board_lock);
> > > +	found = idr_find(&ctrl_idr, ctrl->nr);
> > > +	mutex_unlock(&board_lock);
> > > +
> > > +	if (found != ctrl)
> > > +		return -EINVAL;
> > > +
> > > +	spmi_dfs_del_controller(ctrl);
> > > +
> > > +	/* Remove all the clients associated with this controller */
> > > +	mutex_lock(&board_lock);
> > > +	bus_for_each_dev(&spmi_bus_type, NULL, ctrl, spmi_ctrl_remove_device);
> > > +	idr_remove(&ctrl_idr, ctrl->nr);
> > > +	mutex_unlock(&board_lock);
> > > +
> > > +	init_completion(&ctrl->dev_released);
> > > +	device_unregister(&ctrl->dev);
> > > +	wait_for_completion(&ctrl->dev_released);
> > 
> > But you just leaked memory, right?
> > 
> > You should never have to wait for this to happen, why did you need to
> > add this?  Why not just a simple call to kfree() in the release
> > function?
> 
> Unfortunately, the reason why this was necessary may be lost to history.  :(
> 
> I'll do some testing with the completion removed and a simple kfree() in
> the release and see if there is any fallout.

There will be, you need to fix up the calling logic and the driver to
prevent memory that it thinks it still has access to, from going away
(that was my hint for the other patch you sent.)

thanks,

greg k-h
