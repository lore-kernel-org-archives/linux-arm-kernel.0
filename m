From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 17 Oct 2012 20:58:57 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: Only write the sysconfig on idle when
 necessary
In-Reply-To: <507F16F5.9020803@ti.com>
References: <1350504742-19995-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1210172023130.9767@utopia.booyaka.com>
 <507F16F5.9020803@ti.com>
Message-ID: <alpine.DEB.2.00.1210172046100.9767@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Oct 2012, Jon Hunter wrote:

> Are you looking to go one step further and only update the sysconfig on
> enabling when the context has been lost? That would require more
> changes.

Yes that's exactly it.  That would avoid adding a special case for what 
should be the common case.  From a quick glance it looks like the cache 
needs to be loaded in _reset(), omap_hwmod_softreset(), and _enable().  
Other than that, seems like the cached value should work.

It should also be possible to avoid the reload in _enable() in most cases 
since the PM code should know whether the IP block's powerdomain was 
programmed to go off and indeed whether it did so.  It shouldn't involve 
any extra register reads.  But I wouldn't expect you to add that 
optimization; would just be nice to have a comment to that effect.

If the meta-theme of your message is that commit 
233cbe5b94096f95ba7bca2162d63275b0b90b5b should have had closer scrutiny, 
I agree with you, but we're beyond that point now...


- Paul
