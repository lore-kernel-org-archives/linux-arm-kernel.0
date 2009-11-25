From: daniel@caiaq.de (Daniel Mack)
Date: Wed, 25 Nov 2009 13:24:36 +0100
Subject: [PATCH 16/17] ALSA: ARM: add Raumfeld audio support
In-Reply-To: <20091125110218.GD17420@opensource.wolfsonmicro.com>
References: <1259145751-3331-1-git-send-email-daniel@caiaq.de>
	<1259145751-3331-17-git-send-email-daniel@caiaq.de>
	<20091125110218.GD17420@opensource.wolfsonmicro.com>
Message-ID: <20091125122436.GI29442@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2009 at 11:02:18AM +0000, Mark Brown wrote:
> 
> > +static struct i2c_board_info max9486_hwmon_info = {
> > +	I2C_BOARD_INFO("max9485", 0x63),
> > +};
> 
> This should be in the board file under arch/arm.

Well, the problem is that if I do it there, I don't get a handle for the
actual data transfer, which I now get from i2c_new_device(). There is no
driver matching this device (it wasn't taken because it's 'too simple').

How would I get a handle to pass to i2c_master_send() or an equivalent
function?

> > +extern void raumfeld_enable_audio(bool en);
> 
> This should be in a proper header file somewhere.

Hmm, I thought so too, but it would be the only thing to add there.
Hence I decided to not do that. You really prefer that?

> > +static void raumfeld_cs4270_shutdown(struct snd_pcm_substream *substream)
> > +{
> > +}
> > +
> 
> Remove this and the other empty functions.

Hmm, I tried that and it crashed the kernel. I will check again as that
was some month ago.

> > +	case 96000:
> > +		set_max9485_clk(1);
> 
> It might be a bit more legible to have some constants for the arguments
> for this function - it's not entirely clear what's going on, the 1 and 0
> look like a boolean but that's not what's really going on here.  It may
> be better to do this as a proper driver, there was at least one driver I
> remember being posted for a TDM clock generator which I think got
> merged.

No, it wasn't.

  http://marc.info/?l=linux-i2c&m=122457836326525&w=2

Jean Delvare's last comment on this was:

> Honestly I don't see any value in this driver. There's nothing you can
> do with it that you couldn't already do without it.

The driver itself would do the right thing, but I doubt that
resubmitting will help much.

Daniel
