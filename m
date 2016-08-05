From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 05 Aug 2016 10:48:38 +0200
Subject: [PATCH v3 7/7] clk: rockchip: rk3399: Add support frac mode
 frequencies
In-Reply-To: <57A3F971.6000009@rock-chips.com>
References: <1470122401-31934-1-git-send-email-zhengxing@rock-chips.com>
 <12790025.3tRiQgk9GG@diego> <57A3F971.6000009@rock-chips.com>
Message-ID: <1786762.HqNHoLusdi@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

Am Freitag, 5. August 2016, 10:26:57 schrieb Xing Zheng:
> On 2016?08?05? 03:19, Heiko St?bner wrote:
> > Am Dienstag, 2. August 2016, 15:22:59 schrieb Xing Zheng:
> >> We need to support various display resolutions for external
> >> display devices like HDMI/DP, the frac mode can help us to
> >> acquire almost any frequencies, and need higher VCOs to reduce
> >> clock jitters.
> >> 
> >> Signed-off-by: Xing Zheng<zhengxing@rock-chips.com>
> > 
> > why does this need to be a separate rate array and cannot live in the
> > general pll rate array?
> > 
> > The plls are general purpose, so we shouldn't limit them arbitarily.
> 
> Yes, I understand your mean. :-)
> 
> > I currently only see some frequencies (594MHz, 297MHz, 54MHz) that are
> > present in both arrays but have different settings. As your patch
> > description says that these settings reduce clock jitter, wouldn't the
> > general frequencies also profit from merging these new values into the
> > general rate array?
> 
> and here are some of our ideas:
> 
> "WIth the frac mode and higher VCO to reduce clock jitters" that
> suggestion is from IC designer.
> There are many and various kinds resolution and needed frequencies for
> external disaplay devices. For example, the DP needs:
> 3840x2160 533250KHz
> 3840x2160 297000KHz
> 3840x2160 296703KHz
> 2560x1440 241500KHz
> 1920x1080 148500KHz
> 1920x1080 148352KHz
> 1680x1050 146250KHz
> 1600x900 108000KHz
> 1280x1024 135000KHz
> 1280x1024 108000KHz
> ... and so on
> 
> There some frequencies must be allocated with frac mode. We separate
> these frequencies that are only used for display (VPLL) from the general
> rate table, and put them to be classified into a frac mode table, we can
> reduce the frequency of the query time, the two rate tables will not
> interfere with each other. Because other PLLs don't need to assgin these
> various frequencies with frac mode.

Hmm, you're adding 14 frequencies to that new table (4 or so of them 
duplicating existing frequencies). So even if the effective number of new 
frequencies goes from now 10 to 20, I don't think walking that table will take 
an excessive time longer than now.

After the patch introducing the automatic rate calculation, the rate table we 
need to walk, will even get smaller.

Other components might also profit from the updated standard frequencies with 
less jitter you're introducing here.

And of course there is also the possibility somebody might want to build some 
rk3399 device without any graphics output at all [arm-server seem to be the 
new hype :-) ], so may want to use the vpll for something else completely.

So I still don't see an argument why it needs to be a separate table, as I 
currently don't see a case were it will really hurt the other PLLs.


Heiko
