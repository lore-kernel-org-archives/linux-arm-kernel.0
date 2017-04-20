From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Apr 2017 16:39:57 +0200
Subject: [PATCH v4 05/11] drm/sun4i: abstract a engine type
In-Reply-To: <5F52665D-8A24-40D3-B84B-E8991B3BE457@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-6-icenowy@aosc.io>
 <20170418085548.4cisone2yfcuizcp@lukather>
 <5F52665D-8A24-40D3-B84B-E8991B3BE457@aosc.io>
Message-ID: <20170420143957.t4vppaeydlaeocgh@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 07:05:12PM +0800, Icenowy Zheng wrote:
> >> @@ -56,7 +55,7 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc
> >*crtc,
> >>  
> >>  	DRM_DEBUG_DRIVER("Committing plane changes\n");
> >>  
> >> -	sun4i_backend_commit(scrtc->backend);
> >> +	scrtc->engine_ops->commit(scrtc->engine);
> >
> >You rely on the backend having setup things properly, which is pretty
> >fragile. Ideally, you should have a function to check that engine_ops
> >and commit is !NULL, and call it, and the consumers would use that
> >function...
> 
> If it's really NULL how should the function return?

It depends on the return code. ENOSYS if it returns an int, and simply
does nothing if it's a void. I don't think any of the current
functions return an error code at the moment though, so I'd just keep
the current behaviour and just call the function if it's set.

You cannot fail in atomic_flush anyway.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170420/92199a8f/attachment.sig>
