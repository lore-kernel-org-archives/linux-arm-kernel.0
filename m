From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 1 Aug 2016 15:52:46 +0200
Subject: [linux-sunxi] Re: [PATCH 2/3] mmc: sunxi: Set the 'New Timing'
 register for 8 bits DDR transfers
In-Reply-To: <9414aab0-ac2b-01c2-e16b-8f7394ea7b68@redhat.com>
References: <cover.1469082481.git.moinejf@free.fr>
 <bc7b767cad6db159a44c4b98d5b1f3eb53c26bd3.1469082481.git.moinejf@free.fr>
 <20160721085615.GG5993@lukather>
 <20160721112655.941b1dad04f7a5b94d4172c1@free.fr>
 <20160729191730.GG6215@lukather>
 <9414aab0-ac2b-01c2-e16b-8f7394ea7b68@redhat.com>
Message-ID: <20160801155246.b7b3c7f0f582394b4c25f6dc@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 30 Jul 2016 12:19:03 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Jean-Francois, can you submit a v2 of your patch and make the writing of
> SDXC_REG_NTSR depend on a new sun8i-a83t-mmc compatible ?
> 
> Also you should probably drop the bits about the clock stuff from the
> commit message as that just seems to confuse people.

Hi Hans,

I submitted a new patch (sorry, I forgot the history), but it asks for
some explanation.

- in the old timings, the phase delays are set in the clock.
  That's why there is a function clk_set_phase() which is called from
  the MMC side.

- in the new timings, the delays are in the MMC register SDXC_REG_NTSR
  only.
  In this case, the function clk_set_phase() is of no use
  (also, by test, it seems that the phase delays set by hardware
   reset do work, so, there is no need to set them), but,

- there is a bit in the clock telling that the new timings are used,
  i.e. that the phase delays of the clock must be ignored.

  Not setting this bit prevents the device to work (at least in the
  A83T, the H3 seems more helpful).

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
