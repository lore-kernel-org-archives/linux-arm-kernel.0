From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 1 Sep 2015 08:48:07 +0100
Subject: [PATCH v2 4/4] remoteproc: debugfs: Add ability to boot remote
 processor using debugfs
In-Reply-To: <55E07CE2.2050704@mentor.com>
References: <1440757911-9120-1-git-send-email-lee.jones@linaro.org>
 <1440757911-9120-5-git-send-email-lee.jones@linaro.org>
 <55E07CE2.2050704@mentor.com>
Message-ID: <20150901074807.GI4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Aug 2015, Nathan Lynch wrote:

> On 08/28/2015 05:31 AM, Lee Jones wrote:
> > +static ssize_t rproc_state_write(struct file *filp, const char __user *userbuf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	struct rproc *rproc = filp->private_data;
> > +	char buf[2];
> > +	int ret;
> > +
> > +	ret = copy_from_user(buf, userbuf, 1);
> > +	if (ret)
> > +		return -EFAULT;
> > +
> > +	switch (buf[0]) {
> > +	case '0':
> > +		rproc_shutdown(rproc);
> > +		break;
> > +	case '1':
> > +		ret = rproc_boot(rproc);
> > +		if (ret)
> > +			dev_warn(&rproc->dev, "Boot failed: %d\n", ret);
> > +		break;
> > +	default:
> > +		dev_err(&rproc->dev, "Unrecognised option: %x\n", buf[1]);
> > +		return -EINVAL;
> 
> This prints uninitialized kernel stack contents instead of what was
> copied from user space.

Yes, you're right.  I will conduct a better test of the failure path
here. 

> Is the dev_err statement really necessary anyway?

Yes.  As I described in my other mail, this interface is for Kernel
Engineers, who read the kernel log.

> > +	}
> > +
> > +	return count;
> > +}
> 
> If rproc_boot fails, that should be reflected in the syscall result.
> 
> This interface is essentially exposing the remoteproc->power refcount to
> user space; is that okay?  Seems like it makes it easy to underflow
> remoteproc->power through successive shutdown calls.

If the subsystem is suseptable to underruns someone should think about
adding protection against imbalances in the 'core'.

> The other debugfs interface in remoteproc that has a write method
> (recovery) accepts more expressive string commands as opposed to 0/1.
> It would be more consistent for this interface to take commands such as
> "boot" and "shutdown" IMO.

Agreed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
