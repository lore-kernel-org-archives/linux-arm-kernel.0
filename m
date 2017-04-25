From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Apr 2017 10:05:38 +0200
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <20170424224724.5bb52382@vento.lan>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan> <20170424212914.GA20780@amd>
 <20170424224724.5bb52382@vento.lan>
Message-ID: <20170425080538.GA30380@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > For focus to be useful, we need autofocus implmented
> > > > somewhere. Unfortunately, v4l framework does not seem to provide good
> > > > place where to put autofocus. I believe, long-term, we'll need some
> > > > kind of "video server" providing this kind of services.
> > > > 
> > > > Anyway, we probably don't want autofocus in kernel (even through some
> > > > cameras do it in hardware), and we probably don't want autofocus in
> > > > each and every user application.
> > > > 
> > > > So what remains is libv4l2.   
> > > 
> > > IMO, the best place for autofocus is at libv4l2. Putting it on a
> > > separate "video server" application looks really weird for me.  
> > 
> > Well... let me see. libraries are quite limited -- it is hard to open
> > files, or use threads/have custom main loop. It may be useful to
> > switch resolutions -- do autofocus/autogain at lower resolution, then
> > switch to high one for taking picture. It would be good to have that
> > in "system" code, but I'm not at all sure libv4l2 design will allow
> > that.
> 
> I don't see why it would be hard to open files or have threads inside
> a library. There are several libraries that do that already, specially
> the ones designed to be used on multimidia apps.

Well, fd's are hard, because application can do fork() and now
interesting stuff happens. Threads are tricky, because now you have
locking etc.

libv4l2 is designed to be LD_PRELOADED. That is not really feasible
with "complex" library.

> > It would be good if application could say "render live camera into
> > this window" and only care about user interface, then say "give me a
> > high resolution jpeg". But that would require main loop in the
> > library...
> 
> Nothing prevents writing an upper layer on the top of libv4l in
> order to provide such kind of functions.

Agreed.

> > It would be nice if more than one application could be accessing the
> > camera at the same time... (I.e. something graphical running preview
> > then using command line tool to grab a picture.) This one is
> > definitely not solveable inside a library...
> 
> Someone once suggested to have something like pulseaudio for V4L.
> For such usage, a server would be interesting. Yet, I would code it
> in a way that applications using libv4l will talk with such daemon
> in a transparent way.

Yes, we need something like pulseaudio for V4L. And yes, we should
make it transparent for applications using libv4l.

Regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/576eccb4/attachment.sig>
