From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 20 Dec 2013 15:23:22 +0100
Subject: [PATCH 02/11] ASoC: ab8500: Revert back to find_next_bit()
In-Reply-To: <20131220140211.GG3709@lee--X1>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
 <1387468508-12286-3-git-send-email-lee.jones@linaro.org>
 <s5hd2kssu4g.wl%tiwai@suse.de> <20131219164824.GA16145@lee--X1>
 <s5hzjnwrbq2.wl%tiwai@suse.de> <20131220140211.GG3709@lee--X1>
Message-ID: <s5hpporr485.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Fri, 20 Dec 2013 14:02:11 +0000,
Lee Jones wrote:
> 
> > > > > Commit '166a34d ASoC: ab8500: Fix invalid cast to long pointer'
> > > > > rather carelessly converts find_next_bit() to fls() (find last
> > > > > bit set), which are not the same.
> > > > 
> > > > Does it break on the real machines?
> > > 
> > > It does, that's how I found the bug.
> > > 
> > > > fls() behaves differently from find_next_bit(), of course, but in this
> > > > case, it should work same in the end, since there are at most two
> > > > bits.
> > > 
> > > Unfortunately it doesn't work at all. This patch brings audio back to
> > > a working state. It took me the best part of a day to track down the
> > > issue. :(
> > 
> > Hmm, then isn't the original code rather buggy?
> > 
> > Check the values set there by ffs(), fls() and the original
> > find_next_bit(), especially whether find_next_bit() gives a valid
> > value fitting with the mask bits.
> 
> I wish I had the time to delve into exactly what's happening. All I
> can tell you is your patch broke audio and this one fixes it again. If
> you have time for a deep dive and produce a permanent solution I'd be
> much obliged and will of course test anything you send me. In the mean
> time, this patch should definitely be applied, as sound is crippled
> without it. 

The driver code was buggy from the beginning, but it looked as if
casually working in stereo mode.  May patch corrected things to what
it should be :)

I already have a fix patch, but need to check the information above at
first to see whether it can be used as is.  So, check the value set
there, and ffs(), fls() and find_next_bit() values.  Also, check
whether the stereo left/right channels are really output as expected
with the original driver code.


Takashi
