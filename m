From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Fri, 10 Mar 2017 14:22:29 +0100
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170310130733.GU21222@n2100.armlinux.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <20170303230645.GR21222@n2100.armlinux.org.uk>
 <20170304131329.GV3220@valkosipuli.retiisi.org.uk>
 <a7b8e095-a95c-24bd-b1e9-e983f18061c4@xs4all.nl>
 <20170310130733.GU21222@n2100.armlinux.org.uk>
Message-ID: <c679f755-52a6-3c6f-3d65-277db46676cc@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/03/17 14:07, Russell King - ARM Linux wrote:
> On Fri, Mar 10, 2017 at 01:54:28PM +0100, Hans Verkuil wrote:
>> But there was always meant to be a layer (libv4l plugin) that could be
>> used to setup a 'default scenario' that existing applications could use,
>> but that was never enforced, sadly.
> 
> However, there's other painful issues lurking in userspace, particularly
> to do with the v4l libraries.
> 
> The idea that the v4l libraries should intercept the format negotiation
> between the application and kernel is a particularly painful one - the
> default gstreamer build detects the v4l libraries, and links against it.
> That much is fine.
> 
> However, the problem comes when you're trying to use bayer formats. The
> v4l libraries "helpfully" (or rather unhelpfully) intercept the format
> negotiation, and decide that they'll invoke v4lconvert to convert the
> bayer to RGB for you, whether you want them to do that or not.
> 
> v4lconvert may not be the most efficient way to convert, or even what
> is desired (eg, you may want to receive the raw bayer image.)  However,
> since the v4l libraries/v4lconvert gives you no option but to have its
> conversion forced into the pipeline, other options (such as using the
> gstreamer neon accelerated de-bayer plugin) isn't an option without
> rebuilding gstreamer _without_ linking against the v4l libraries.
> 
> At that point, saying "this should be done in a libv4l plugin" becomes
> a total nonsense, because if you need to avoid libv4l due to its
> stupidities, you don't get the benefit of subdevs, and it yet again
> _forces_ people down the route of custom applications.
> 
> So, I really don't agree with pushing this into a userspace library
> plugin - at least not with the current state there.
> 
> _At least_ the debayering in the v4l libraries needs to become optional.
> 

I *thought* that when a plugin is used the format conversion code was disabled.
But I'm not sure.

The whole problem is that we still don't have a decent plugin for an MC driver.
There is one for the exynos4 floating around, but it's still not accepted.

Companies write the driver, but the plugin isn't really needed since their
customers won't use it anyway since they make their own embedded driver.

And nobody of the media core developers has the time to work on the docs,
utilities and libraries you need to make this all work cleanly and reliably.

As mentioned, I will attempt to try and get some time to work on this
later this year. Fingers crossed.

We also have a virtual MC driver floating around. I've pinged the author if
she can fix the last round of review comments and post a new version. Having
a virtual driver makes life much easier when writing docs, utilities, etc.
since you don't need real hardware which can be hard to obtain and run.

Again, I agree completely with you. But we don't have many core developers
who can do something like this, and it's even harder for them to find the time.

Solutions on a postcard...

BTW, Steve: this has nothing to do with your work, it's a problem in our subsystem.

Regards,

	Hans
