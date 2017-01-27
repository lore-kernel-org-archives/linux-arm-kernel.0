From: kraxel@redhat.com (Gerd Hoffmann)
Date: Fri, 27 Jan 2017 11:28:32 +0100
Subject: [PATCH 01/13] mmc: bcm2835: add bcm2835_read_wait_sdcmd
In-Reply-To: <ff0170ef-2566-1c12-0b27-dccb3bff2e7e@rock-chips.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-2-git-send-email-kraxel@redhat.com>
 <ff0170ef-2566-1c12-0b27-dccb3bff2e7e@rock-chips.com>
Message-ID: <1485512912.19754.60.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

> > +	for (;;) {
> > +		value = readl(host->ioaddr + SDCMD);
> > +		if (!(value & SDCMD_NEW_FLAG))
> > +			break;
> > +		if (check_fail && (value & SDCMD_FAIL_FLAG))
> > +			break;
> > +		if (time_after(jiffies, end)) {
> > +			dev_err(dev, "%s: timeout (%d us)\n",
> > +				__func__, timeout);
> > +			break;
> > +		}
> > +
> > +		/* if it takes longer reduce poll interval */
> > +		if (time_after(jiffies, fastpoll))
> > +			udelay(10);
> > +		else
> > +			cpu_relax();
> > +	}
> 
> Use readl_poll_timeout intead of open-coding them..

Cool.  Didn't know this exists.  Incremental fixup attached.

thanks,
  Gerd

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-mmc-bcm2835-use-readl_poll_timeout-in-bcm2835_read_w.patch
Type: text/x-patch
Size: 2245 bytes
Desc: 
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/320c74c6/attachment.bin>
