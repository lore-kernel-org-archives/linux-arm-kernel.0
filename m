From: tiwai@suse.de (Takashi Iwai)
Date: Tue, 16 Feb 2016 17:18:29 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <2573932.AU4HSxN0NE@wuerfel>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de> <2573932.AU4HSxN0NE@wuerfel>
Message-ID: <s5h4md87hnu.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Feb 2016 17:09:43 +0100,
Arnd Bergmann wrote:
> 
> On Tuesday 16 February 2016 16:49:42 Takashi Iwai wrote:
> > 
> > Thanks for the patch.  But I think it's cleaner to fix Kconfig.
> > 
> > Thinking more of it, maybe splitting jack stuff as a separate module
> > and does reverse-select to CONFIG_INPUT would be better.  Then its
> > users can select simply SND_JACK, and everything would fit.
> > 
> > 
> 
> Adding 'select INPUT' is rather nasty, I think that can lead to circular
> dependencies, and would likely upset users of small embedded systems
> that want to use audio but don't want to use input.

Fair enough.

> Generally speaking, I would recommend never using 'select' on a user
> visible Kconfig symbol.
>
> Another option might would be to change snd_jack_new() to return
> an error if that SND_JACK is disabled, and then require all users
> to handle the error gracefully, i.e. not fail the probe() function
> but just not use the jack.

Yes, I thought of that, too.  If select is no good option, it's a good
alternative, indeed.


Takashi
