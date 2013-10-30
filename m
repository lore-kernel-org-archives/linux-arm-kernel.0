From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 30 Oct 2013 14:59:02 +0100
Subject: [PATCHv2 1/3] Input: twl4030-keypad - add device tree support
In-Reply-To: <20131030135307.D8CE1C402A0@trevor.secretlab.ca>
References: <1382446042-27099-1-git-send-email-sre@debian.org>
 <1382446042-27099-2-git-send-email-sre@debian.org>
 <20131027111715.GA2437@xo-6d-61-c0.localdomain>
 <20131027114026.GB14091@earth.universe>
 <20131027114753.GB14901@amd.pavel.ucw.cz>
 <20131030135307.D8CE1C402A0@trevor.secretlab.ca>
Message-ID: <20131030135902.GA2656@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2013-10-30 06:53:07, Grant Likely wrote:
> On Sun, 27 Oct 2013 12:47:53 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> > > > > +#if IS_ENABLED(CONFIG_OF)
> > > > I'm probably missing something here, but why not #ifdef CONFIG_OF?
> > > 
> > > I have been told for other drivers, that IS_ENABLED() is
> > > the prefered way to check for configuration these days.
> > 
> > CONFIG_OF can not be module, using IS_ENABLED() on it is just wrong.
> 
> That makes no sense. There is absolutely nothing wrong with using
> IS_ENABLED() for CONFIG_OF.

Besides being too long, confusing for a reader, and testing for an
option that can't exist?

include/linux/kconfig.h-/*
include/linux/kconfig.h: * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
include/linux/kconfig.h- * 0 otherwise.
include/linux/kconfig.h- *
include/linux/kconfig.h- */
include/linux/kconfig.h:#define IS_ENABLED(option) \
include/linux/kconfig.h-	(config_enabled(option) || config_enabled(option##_MODULE))
include/linux/kconfig.h-
include/linux/kconfig.h-/*
include/linux/kconfig.h- * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
include/linux/kconfig.h- * otherwise. For boolean options, this is
equivalent to
include/linux/kconfig.h: * IS_ENABLED(CONFIG_FOO).
include/linux/kconfig.h- */
include/linux/kconfig.h-#define IS_BUILTIN(option) config_enabled(option)
include/linux/kconfig.h-

Oops. And I made a mistake of looking up config_enabled(). Obfuscated
C code contest.

Just use #ifdef CONFIG_foo.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
