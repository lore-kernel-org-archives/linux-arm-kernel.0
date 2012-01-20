From: greg@kroah.com (Greg KH)
Date: Fri, 20 Jan 2012 13:10:55 -0500
Subject: [PATCH 2/6] drivers/base: add bus for System-on-Chip devices
In-Reply-To: <CANmRt2j4woAAg3dEtyQG4rjxRQ5Sx+4OW84Mathk4_YrFTjChQ@mail.gmail.com>
References: <1327075829-14346-1-git-send-email-lee.jones@linaro.org>
 <1327075829-14346-3-git-send-email-lee.jones@linaro.org>
 <20120120163947.GB4900@kroah.com>
 <CANmRt2j4woAAg3dEtyQG4rjxRQ5Sx+4OW84Mathk4_YrFTjChQ@mail.gmail.com>
Message-ID: <20120120181055.GA9999@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 05:14:00PM +0000, Lee Jones wrote:
> 
> 
> On Fri, Jan 20, 2012 at 4:39 PM, Greg KH <greg@kroah.com> wrote:
> 
>     On Fri, Jan 20, 2012 at 04:10:25PM +0000, Lee Jones wrote:
>     > +struct soc_device *soc_device_register(struct soc_device_attribute
>     *soc_dev_attr)
>     > +{
>     > + ? ? struct soc_device *soc_dev;
>     > + ? ? int ret;
>     > + ? ? int i, j = 0;
>     > +
>     > + ? ? soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
>     > + ? ? if (!soc_dev) {
>     > + ? ? ? ? ? ? ret = -ENOMEM;
>     > + ? ? ? ? ? ? goto out1;
>     > + ? ? }
> 
>     <snip>
> 
>     > +out1:
>     > + ? ? kfree(soc_dev_attr);
> 
>     You just freed the caller's memory, are you sure you wanted to do that?
> 
> 
> Yes, I think so. We free it if the register fails and in
> the?unregister?function.
> 
> I'd be happy to let the caller handle it if you think that's better.?

Well, you don't document anywhere that the pointer being passed in is
going to be freed, so either document it, or don't do that.

Odds are, you really don't want to do this, as it's going to be a
pointer to a static structure, right?  Calling kfree() on it is not a
good idea.

thanks,

greg k-h
