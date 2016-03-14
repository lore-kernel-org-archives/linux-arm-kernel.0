From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 14 Mar 2016 11:33:25 +0100
Subject: [PATCH] media: add GFP flag to media_*() that could get called in
 atomic context
In-Reply-To: <20160314071358.27c87dab@recife.lan>
References: <1457833689-4926-1-git-send-email-shuahkh@osg.samsung.com>
 <20160314072236.GO11084@valkosipuli.retiisi.org.uk>
 <20160314071358.27c87dab@recife.lan>
Message-ID: <s5hmvq14adm.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Mar 2016 11:13:58 +0100,
Mauro Carvalho Chehab wrote:
> 
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

No, usb_audio_probe() doesn't take a lock.  But
media_device_register_entity() seems taking a spinlock, instead.


Takashi
