From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 15 Jan 2017 11:05:33 +0100
Subject: Nokia N900: mixers changed between 4.9 and 4.10-rc3, no longer
 can use in-call speaker
In-Reply-To: <201701150100.54214@pali>
References: <20170112181826.GA28290@amd> <201701121934.19810@pali>
 <20170114225614.GA25321@amd> <201701150100.54214@pali>
Message-ID: <20170115100533.GA15816@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Both are based on v4.7-rc1. v4.6 worked ok for me.
> > 
> > Lets test mini-v4.7: in-call speaker works ok there, and no alsactl
> > warnings.
> > 
> > mini-v4.7+cb7e62256e99d285e415cf75db67558f0f8bb107+6d2de5ab4328718302
> > c54b20222c6b1a574c3fce
> > 
> > : something seems to be broken there already.
> > 
> > alsactl: set_control:1464: Cannot write control '2:0:0:TPA6130A2
> > Headphone Playback Volume:0' : Remote I/O error
> > 
> > But in-call speakers and wired headset still seems to work.
> > 
> > Lets test mini-v4.9... works ok. I don't even get the remote i/o
> > error. Interesting.
> > 
> > So regression seems to be between v4.9 and v4.10. Any ideas?
> 
> Interesting... seems there are no sound relevant changes after v4.9.
> 
> Looks like there are only three commits after v4.9 for sound/soc which 
> are built for Nokia N900:
> 
> e411b0b5eb9b65257a050eac333d181d6e00e2c6
> e7aa450fe17890e59db7d3c2d8eff5b6b41fc531
> 63c3194b82530bd71fd49db84eb7ab656b8d404a
> 
> Maybe something not related to sound/soc could broke it?

Lets see.

a9042defa29a01cc538b742eab047848e9b5ae14 -- works ok.
ce38207f161513ee3d2bd3860489f07ebe65bc78 --

alsactl: set_control:1328: failed to obtain info for control #229 (No
such file or directory)

and broken in-call speaker. So this merge breaks stuff:

commit ce38207f161513ee3d2bd3860489f07ebe65bc78
Merge: a9042de 995c6a7
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Dec 14 11:14:28 2016 -0800

    Merge tag 'sound-4.10-rc1' of
    git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound
...
      Below are some highlights:

      ASoC:
             - support for stereo DAPM controls
	            - some initial work on the of-graph sound card
		           - regmap conversions of the remaining AC'97
      drivers
             - a new version of the topology ABI; this should be
      backward
               compatible
	              - updates / cleanups of rsnd, sunxi, sti,
      nau8825, samsung, arizona,
               Intel skylake, atom-sst
	              - new drivers for Cirrus Logic CS42L42, Qualcomm
      MSM8916-WCD, and
               Realtek RT5665
...

Best regards,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170115/2c305712/attachment.sig>
