From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 10 Aug 2012 18:39:11 +0300
Subject: [alsa-devel] [PATCH 08/11] ARM: OMAP3: Remove callback for McBSP
 sidetone ICLK workaround
In-Reply-To: <502505D4.2030308@bitmer.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <1344417101-5015-9-git-send-email-peter.ujfalusi@ti.com>
 <502268B1.9040506@bitmer.com> <50227104.3040506@ti.com>
 <502505D4.2030308@bitmer.com>
Message-ID: <50252B1F.2040107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jarkko,

On 08/10/2012 04:00 PM, Jarkko Nikula wrote:
> I got some odd current consumption results from Beagle to really compare
> different kernel versions but I was able get sensible results from N900.

I still use my n900 as a main phone so I can not really hack on it :(

> I tested your set on top of 196973c of sound.git.
> 
> First consumption when using threshold based transfer has remained the
> same between 2.6.38-3.6.0-rc1 (wau!).

Cool!

> Active sidetone under "arecord -f
> dat >/dev/null |aplay -f dat /dev/zero" test increases consumption from
> plain playback about 17 mA in 3.4 and 3.6.0-rc1.
> 
> With your set applied consumption increases 28 mA when the sidetone is
> active (i.e. +11 mA higher than on top of 196973c). Plain threshold
> based playback remains still the same.

Oh. 11mA is huge... Really strange. I would expected smaller (actually zero)
difference since in essence both workaround should be doing the same.
Only if the OMAP pm core making different decisions runtime when it see that
the no-idle is selected in the SYSCONFIG register of McBSP2. But the
autogating of clocks should work without SW.

So it seams that we need to do this down at PRCM level?

>> I'm doing the same test on BeagleBoard, but this thing does not want to hit
>> retention despite all the effort :(
>>
> Could it be display subsystem which keeps it active? At least on N900 I
> need to get DSS drivers activated in order to be able to blank the
> display after bootloader and thus be able to reach the retention idle.

I tried that as well, but nothing helps. It must be something else which I
have overlooked...

-- 
P?ter
