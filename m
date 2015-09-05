From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 5 Sep 2015 15:01:36 +0100
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083107.GK21084@n2100.arm.linux.org.uk>
 <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
Message-ID: <20150905140136.GM21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 05, 2015 at 06:46:04AM -0700, Doug Anderson wrote:
> Russell,
> 
> On Sat, Sep 5, 2015 at 1:31 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Sep 04, 2015 at 07:03:11PM -0700, Doug Anderson wrote:
> >> AKA: just replace your entire "compute_n" function with:
> >>
> >> return (128 * freq) / 1000;
> >>
> >> ...and it's 100% simpler _and_ gets you a (marginally) better rate
> >> (assuming you really have 22.175000).  If it was just about a
> >> 32000.222 vs 32000 I'd not be saying anything right now.  It's about
> >> adding complexity.
> >
> > No.  It doesn't work for all cases.  Do the calculations for every
> > sample rate in those tables in the HDMI spec, and you'll find out
> > why.
> 
> If you know the answer, just tell me.  If you're talking about 74.25
> vs. 32 kHz it is further evidence of what I'm saying.  Note that
> picking only one of the two listed CTS values again puts you in a
> worse position for regenerating the proper audio clock then just using
> the default N=4096.

No it doesn't.

74.25MHz/1.001 * 4096 / (128 * 32000) = 74175 (rounded down)

Now do the calcuation.

(74.25MHz/1.001) / 74175 * 4096 = 4096045.511 => 32000.35556Hz
	=> error of 0.001111%

Now for the calcuation using the proscribed figures.

(74.25MHz/1.001) / 210937 * 11648 = 4096009.709 => 32000.07585Hz
	=> error of 0.000237%

That's significantly less error using that than your "better" idea.
Now, if we take the pixel clock rate as 74.175MHz, which is just a
representation of 74.25MHz/1.001:

74.175MHz / 210937 * 11648 = 4095964.198 => 31999.72029Hz
	=> error of 0.0008741%

That's still lower than your "better" idea.

And as I've already said, the pixel clock rate given to us here will
be the _specified_ clock rate of 74.175MHz, *not* some cocked up
platform screwed crap that you think we will.  It _will_ be 74175
not 74170 or some other shite like that.

Right, I've had enough.  I'm going to be ignoring this thread from now
on, this is a waste of my time - you clearly have no understanding of
what's going on here.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
