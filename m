From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 18:09:20 +0100
Subject: [PATCH v2] drm/i2c: tda998x: Fix bad checksum of the HDMI AVI
 infoframe
In-Reply-To: <20150804230153.GT7557@n2100.arm.linux.org.uk>
References: <E1ZK5bb-00079F-WC@bombadil.infradead.org>
 <20150804080557.58244c7c@armhf>
 <20150804230153.GT7557@n2100.arm.linux.org.uk>
Message-ID: <20150805170920.GA7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 12:01:53AM +0100, Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2015 at 08:05:57AM +0200, Jean-Francois Moine wrote:
> > On Tue, 28 Jul 2015 15:59:17 +0200
> > Jean-Francois Moine <moinejf@free.fr> wrote:
> > 
> > > Using hdmi_avi_infoframe_pack() to create the AVI infoframe calculates
> > > the checksum of the frame and breaks the second calculation which is
> > > done in tda998x_write_if(). Then the HDMI AVI frame is wrong and
> > > the display device does not handle correctly the video frames.
> > > 
> > > Fixes: 8c7a075da9f7980c ("use drm_hdmi_avi_infoframe_from_display_mode()")
> > > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > 
> > Ping!
> 
> I applied the patch a while back (July 17th to be exact) and in the queue
> to be sent - I'll update the commit message prior to doing that.  Thanks.

I've been able to get my hands on an AV amp, and I was hoping to use
that to validate things like the info frames.  Having investigated
today, while I'm able to get information from it, it's not as complete
as I'd like - for example, it gives me for the AVI:

	82 02 0D 12 28 08 1F 00 00 00 00 00 00 00 00 00

which is the CEA-861-D AVI, not the HDMI AVI (it's missing the checksum
between bytes 2 and 3).  Even more unfortunate is that it accepts the
transmitted AVI frame whether or not the checksum is valid.  However,
the AV amp reports that it sends the AVI frame onto the TV with a correct
checksum:

	82 02 0D 0E 12 28 08 1F ...

What this means is that I now have a way to read the various control
packets on HDMI, but not with their checksums, and no way to validate
whether the checksums are correct.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
