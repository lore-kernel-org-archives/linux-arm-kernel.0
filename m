From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 20 Feb 2015 10:50:04 +0100
Subject: [PATCH] ARM: OMAP2+: Return correct error values from device and
 hwmod
In-Reply-To: <20150220082226.GB14057@amd>
References: <1424389302-24380-1-git-send-email-pali.rohar@gmail.com>
 <20150220082226.GB14057@amd>
Message-ID: <201502201050.04334@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 February 2015 09:22:26 Pavel Machek wrote:
> On Fri 2015-02-20 00:41:41, Pali Roh?r wrote:
> > Without this patch function pm_runtime_get_sync() returns 0
> > even when some omap subfunction fails. This patch properly
> > propagate error codes from omap functions back to caller.
> > 
> > This patch fix problem, when loading omap-aes driver in qemu
> > cause kernel oops.
> 
> "fixes"
> 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> > @@ -3350,16 +3350,17 @@ int omap_hwmod_enable(struct
> > omap_hwmod *oh)
> > 
> >   */
> >  
> >  int omap_hwmod_idle(struct omap_hwmod *oh)
> >  {
> > 
> > +	int r;
> > 
> >  	unsigned long flags;
> >  	
> >  	if (!oh)
> >  	
> >  		return -EINVAL;
> >  	
> >  	spin_lock_irqsave(&oh->_lock, flags);
> > 
> > -	_idle(oh);
> > +	r = _idle(oh);
> > 
> >  	spin_unlock_irqrestore(&oh->_lock, flags);
> > 
> > -	return 0;
> > +	return r;
> > 
> >  }
> 
> Normally, such variable is called ret or res...
> 
> 									Pavel

In other parts of this code is used name "r" not "ret".

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150220/66029e73/attachment.sig>
