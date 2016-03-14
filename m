From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Mon, 14 Mar 2016 12:52:54 +0200
Subject: [PATCH] media: add GFP flag to media_*() that could get called
 in atomic context
In-Reply-To: <20160314071358.27c87dab@recife.lan>
References: <1457833689-4926-1-git-send-email-shuahkh@osg.samsung.com>
 <20160314072236.GO11084@valkosipuli.retiisi.org.uk>
 <20160314071358.27c87dab@recife.lan>
Message-ID: <20160314105253.GQ11084@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro,

On Mon, Mar 14, 2016 at 07:13:58AM -0300, Mauro Carvalho Chehab wrote:
> Em Mon, 14 Mar 2016 09:22:37 +0200
> Sakari Ailus <sakari.ailus@iki.fi> escreveu:
> 
> > Hi Shuah,
> > 
> > On Sat, Mar 12, 2016 at 06:48:09PM -0700, Shuah Khan wrote:
> > > Add GFP flags to media_create_pad_link(), media_create_intf_link(),
> > > media_devnode_create(), and media_add_link() that could get called
> > > in atomic context to allow callers to pass in the right flags for
> > > memory allocation.
> > > 
> > > tree-wide driver changes for media_*() GFP flags change:
> > > Change drivers to add gfpflags to interffaces, media_create_pad_link(),
> > > media_create_intf_link() and media_devnode_create().
> > > 
> > > Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> > > Suggested-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>  
> > 
> > What's the use case for calling the above functions in an atomic context?
> > 
> 
> ALSA code seems to do a lot of stuff at atomic context. That's what
> happens on my test machine when au0828 gets probed before
> snd-usb-audio:
> 	http://pastebin.com/LEX5LD5K
> 
> It seems that ALSA USB probe routine (usb_audio_probe) happens in
> atomic context.

usb_audio_probe() grabs a mutex (register_mutex) on its own. It certainly
cannot be called in atomic context.

In the above log, what I did notice, though, was that because *we* grab
mdev->lock spinlock in media_device_register_entity(), we may not sleep
which is what the notify() callback implementation in au0828 driver does
(for memory allocation).

Could we instead replace mdev->lock by a mutex?

If there is no pressing need to implement atomic memory allocation I simply
wouldn't do it, especially in device initialisation where an allocation
failure will lead to probe failure as well.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
