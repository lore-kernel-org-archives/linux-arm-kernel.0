From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 12 Mar 2017 19:14:10 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170312073745.GI21222@n2100.armlinux.org.uk>
References: <20170310120902.1daebc7b@vento.lan>
 <5e1183f4-774f-413a-628a-96e0df321faf@xs4all.nl>
 <20170311101408.272a9187@vento.lan>
 <20170311153229.yrdjmggb3p2suhdw@ihha.localdomain>
 <acfb5eca-ff00-6d57-339a-3322034cbdb3@gmail.com>
 <20170311184551.GD21222@n2100.armlinux.org.uk>
 <1f1b350a-5523-34bc-07b7-f3cd2d1fd4c1@gmail.com>
 <20170311185959.GF21222@n2100.armlinux.org.uk>
 <4917d7fb-2f48-17cd-aa2f-d54b0f19ed6e@gmail.com>
 <20170312073745.GI21222@n2100.armlinux.org.uk>
Message-ID: <20170312181410.GA3124@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2017-03-12 07:37:45, Russell King - ARM Linux wrote:
> On Sat, Mar 11, 2017 at 07:31:18PM -0800, Steve Longerbeam wrote:
> > 
> > 
> > On 03/11/2017 10:59 AM, Russell King - ARM Linux wrote:
> > >On Sat, Mar 11, 2017 at 10:54:55AM -0800, Steve Longerbeam wrote:
> > >>
> > >>
> > >>On 03/11/2017 10:45 AM, Russell King - ARM Linux wrote:
> > >>>I really don't think expecting the user to understand and configure
> > >>>the pipeline is a sane way forward.  Think about it - should the
> > >>>user need to know that, because they have a bayer-only CSI data
> > >>>source, that there is only one path possible, and if they try to
> > >>>configure a different path, then things will just error out?
> > >>>
> > >>>For the case of imx219 connected to iMX6, it really is as simple as
> > >>>"there is only one possible path" and all the complexity of the media
> > >>>interfaces/subdevs is completely unnecessary.  Every other block in
> > >>>the graph is just noise.
> > >>>
> > >>>The fact is that these dot graphs show a complex picture, but reality
> > >>>is somewhat different - there's only relatively few paths available
> > >>>depending on the connected source and the rest of the paths are
> > >>>completely useless.
> > >>>
> > >>
> > >>I totally disagree there. Raw bayer requires passthrough yes, but for
> > >>all other media bus formats on a mipi csi-2 bus, and all other media
> > >>bus formats on 8-bit parallel buses, the conersion pipelines can be
> > >>used for scaling, CSC, rotation, and motion-compensated de-interlacing.
> > >
> > >... which only makes sense _if_ your source can produce those formats.
> > >We don't actually disagree on that.
> > 
> > ...and there are lots of those sources! You should try getting out of
> > your imx219 shell some time, and have a look around! :)
> 
> If you think that, you are insulting me.  I've been thinking about this
> from the "big picture" point of view.  If you think I'm only thinking
> about this from only the bayer point of view, you're wrong.

Can you stop that insults nonsense?

> Given what Mauro has said, I'm convinced that the media controller stuff
> is a complete failure for usability, and adding further drivers using it
> is a mistake.

Hmm. But you did not present any alternative. Seems some hardware is
simply complex. So either we don't add complex drivers (_that_ would
be a mistake), or some userspace solution will need to be
done. Shell-script running media-ctl does not seem that hard.

> So, tell me how the user can possibly use iMX6 video capture without
> resorting to opening up a terminal and using media-ctl to manually
> configure the pipeline.  How is the user going to control the source
> device without using media-ctl to find the subdev node, and then using
> v4l2-ctl on it.  How is the user supposed to know which /dev/video*
> node they should be opening with their capture application?

Complex hardware sometimes requires userspace configuration. Running a
shell script on startup does not seem that hard.

And maybe we could do some kind of default setup in kernel, but that
does not really solve the problem.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170312/1776bfee/attachment.sig>
