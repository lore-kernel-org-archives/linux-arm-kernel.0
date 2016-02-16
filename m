From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 16 Feb 2016 17:09:43 +0100
Subject: [PATCH] sound: hdmi: avoid dereferencing uninitialized 'jack'
 pointer
In-Reply-To: <s5hbn7g7izt.wl-tiwai@suse.de>
References: <1455634059-1896914-1-git-send-email-arnd@arndb.de>
 <s5hbn7g7izt.wl-tiwai@suse.de>
Message-ID: <2573932.AU4HSxN0NE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 16 February 2016 16:49:42 Takashi Iwai wrote:
> 
> Thanks for the patch.  But I think it's cleaner to fix Kconfig.
> 
> Thinking more of it, maybe splitting jack stuff as a separate module
> and does reverse-select to CONFIG_INPUT would be better.  Then its
> users can select simply SND_JACK, and everything would fit.
> 
> 

Adding 'select INPUT' is rather nasty, I think that can lead to circular
dependencies, and would likely upset users of small embedded systems
that want to use audio but don't want to use input.

Generally speaking, I would recommend never using 'select' on a user
visible Kconfig symbol.

Another option might would be to change snd_jack_new() to return
an error if that SND_JACK is disabled, and then require all users
to handle the error gracefully, i.e. not fail the probe() function
but just not use the jack.

	Arnd
